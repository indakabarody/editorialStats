<?php
/**
 * @file EditorialStatsBackendHandler.inc.php
 *
 * Copyright (c) 2026 Indaka Barody
 * Distributed under the GNU GPL v3.
 *
 * @class EditorialStatsBackendHandler
 * @brief Handle requests for editorial stats on the backend dashboard
 */

import('classes.handler.Handler');

class EditorialStatsBackendHandler extends Handler
{
    /** @var EditorialStatsPlugin The editorial stats plugin */
    static $plugin;

    /**
     * Provide the plugin to the handler.
     * @param $plugin EditorialStatsPlugin
     */
    static function setPlugin($plugin)
    {
        self::$plugin = $plugin;
    }

    /**
     * Constructor
     */
    public function __construct()
    {
        parent::__construct();

        $this->_isBackendPage = true;
        $this->addRoleAssignment([ROLE_ID_SITE_ADMIN, ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR], ['editorialStats']);
    }

    /**
     * Authorize the request.
     */
    public function authorize($request, &$args, $roleAssignments)
    {
        import('lib.pkp.classes.security.authorization.ContextAccessPolicy');
        $this->addPolicy(new ContextAccessPolicy($request, $roleAssignments));

        return parent::authorize($request, $args, $roleAssignments);
    }

    /**
     * Handle the request.
     * @param $args array Arguments array.
     * @param $request PKPRequest Request object.
     */
    public function editorialStats($args, $request)
    {
        $context = $request->getContext();
        if (!$context) {
            $request->redirect(null, 'index');
        }

        $contextId = (int) $context->getId();
        $displayMode = self::$plugin->getSetting($contextId, 'es_displayMode');
        if (!is_array($displayMode)) {
            $displayMode = $displayMode ? [$displayMode] : ['homepage'];
        }

        if (!in_array('dashboard', $displayMode)) {
            $request->redirect(null, 'index');
        }

        $templateMgr = TemplateManager::getManager($request);

        // Setup page basics
        $this->setupTemplate($request);

        // Fetch stats
        $statsData = self::$plugin->getStatsData($contextId);
        $templateMgr->assign($statsData);

        // Assign settings
        $templateMgr->assign([
            'esStatsTemplatePath' => self::$plugin->getTemplateResource('frontend/stats.tpl'),
            'es_showTotalSubmissions' => true,
            'es_showPublished' => true,
            'es_showInProgress' => true,
            'es_showDeclined' => true,
            'es_showAcceptanceRate' => true,
            'es_showAvgDaysToPublish' => true,
            'es_showReviewsCompleted' => true,
            'es_showActiveReviewers' => true,
            'es_showSubmissionsPerYear' => true,
            'es_showPublishedPerSection' => true,
            'es_theme' => self::$plugin->getSetting($contextId, 'es_theme') ?? 'modern',
            'es_chartColor' => self::$plugin->getSetting($contextId, 'es_chartColor') ?? '#3b82f6',
            'esThemeTemplatePath' => self::$plugin->getTemplateResource('frontend/themes/' . (self::$plugin->getSetting($contextId, 'es_theme') ?? 'modern') . '.tpl'),
        ]);

        $templateMgr->assign('pageTitle', __('plugins.generic.editorialStats.title'));
        $templateMgr->display(self::$plugin->getTemplateResource('backend/stats.tpl'));
    }
}
