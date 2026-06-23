<?php
/**
 * @file EditorialStatsFrontendHandler.inc.php
 *
 * Copyright (c) 2026 Indaka Barody
 * Distributed under the GNU GPL v3.
 *
 * @class EditorialStatsFrontendHandler
 * @brief Handle requests for editorial stats on the frontend
 */

import('classes.handler.Handler');

class EditorialStatsFrontendHandler extends Handler
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
    }

    /**
     * Authorize the request.
     */
    public function authorize($request, &$args, $roleAssignments)
    {
        return parent::authorize($request, $args, $roleAssignments);
    }

    /**
     * Handle the request.
     * @param $args array Arguments array.
     * @param $request PKPRequest Request object.
     */
    public function index($args, $request)
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

        if (!in_array('page', $displayMode)) {
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
            'es_showTotalSubmissions' => self::$plugin->getSetting($contextId, 'es_showTotalSubmissions') ?? true,
            'es_showPublished' => self::$plugin->getSetting($contextId, 'es_showPublished') ?? true,
            'es_showInProgress' => self::$plugin->getSetting($contextId, 'es_showInProgress') ?? true,
            'es_showDeclined' => self::$plugin->getSetting($contextId, 'es_showDeclined') ?? true,
            'es_showAcceptanceRate' => self::$plugin->getSetting($contextId, 'es_showAcceptanceRate') ?? true,
            'es_showAvgDaysToPublish' => self::$plugin->getSetting($contextId, 'es_showAvgDaysToPublish') ?? true,
            'es_showReviewsCompleted' => self::$plugin->getSetting($contextId, 'es_showReviewsCompleted') ?? true,
            'es_showActiveReviewers' => self::$plugin->getSetting($contextId, 'es_showActiveReviewers') ?? true,
            'es_showSubmissionsPerYear' => self::$plugin->getSetting($contextId, 'es_showSubmissionsPerYear') ?? true,
            'es_showPublishedPerSection' => self::$plugin->getSetting($contextId, 'es_showPublishedPerSection') ?? true,
            'es_theme' => self::$plugin->getSetting($contextId, 'es_theme') ?? 'modern',
        ]);

        $templateMgr->display(self::$plugin->getTemplateResource('frontend/stats_page.tpl'));
    }
}
