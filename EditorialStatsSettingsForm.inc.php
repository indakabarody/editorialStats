<?php

/**
 * @file EditorialStatsSettingsForm.inc.php
 *
 * Copyright (c) 2026 Indaka Barody
 * Distributed under the GNU GPL v3.
 *
 * @class EditorialStatsSettingsForm
 * @brief Form for journal managers to modify Editorial Stats Plugin settings
 */

import('lib.pkp.classes.form.Form');

class EditorialStatsSettingsForm extends Form
{
    /** @var EditorialStatsPlugin The plugin associated with this form */
    var $plugin;

    /** @var int Context ID */
    var $contextId;

    /**
     * Constructor
     * @param $plugin EditorialStatsPlugin
     * @param $contextId int
     */
    public function __construct($plugin, $contextId)
    {
        $this->plugin = $plugin;
        $this->contextId = $contextId;
        parent::__construct($plugin->getTemplateResource('settings.tpl'));
        $this->addCheck(new FormValidatorPost($this));
        $this->addCheck(new FormValidatorCSRF($this));
    }

    /**
     * Initialize form data.
     */
    public function initData()
    {
        $plugin = $this->plugin;
        $contextId = $this->contextId;

        // Array of setting names
        $settings = ['es_displayMode', 'es_customPath', 'es_theme', 'es_chartColor', 'es_showTotalSubmissions', 'es_showPublished', 'es_showInProgress', 'es_showDeclined', 'es_showAcceptanceRate', 'es_showAvgDaysToPublish', 'es_showReviewsCompleted', 'es_showActiveReviewers', 'es_showSubmissionsPerYear', 'es_showPublishedPerSection'];

        foreach ($settings as $settingName) {
            $value = $plugin->getSetting($contextId, $settingName);
            if ($settingName === 'es_displayMode') {
                if ($value === null) {
                    $value = ['homepage'];
                } elseif (!is_array($value)) {
                    $value = [$value];
                }
                $this->setData($settingName, $value);
            } elseif ($settingName === 'es_customPath') {
                if ($value === null) {
                    $value = 'editorialStats';
                }
                $this->setData($settingName, $value);
            } elseif ($settingName === 'es_theme') {
                $this->setData($settingName, $value ?? 'modern');
            } elseif ($settingName === 'es_chartColor') {
                $this->setData($settingName, $value ?? '#3b82f6');
            } else {
                // Default to true if not set
                if ($value === null) {
                    $value = true;
                }
                $this->setData($settingName, $value);
            }
        }
    }

    /**
     * Assign form data to user-submitted data.
     */
    public function readInputData()
    {
        $this->readUserVars(['es_displayMode', 'es_customPath', 'es_theme', 'es_chartColor', 'es_showTotalSubmissions', 'es_showPublished', 'es_showInProgress', 'es_showDeclined', 'es_showAcceptanceRate', 'es_showAvgDaysToPublish', 'es_showReviewsCompleted', 'es_showActiveReviewers', 'es_showSubmissionsPerYear', 'es_showPublishedPerSection']);
        
        if (!is_array($this->getData('es_displayMode'))) {
            $this->setData('es_displayMode', []);
        }
    }

    /**
     * Fetch the form.
     * @copydoc Form::fetch()
     */
    public function fetch($request, $template = null, $display = false)
    {
        $templateMgr = TemplateManager::getManager($request);
        $templateMgr->assign('pluginName', $this->plugin->getName());
        $templateMgr->assign('es_themes', [
            'modern' => __('plugins.generic.editorialStats.theme.modern'),
            'monochrome' => __('plugins.generic.editorialStats.theme.monochrome'),
            'outline' => __('plugins.generic.editorialStats.theme.outline'),
            'dark' => __('plugins.generic.editorialStats.theme.dark'),
            'glassmorphism' => __('plugins.generic.editorialStats.theme.glassmorphism'),
            'neumorphism' => __('plugins.generic.editorialStats.theme.neumorphism'),
            'brutalism' => __('plugins.generic.editorialStats.theme.brutalism'),
            'corporate' => __('plugins.generic.editorialStats.theme.corporate'),
            'gradient' => __('plugins.generic.editorialStats.theme.gradient'),
            'material' => __('plugins.generic.editorialStats.theme.material'),
            'pastel' => __('plugins.generic.editorialStats.theme.pastel'),
            'cyberpunk' => __('plugins.generic.editorialStats.theme.cyberpunk'),
            'elegant' => __('plugins.generic.editorialStats.theme.elegant'),
            'playful' => __('plugins.generic.editorialStats.theme.playful'),
        ]);
        return parent::fetch($request, $template, $display);
    }

    /**
     * Save settings.
     */
    public function execute(...$functionArgs)
    {
        $plugin = $this->plugin;
        $contextId = $this->contextId;

        $settings = ['es_showTotalSubmissions', 'es_showPublished', 'es_showInProgress', 'es_showDeclined', 'es_showAcceptanceRate', 'es_showAvgDaysToPublish', 'es_showReviewsCompleted', 'es_showActiveReviewers', 'es_showSubmissionsPerYear', 'es_showPublishedPerSection'];

        foreach ($settings as $settingName) {
            $plugin->updateSetting($contextId, $settingName, $this->getData($settingName) ? true : false, 'bool');
        }

        $displayMode = $this->getData('es_displayMode');
        $plugin->updateSetting($contextId, 'es_displayMode', is_array($displayMode) ? $displayMode : [], 'object');
        
        $customPath = $this->getData('es_customPath');
        // Sanitizing the path slightly
        $customPath = preg_replace('/[^a-zA-Z0-9_\-]/', '', $customPath);
        if (empty($customPath)) $customPath = 'editorialStats';
        $plugin->updateSetting($contextId, 'es_customPath', $customPath, 'string');

        $theme = $this->getData('es_theme');
        $validThemes = ['modern', 'monochrome', 'outline', 'dark', 'glassmorphism', 'neumorphism', 'brutalism', 'corporate', 'gradient', 'material', 'pastel', 'cyberpunk', 'elegant', 'playful'];
        if (!in_array($theme, $validThemes)) $theme = 'modern';
        $plugin->updateSetting($contextId, 'es_theme', $theme, 'string');

        $chartColor = $this->getData('es_chartColor');
        if (empty($chartColor)) $chartColor = '#3b82f6';
        $plugin->updateSetting($contextId, 'es_chartColor', $chartColor, 'string');

        parent::execute(...$functionArgs);
    }
}
