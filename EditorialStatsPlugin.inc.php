<?php
/**
 * @file EditorialStatsPlugin.inc.php
 *
 * Copyright (c) 2026 Indaka Barody
 * Distributed under the GNU GPL v3.
 *
 * @class EditorialStatsPlugin
 * @brief Plugin class for the Editorial Stats plugin.
 */

use Illuminate\Database\Capsule\Manager as Capsule;

import('lib.pkp.classes.plugins.GenericPlugin');

class EditorialStatsPlugin extends GenericPlugin
{
    /**
     * @copydoc Plugin::register()
     */
    public function register($category, $path, $mainContextId = null)
    {
        $success = parent::register($category, $path, $mainContextId);
        if ($success && $this->getEnabled()) {
            $request = Application::get()->getRequest();
            $context = $request->getContext();
            $contextId = $context ? (int) $context->getId() : (int) $mainContextId;

            $displayMode = $this->getSetting($contextId, 'es_displayMode');
            if (!$displayMode) {
                $displayMode = 'homepage';
            }

            if ($displayMode === 'homepage') {
                HookRegistry::register('Templates::Index::journal', [$this, 'displayStatsHomepage']);
            } else {
                HookRegistry::register('LoadHandler', [$this, 'callbackHandleContent']);
                if ($displayMode === 'dashboard') {
                    HookRegistry::register('TemplateManager::setupBackendPage', [$this, 'setupBackendPage']);
                }
            }
        }
        return $success;
    }

    public function callbackHandleContent($hookName, $args)
    {
        $page = &$args[0];
        if ($page === 'editorialStats') {
            define('HANDLER_CLASS', 'EditorialStatsHandler');
            $this->import('EditorialStatsHandler');
            EditorialStatsHandler::setPlugin($this);
            return true;
        }
        return false;
    }

    public function setupBackendPage($hookName, $args)
    {
        $request = Application::get()->getRequest();
        $templateMgr = TemplateManager::getManager($request);
        $menu = $templateMgr->getState('menu');

        if (isset($menu['statistics']['submenu'])) {
            $router = $request->getRouter();

            $menu['statistics']['submenu']['editorialStats'] = [
                'name' => $this->getDisplayName(),
                'url' => $router->url($request, null, 'editorialStats'),
                'isCurrent' => $router->getRequestedPage($request) === 'editorialStats',
            ];

            $templateMgr->setState(['menu' => $menu]);
        }
        return false;
    }

    /**
     * Provide a name for this plugin
     * @return string
     */
    public function getDisplayName()
    {
        return __('plugins.generic.editorialStats.displayName');
    }

    /**
     * Provide a description for this plugin
     * @return string
     */
    public function getDescription()
    {
        return __('plugins.generic.editorialStats.description');
    }

    /**
     * Add a settings action to the plugin's entry in the
     * plugins list.
     */
    public function getActions($request, $actionArgs)
    {
        $actions = parent::getActions($request, $actionArgs);
        if (!$this->getEnabled()) {
            return $actions;
        }

        $router = $request->getRouter();
        import('lib.pkp.classes.linkAction.request.AjaxModal');
        $linkAction = new LinkAction('settings', new AjaxModal($router->url($request, null, null, 'manage', null, ['verb' => 'settings', 'plugin' => $this->getName(), 'category' => 'generic']), $this->getDisplayName()), __('manager.plugins.settings'), null);
        array_unshift($actions, $linkAction);
        return $actions;
    }

    /**
     * Show and save the settings form when the settings action
     * is clicked.
     */
    public function manage($args, $request)
    {
        if ($request->getUserVar('verb') === 'settings') {
            $this->import('EditorialStatsSettingsForm');
            $form = new EditorialStatsSettingsForm($this, $request->getContext()->getId());
            if (!$request->getUserVar('save')) {
                $form->initData();
                return new JSONMessage(true, $form->fetch($request));
            }
            $form->readInputData();
            if ($form->validate()) {
                $form->execute();
                return new JSONMessage(true);
            }
        }
        return parent::manage($args, $request);
    }

    /**
     * Callback to display stats on the journal homepage
     */
    public function getStatsData($contextId)
    {
        // Submission Constants (from PKPSubmission.inc.php)
        $STATUS_QUEUED = 1;
        $STATUS_PUBLISHED = 3;
        $STATUS_DECLINED = 4;

        // 1. Total submissions
        $totalSubmissions = Capsule::table('submissions')->where('context_id', $contextId)->count();

        // 2. Published
        $published = Capsule::table('submissions')->where('context_id', $contextId)->where('status', $STATUS_PUBLISHED)->count();

        // 3. In Progress (Queued)
        $inProgress = Capsule::table('submissions')->where('context_id', $contextId)->where('status', $STATUS_QUEUED)->count();

        // 4. Declined
        $declined = Capsule::table('submissions')->where('context_id', $contextId)->where('status', $STATUS_DECLINED)->count();

        // 5. Acceptance rate
        $resolved = $published + $declined;
        $acceptanceRate = $resolved > 0 ? round(($published / $resolved) * 100, 1) : 0;

        // 6. Avg days to publish
        $publishedSubmissions = Capsule::table('submissions as s')->join('publications as p', 's.submission_id', '=', 'p.submission_id')->where('s.context_id', $contextId)->where('s.status', $STATUS_PUBLISHED)->whereNotNull('p.date_published')->select('s.date_submitted', 'p.date_published')->get();

        $totalDays = 0;
        $publishedCount = 0;
        foreach ($publishedSubmissions as $row) {
            if ($row->date_submitted && $row->date_published) {
                $dateSub = strtotime($row->date_submitted);
                $datePub = strtotime($row->date_published);
                $diffDays = round(abs($datePub - $dateSub) / 86400);
                $totalDays += $diffDays;
                $publishedCount++;
            }
        }
        $avgDaysToPublish = $publishedCount > 0 ? round($totalDays / $publishedCount) : 0;

        // 7. Reviews completed
        $reviewsCompleted = Capsule::table('review_assignments as r')->join('submissions as s', 'r.submission_id', '=', 's.submission_id')->where('s.context_id', $contextId)->whereNotNull('r.date_completed')->where('r.declined', 0)->count();

        // 8. Active reviewers
        $activeReviewers = Capsule::table('review_assignments as r')->join('submissions as s', 'r.submission_id', '=', 's.submission_id')->where('s.context_id', $contextId)->whereNull('r.date_completed')->where('r.declined', 0)->distinct('r.reviewer_id')->count('r.reviewer_id');

        // 9. Submissions per year
        $allSubmissions = Capsule::table('submissions')->where('context_id', $contextId)->select('date_submitted')->get();

        $subsPerYear = [];
        foreach ($allSubmissions as $row) {
            if ($row->date_submitted) {
                $year = date('Y', strtotime($row->date_submitted));
                if (!isset($subsPerYear[$year])) {
                    $subsPerYear[$year] = 0;
                }
                $subsPerYear[$year]++;
            }
        }
        ksort($subsPerYear);

        $yearsList = array_keys($subsPerYear);
        $countsList = array_values($subsPerYear);

        // 10. Published Articles per Section
        $contextDao = Application::getContextDAO();
        $context = $contextDao->getById($contextId);
        $currentLocale = AppLocale::getLocale();
        $primaryLocale = $context ? $context->getPrimaryLocale() : $currentLocale;

        $publishedArticles = Capsule::table('submissions as s')
            ->join('publications as p', 'p.submission_id', '=', 's.submission_id')
            ->join('sections as sec', 'p.section_id', '=', 'sec.section_id')
            ->leftJoin('section_settings as ss', function ($join) use ($currentLocale, $primaryLocale) {
                $join
                    ->on('ss.section_id', '=', 'sec.section_id')
                    ->where('ss.setting_name', '=', 'title')
                    ->whereIn('ss.locale', [$currentLocale, $primaryLocale]);
            })
            ->where('s.context_id', $contextId)
            ->where('s.status', $STATUS_PUBLISHED)
            ->select('sec.section_id', 'ss.setting_value as section_title', 'ss.locale')
            ->get();

        $articlesPerSection = [];
        foreach ($publishedArticles as $article) {
            // Prefer current locale title, fallback to primary locale
            $titleId = $article->section_id;
            if (!isset($articlesPerSection[$titleId])) {
                $articlesPerSection[$titleId] = [
                    'title' => $article->section_title ?: 'Unknown Section',
                    'count' => 0,
                    'locale' => $article->locale,
                ];
            } else {
                // If we find the current locale title and the existing one was primary locale, overwrite
                if ($article->locale == $currentLocale && $articlesPerSection[$titleId]['locale'] != $currentLocale) {
                    $articlesPerSection[$titleId]['title'] = $article->section_title ?: 'Unknown Section';
                    $articlesPerSection[$titleId]['locale'] = $article->locale;
                }
            }
            $articlesPerSection[$titleId]['count']++;
        }

        // Extract final list
        $sectionsData = [];
        foreach ($articlesPerSection as $data) {
            $sectionsData[] = [
                'title' => $data['title'],
                'count' => $data['count'],
            ];
        }

        // Sort by count descending
        usort($sectionsData, function ($a, $b) {
            return $b['count'] - $a['count'];
        });

        return [
            'es_totalSubmissions' => $totalSubmissions,
            'es_published' => $published,
            'es_inProgress' => $inProgress,
            'es_declined' => $declined,
            'es_acceptanceRate' => $acceptanceRate,
            'es_avgDaysToPublish' => $avgDaysToPublish,
            'es_reviewsCompleted' => $reviewsCompleted,
            'es_activeReviewers' => $activeReviewers,
            'es_yearsList' => json_encode($yearsList),
            'es_countsList' => json_encode($countsList),
            'es_subsPerYear' => $subsPerYear,
            'es_sectionsData' => $sectionsData
        ];
    }

    public function displayStatsHomepage($hookName, $params)
    {
        $smarty = &$params[1];
        $output = &$params[2];

        $request = Application::get()->getRequest();
        $context = $request->getContext();
        if (!$context) {
            return false;
        }

        $contextId = (int) $context->getId();

        $statsData = $this->getStatsData($contextId);
        $smarty->assign($statsData);

        // Settings
        $smarty->assign([
            'es_showTotalSubmissions' => $this->getSetting($contextId, 'es_showTotalSubmissions') ?? true,
            'es_showPublished' => $this->getSetting($contextId, 'es_showPublished') ?? true,
            'es_showInProgress' => $this->getSetting($contextId, 'es_showInProgress') ?? true,
            'es_showDeclined' => $this->getSetting($contextId, 'es_showDeclined') ?? true,
            'es_showAcceptanceRate' => $this->getSetting($contextId, 'es_showAcceptanceRate') ?? true,
            'es_showAvgDaysToPublish' => $this->getSetting($contextId, 'es_showAvgDaysToPublish') ?? true,
            'es_showReviewsCompleted' => $this->getSetting($contextId, 'es_showReviewsCompleted') ?? true,
            'es_showActiveReviewers' => $this->getSetting($contextId, 'es_showActiveReviewers') ?? true,
            'es_showSubmissionsPerYear' => $this->getSetting($contextId, 'es_showSubmissionsPerYear') ?? true,
            'es_showPublishedPerSection' => $this->getSetting($contextId, 'es_showPublishedPerSection') ?? true,
        ]);

        $templatePath = $this->getTemplateResource('frontend/stats.tpl');
        $output .= $smarty->fetch($templatePath);

        return false;
    }
}
