<script>
	$(function() {ldelim}
		$('#editorialStatsSettingsForm').pkpHandler('$.pkp.controllers.form.AjaxFormHandler');
	{rdelim});
</script>

<form class="pkp_form" id="editorialStatsSettingsForm" method="post" action="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="settings" save=true}">
	{csrf}
	{include file="controllers/notification/inPlaceNotification.tpl" notificationId="editorialStatsSettingsNotification"}

	{fbvFormArea id="editorialStatsSettings"}
		{fbvFormSection title="plugins.generic.editorialStats.displayMode" list=true}
			{fbvElement type="checkbox" id="es_displayMode_dashboard" name="es_displayMode[]" value="dashboard" checked=in_array('dashboard', $es_displayMode) label="plugins.generic.editorialStats.displayMode.dashboard"}
			{fbvElement type="checkbox" id="es_displayMode_homepage" name="es_displayMode[]" value="homepage" checked=in_array('homepage', $es_displayMode) label="plugins.generic.editorialStats.displayMode.homepage"}
			{fbvElement type="checkbox" id="es_displayMode_page" name="es_displayMode[]" value="page" checked=in_array('page', $es_displayMode) label="plugins.generic.editorialStats.displayMode.page"}
		{/fbvFormSection}

		<div id="es_customPath_wrapper" {if !in_array('page', $es_displayMode)}style="display:none;"{/if}>
			{fbvFormSection title="plugins.generic.editorialStats.customPath.label"}
				{fbvElement type="text" id="es_customPath" name="es_customPath" value=$es_customPath}
				<p style="margin-top:0.5rem; color:#64748b; font-size:0.9em;">
					{translate key="plugins.generic.editorialStats.customPath.description"}<br>
					{translate key="plugins.generic.editorialStats.customPath.linkInfo"}
					{assign var="finalCustomPath" value=$es_customPath|default:'editorialStats'}
					<a id="es_customPath_link" href="{url router=$smarty.const.ROUTE_PAGE page=$finalCustomPath}" target="_blank" style="font-weight:bold;">
						{url router=$smarty.const.ROUTE_PAGE page=$finalCustomPath}
					</a>
				</p>
				<script>
					$(function() {
						var baseUrl = "{url router=$smarty.const.ROUTE_PAGE page='__PLACEHOLDER__'}";
						
						// Update link dynamically on typing
						$('input[name="es_customPath"]').on('keyup', function() {
							var val = $(this).val().trim();
							if (!val) val = 'editorialStats';
							var newUrl = baseUrl.replace('__PLACEHOLDER__', val);
							$('#es_customPath_link').attr('href', newUrl).text(newUrl);
						});

						// Toggle visibility based on checkboxes
						var $displayCheckboxes = $('input[name="es_displayMode[]"]');
						var $pageCheckbox = $('input[name="es_displayMode[]"][value="page"]');
						var $homepageCheckbox = $('input[name="es_displayMode[]"][value="homepage"]');
						var $pathContainer = $('#es_customPath_wrapper');
						var $frontendSettings = $('#es_frontend_settings_wrapper');
						
						$displayCheckboxes.on('change', function() {
							var isPage = $pageCheckbox.is(':checked');
							var isHomepage = $homepageCheckbox.is(':checked');
							
							if (isPage) {
								$pathContainer.slideDown(200);
							} else {
								$pathContainer.slideUp(200);
							}

							if (isPage || isHomepage) {
								$frontendSettings.slideDown(200);
							} else {
								$frontendSettings.slideUp(200);
							}
						});
					});
				</script>
			{/fbvFormSection}
		</div>
		
		<div id="es_frontend_settings_wrapper" {if !in_array('homepage', $es_displayMode) && !in_array('page', $es_displayMode)}style="display:none;"{/if}>
			{fbvFormSection title="plugins.generic.editorialStats.theme"}
				{fbvElement type="select" id="es_theme" name="es_theme" from=$es_themes selected=$es_theme translate=false}
			{/fbvFormSection}

			{fbvFormSection title="plugins.generic.editorialStats.metricsToDisplay" list=true}
				{fbvElement type="checkbox" id="es_showTotalSubmissions" checked=$es_showTotalSubmissions label="plugins.generic.editorialStats.totalSubmissions"}
				{fbvElement type="checkbox" id="es_showPublished" checked=$es_showPublished label="plugins.generic.editorialStats.published"}
				{fbvElement type="checkbox" id="es_showInProgress" checked=$es_showInProgress label="plugins.generic.editorialStats.inProgress"}
				{fbvElement type="checkbox" id="es_showDeclined" checked=$es_showDeclined label="plugins.generic.editorialStats.declined"}
				{fbvElement type="checkbox" id="es_showAcceptanceRate" checked=$es_showAcceptanceRate label="plugins.generic.editorialStats.acceptanceRate"}
				{fbvElement type="checkbox" id="es_showAvgDaysToPublish" checked=$es_showAvgDaysToPublish label="plugins.generic.editorialStats.avgDaysToPublish"}
				{fbvElement type="checkbox" id="es_showReviewsCompleted" checked=$es_showReviewsCompleted label="plugins.generic.editorialStats.reviewsCompleted"}
				{fbvElement type="checkbox" id="es_showActiveReviewers" checked=$es_showActiveReviewers label="plugins.generic.editorialStats.activeReviewers"}
				{fbvElement type="checkbox" id="es_showSubmissionsPerYear" checked=$es_showSubmissionsPerYear label="plugins.generic.editorialStats.submissionsPerYear"}
				<div id="es_chartColor_wrapper" style="margin-left: 28px; margin-top: 8px; margin-bottom: 12px; {if !$es_showSubmissionsPerYear}display:none;{/if}">
					<label for="es_chartColor" style="font-weight: 500; font-size: 0.9em; margin-right: 10px;">
						{translate key="plugins.generic.editorialStats.chartColor"}
					</label>
					<input type="color" id="es_chartColor" name="es_chartColor" value="{$es_chartColor|escape}" style="vertical-align: middle; cursor: pointer;">
				</div>
				<script>
					$(function() {
						var $chartCheckbox = $('#es_showSubmissionsPerYear');
						var $colorWrapper = $('#es_chartColor_wrapper');
						$chartCheckbox.on('change', function() {
							if ($(this).is(':checked')) {
								$colorWrapper.slideDown(200);
							} else {
								$colorWrapper.slideUp(200);
							}
						});
					});
				</script>
				{fbvElement type="checkbox" id="es_showPublishedPerSection" checked=$es_showPublishedPerSection label="plugins.generic.editorialStats.publishedPerSection"}
			{/fbvFormSection}
		</div>
	{/fbvFormArea}

	{fbvFormButtons id="editorialStatsSettingsFormSubmit" submitText="common.save" hideCancel=true}
</form>
