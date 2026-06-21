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

class EditorialStatsSettingsForm extends Form {
	/** @var EditorialStatsPlugin The plugin associated with this form */
	var $plugin;

	/** @var int Context ID */
	var $contextId;

	/**
	 * Constructor
	 * @param $plugin EditorialStatsPlugin
	 * @param $contextId int
	 */
	public function __construct($plugin, $contextId) {
		$this->plugin = $plugin;
		$this->contextId = $contextId;
		parent::__construct($plugin->getTemplateResource('settings.tpl'));
		$this->addCheck(new FormValidatorPost($this));
		$this->addCheck(new FormValidatorCSRF($this));
	}

	/**
	 * Initialize form data.
	 */
	public function initData() {
		$plugin = $this->plugin;
		$contextId = $this->contextId;

		// Array of setting names
		$settings = [
			'es_showTotalSubmissions',
			'es_showPublished',
			'es_showInProgress',
			'es_showDeclined',
			'es_showAcceptanceRate',
			'es_showAvgDaysToPublish',
			'es_showReviewsCompleted',
			'es_showActiveReviewers',
			'es_showSubmissionsPerYear',
			'es_showPublishedPerSection'
		];

		foreach ($settings as $settingName) {
			$value = $plugin->getSetting($contextId, $settingName);
			// Default to true if not set
			if ($value === null) {
				$value = true;
			}
			$this->setData($settingName, $value);
		}
	}

	/**
	 * Assign form data to user-submitted data.
	 */
	public function readInputData() {
		$this->readUserVars([
			'es_showTotalSubmissions',
			'es_showPublished',
			'es_showInProgress',
			'es_showDeclined',
			'es_showAcceptanceRate',
			'es_showAvgDaysToPublish',
			'es_showReviewsCompleted',
			'es_showActiveReviewers',
			'es_showSubmissionsPerYear',
			'es_showPublishedPerSection'
		]);
	}

	/**
	 * Fetch the form.
	 * @copydoc Form::fetch()
	 */
	public function fetch($request, $template = null, $display = false) {
		$templateMgr = TemplateManager::getManager($request);
		$templateMgr->assign('pluginName', $this->plugin->getName());
		return parent::fetch($request, $template, $display);
	}

	/**
	 * Save settings.
	 */
	public function execute(...$functionArgs) {
		$plugin = $this->plugin;
		$contextId = $this->contextId;

		$settings = [
			'es_showTotalSubmissions',
			'es_showPublished',
			'es_showInProgress',
			'es_showDeclined',
			'es_showAcceptanceRate',
			'es_showAvgDaysToPublish',
			'es_showReviewsCompleted',
			'es_showActiveReviewers',
			'es_showSubmissionsPerYear',
			'es_showPublishedPerSection'
		];

		foreach ($settings as $settingName) {
			$plugin->updateSetting($contextId, $settingName, $this->getData($settingName) ? true : false, 'bool');
		}

		parent::execute(...$functionArgs);
	}
}
