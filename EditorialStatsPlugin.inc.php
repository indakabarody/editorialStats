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
            $request = method_exists('Application', 'get') ? Application::get()->getRequest() : Application::getRequest();
            $context = $request->getContext();
            $contextId = $context ? (int) $context->getId() : (int) $mainContextId;

            $displayMode = $this->getSetting($contextId, 'es_displayMode');
            if (!is_array($displayMode)) {
                $displayMode = $displayMode ? [$displayMode] : ['homepage'];
            }

            if (in_array('homepage', $displayMode)) {
                HookRegistry::register('Templates::Index::journal', [$this, 'displayStatsHomepage']);
            }
            if (in_array('page', $displayMode) || in_array('dashboard', $displayMode)) {
                HookRegistry::register('LoadHandler', [$this, 'callbackHandleContent']);
            }
            if (in_array('dashboard', $displayMode)) {
                $versionDao = DAORegistry::getDAO('VersionDAO');
                $currentVersion = $versionDao->getCurrentVersion();
                if ($currentVersion->getMajor() >= 3 && $currentVersion->getMinor() >= 3) {
                    HookRegistry::register('TemplateManager::setupBackendPage', [$this, 'setupBackendPage']);
                }
            }
        }
        return $success;
    }

    public function callbackHandleContent($hookName, $args)
    {
        $page = &$args[0];
        $op = &$args[1];
        $request = method_exists('Application', 'get') ? Application::get()->getRequest() : Application::getRequest();
        $context = $request->getContext();
        $contextId = $context ? (int) $context->getId() : 0;

        if ($page === 'stats' && $op === 'editorialStats') {
            define('HANDLER_CLASS', 'EditorialStatsBackendHandler');
            $this->import('EditorialStatsBackendHandler');
            EditorialStatsBackendHandler::setPlugin($this);
            return true;
        }

        $customPath = $this->getSetting($contextId, 'es_customPath');
        if (!$customPath) {
            $customPath = 'editorialStats';
        }

        if ($page === $customPath || $page === 'editorialStats') {
            define('HANDLER_CLASS', 'EditorialStatsFrontendHandler');
            $this->import('EditorialStatsFrontendHandler');
            EditorialStatsFrontendHandler::setPlugin($this);
            return true;
        }
        return false;
    }

    public function setupBackendPage($hookName, $args)
    {
        $request = method_exists('Application', 'get') ? Application::get()->getRequest() : Application::getRequest();
        $context = $request->getContext();
        $contextId = $context ? $context->getId() : 0;
        
        $displayMode = $this->getSetting($contextId, 'es_displayMode');
        if (!is_array($displayMode)) {
            $displayMode = $displayMode ? [$displayMode] : ['homepage'];
        }
        
        if (!in_array('dashboard', $displayMode)) {
            return false;
        }

        $templateMgr = TemplateManager::getManager($request);
        $menu = $templateMgr->getState('menu');

        if (isset($menu['statistics']['submenu'])) {
            $router = $request->getRouter();
            $newItem = [
                'name' => $this->getDisplayName(),
                'url' => $router->url($request, null, 'stats', 'editorialStats'),
                'isCurrent' => $router->getRequestedPage($request) === 'stats' && $router->getRequestedOp($request) === 'editorialStats',
            ];

            $newSubmenu = [];
            foreach ($menu['statistics']['submenu'] as $key => $item) {
                $newSubmenu[$key] = $item;
                if ($key === 'editorial') {
                    $newSubmenu['editorialStats'] = $newItem;
                }
            }

            if (!isset($newSubmenu['editorialStats'])) {
                $newSubmenu['editorialStats'] = $newItem;
            }

            $menu['statistics']['submenu'] = $newSubmenu;
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
        $frequency = $this->getSetting($contextId, 'es_updateFrequency');
        if (empty($frequency)) {
            $frequency = 'always';
        }

        if ($frequency !== 'always') {
            $lastUpdate = (int) $this->getSetting($contextId, 'es_lastUpdate');
            $cachedData = $this->getSetting($contextId, 'es_cachedData');
            $currentTime = time();
            $expired = true;

            if ($lastUpdate > 0 && is_array($cachedData) && !empty($cachedData)) {
                $diff = $currentTime - $lastUpdate;
                if ($frequency === 'daily' && $diff < 86400) {
                    $expired = false;
                } elseif ($frequency === 'weekly' && $diff < 604800) {
                    $expired = false;
                } elseif ($frequency === 'monthly' && $diff < 2592000) {
                    $expired = false;
                }
            }

            if (!$expired && is_array($cachedData)) {
                return $cachedData;
            }
        }
        // Submission Constants (from PKPSubmission.inc.php)
        $STATUS_QUEUED = 1;
        $STATUS_PUBLISHED = 3;
        $STATUS_DECLINED = 4;

        $versionDao = DAORegistry::getDAO('VersionDAO');
        $currentVersion = $versionDao->getCurrentVersion();
        $major = $currentVersion->getMajor();
        $minor = $currentVersion->getMinor();

        $isOjs33 = $major >= 3 && $minor >= 3;
        $isOjs31 = $major == 3 && $minor <= 1;

        $dao = new DAO();

        // Helper to get count for ADOdb (OJS 3.1 and 3.2)
        $getAdoCount = function ($sql, $params) use ($dao) {
            $result = $dao->retrieve($sql, $params);
            if (!$result || $result->EOF) {
                return 0;
            }
            $row = (array) $result->fields;
            $count = isset($row['c']) ? $row['c'] : current($row);
            $result->Close();
            return (int) $count;
        };

        if ($isOjs33) {
            $totalSubmissions = \Illuminate\Database\Capsule\Manager::table('submissions')->where('context_id', $contextId)->count();
            $published = \Illuminate\Database\Capsule\Manager::table('submissions')->where('context_id', $contextId)->where('status', $STATUS_PUBLISHED)->count();
            $inProgress = \Illuminate\Database\Capsule\Manager::table('submissions')->where('context_id', $contextId)->where('status', $STATUS_QUEUED)->count();
            $declined = \Illuminate\Database\Capsule\Manager::table('submissions')->where('context_id', $contextId)->where('status', $STATUS_DECLINED)->count();

            $publishedSubmissions = \Illuminate\Database\Capsule\Manager::table('submissions as s')->join('publications as p', 's.submission_id', '=', 'p.submission_id')->where('s.context_id', $contextId)->where('s.status', $STATUS_PUBLISHED)->whereNotNull('p.date_published')->select('s.date_submitted', 'p.date_published')->get();
            $reviewsCompleted = \Illuminate\Database\Capsule\Manager::table('review_assignments as r')->join('submissions as s', 'r.submission_id', '=', 's.submission_id')->where('s.context_id', $contextId)->whereNotNull('r.date_completed')->where('r.declined', 0)->count();
            $activeReviewers = \Illuminate\Database\Capsule\Manager::table('review_assignments as r')->join('submissions as s', 'r.submission_id', '=', 's.submission_id')->where('s.context_id', $contextId)->whereNull('r.date_completed')->where('r.declined', 0)->distinct('r.reviewer_id')->count('r.reviewer_id');
            $allSubmissions = \Illuminate\Database\Capsule\Manager::table('submissions')->where('context_id', $contextId)->select('date_submitted')->get();

            $currentLocale = AppLocale::getLocale();
            $contextDao = Application::getContextDAO();
            $context = $contextDao->getById($contextId);
            $primaryLocale = $context ? $context->getPrimaryLocale() : $currentLocale;

            $publishedArticles = \Illuminate\Database\Capsule\Manager::table('submissions as s')
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
        } else {
            // OJS 3.1 and 3.2 logic
            $totalSubmissions = $getAdoCount('SELECT COUNT(*) as c FROM submissions WHERE context_id = ?', [(int) $contextId]);
            $published = $getAdoCount('SELECT COUNT(*) as c FROM submissions WHERE context_id = ? AND status = ?', [(int) $contextId, (int) $STATUS_PUBLISHED]);
            $inProgress = $getAdoCount('SELECT COUNT(*) as c FROM submissions WHERE context_id = ? AND status = ?', [(int) $contextId, (int) $STATUS_QUEUED]);
            $declined = $getAdoCount('SELECT COUNT(*) as c FROM submissions WHERE context_id = ? AND status = ?', [(int) $contextId, (int) $STATUS_DECLINED]);

            if ($isOjs31) {
                // OJS 3.1
                $resPub = $dao->retrieve('SELECT s.date_submitted, ps.date_published FROM submissions s JOIN published_submissions ps ON s.submission_id = ps.submission_id WHERE s.context_id = ? AND s.status = ? AND ps.date_published IS NOT NULL', [(int) $contextId, (int) $STATUS_PUBLISHED]);
            } else {
                // OJS 3.2
                $resPub = $dao->retrieve('SELECT s.date_submitted, p.date_published FROM submissions s JOIN publications p ON s.submission_id = p.submission_id WHERE s.context_id = ? AND s.status = ? AND p.date_published IS NOT NULL', [(int) $contextId, (int) $STATUS_PUBLISHED]);
            }
            $publishedSubmissions = [];
            while (!$resPub->EOF) {
                $row = (array) $resPub->fields;
                $publishedSubmissions[] = (object) [
                    'date_submitted' => $row['date_submitted'] ?? null,
                    'date_published' => $row['date_published'] ?? null,
                ];
                $resPub->MoveNext();
            }
            $resPub->Close();

            $reviewsCompleted = $getAdoCount('SELECT COUNT(*) as c FROM review_assignments r JOIN submissions s ON r.submission_id = s.submission_id WHERE s.context_id = ? AND r.date_completed IS NOT NULL AND r.declined = 0', [(int) $contextId]);
            $activeReviewers = $getAdoCount('SELECT COUNT(DISTINCT r.reviewer_id) as c FROM review_assignments r JOIN submissions s ON r.submission_id = s.submission_id WHERE s.context_id = ? AND r.date_completed IS NULL AND r.declined = 0', [(int) $contextId]);

            $resAll = $dao->retrieve('SELECT date_submitted FROM submissions WHERE context_id = ?', [(int) $contextId]);
            $allSubmissions = [];
            while (!$resAll->EOF) {
                $row = (array) $resAll->fields;
                $allSubmissions[] = (object) ['date_submitted' => $row['date_submitted'] ?? null];
                $resAll->MoveNext();
            }
            $resAll->Close();

            $currentLocale = AppLocale::getLocale();
            $contextDao = Application::getContextDAO();
            $context = $contextDao->getById($contextId);
            $primaryLocale = $context ? $context->getPrimaryLocale() : $currentLocale;

            if ($isOjs31) {
                $sqlSections = 'SELECT s.section_id, ss.setting_value as section_title, ss.locale FROM submissions s
                    JOIN published_submissions ps ON ps.submission_id = s.submission_id
                    JOIN sections sec ON s.section_id = sec.section_id
                    LEFT JOIN section_settings ss ON ss.section_id = sec.section_id AND ss.setting_name = ? AND ss.locale IN (?, ?)
                    WHERE s.context_id = ? AND s.status = ?';
            } else {
                $sqlSections = 'SELECT p.section_id, ss.setting_value as section_title, ss.locale FROM submissions s
                    JOIN publications p ON p.submission_id = s.submission_id
                    JOIN sections sec ON p.section_id = sec.section_id
                    LEFT JOIN section_settings ss ON ss.section_id = sec.section_id AND ss.setting_name = ? AND ss.locale IN (?, ?)
                    WHERE s.context_id = ? AND s.status = ?';
            }

            $resSec = $dao->retrieve($sqlSections, ['title', $currentLocale, $primaryLocale, (int) $contextId, (int) $STATUS_PUBLISHED]);
            $publishedArticles = [];
            while (!$resSec->EOF) {
                $row = (array) $resSec->fields;
                $publishedArticles[] = (object) [
                    'section_id' => $row['section_id'] ?? null,
                    'section_title' => $row['section_title'] ?? null,
                    'locale' => $row['locale'] ?? null,
                ];
                $resSec->MoveNext();
            }
            $resSec->Close();
        }

        // 5. Acceptance rate
        $resolved = $published + $declined;
        $acceptanceRate = $resolved > 0 ? round(($published / $resolved) * 100, 1) : 0;

        // 6. Avg days to publish
        $totalDays = 0;
        $publishedCount = 0;
        foreach ($publishedSubmissions as $row) {
            if (!empty($row->date_submitted) && !empty($row->date_published)) {
                $dateSub = strtotime($row->date_submitted);
                $datePub = strtotime($row->date_published);
                $diffDays = round(abs($datePub - $dateSub) / 86400);
                $totalDays += $diffDays;
                $publishedCount++;
            }
        }
        $avgDaysToPublish = $publishedCount > 0 ? round($totalDays / $publishedCount) : 0;

        // 9. Submissions per year
        $subsPerYear = [];
        foreach ($allSubmissions as $row) {
            if (!empty($row->date_submitted)) {
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
        $articlesPerSection = [];
        foreach ($publishedArticles as $article) {
            $titleId = $article->section_id;
            if (!isset($articlesPerSection[$titleId])) {
                $articlesPerSection[$titleId] = [
                    'title' => $article->section_title ?: __('plugins.generic.editorialStats.section') . ' ' . $titleId,
                    'count' => 0,
                    'locale' => $article->locale,
                ];
            } else {
                if ($article->locale == $currentLocale && $articlesPerSection[$titleId]['locale'] != $currentLocale) {
                    $articlesPerSection[$titleId]['title'] = $article->section_title ?: __('plugins.generic.editorialStats.section') . ' ' . $titleId;
                    $articlesPerSection[$titleId]['locale'] = $article->locale;
                }
            }
            $articlesPerSection[$titleId]['count']++;
        }

        $sectionsData = [];
        foreach ($articlesPerSection as $data) {
            $sectionsData[] = [
                'title' => $data['title'],
                'count' => $data['count'],
            ];
        }

        usort($sectionsData, function ($a, $b) {
            return $b['count'] - $a['count'];
        });

        $statsData = [
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

        if ($frequency !== 'always') {
            $this->updateSetting($contextId, 'es_cachedData', $statsData, 'object');
            $this->updateSetting($contextId, 'es_lastUpdate', time(), 'int');
        }

        return $statsData;
    }

    public function displayStatsHomepage($hookName, $params)
    {
        $smarty = &$params[1];
        $output = &$params[2];

        $request = method_exists('Application', 'get') ? Application::get()->getRequest() : Application::getRequest();
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
            'es_theme' => $this->getSetting($contextId, 'es_theme') ?? 'modern',
            'es_chartColor' => $this->getSetting($contextId, 'es_chartColor') ?? '#3b82f6',
            'esThemeTemplatePath' => $this->getTemplateResource('frontend/themes/' . ($this->getSetting($contextId, 'es_theme') ?? 'modern') . '.tpl'),
        ]);

        $templatePath = $this->getTemplateResource('frontend/stats.tpl');
        $output .= $smarty->fetch($templatePath);

        return false;
    }
}
