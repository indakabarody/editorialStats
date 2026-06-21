<script>
	$(function() {ldelim}
		$('#editorialStatsSettingsForm').pkpHandler('$.pkp.controllers.form.AjaxFormHandler');
	{rdelim});
</script>

<form class="pkp_form" id="editorialStatsSettingsForm" method="post" action="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="settings" save=true}">
	{csrf}
	{include file="controllers/notification/inPlaceNotification.tpl" notificationId="editorialStatsSettingsNotification"}

	<h3>{translate key="plugins.generic.editorialStats.settings"}</h3>
	<p>{translate key="plugins.generic.editorialStats.settings.description"}</p>

	{fbvFormArea id="editorialStatsSettings"}
		{fbvFormSection list=true}
			{fbvElement type="checkbox" id="es_showTotalSubmissions" checked=$es_showTotalSubmissions label="plugins.generic.editorialStats.totalSubmissions"}
			{fbvElement type="checkbox" id="es_showPublished" checked=$es_showPublished label="plugins.generic.editorialStats.published"}
			{fbvElement type="checkbox" id="es_showInProgress" checked=$es_showInProgress label="plugins.generic.editorialStats.inProgress"}
			{fbvElement type="checkbox" id="es_showDeclined" checked=$es_showDeclined label="plugins.generic.editorialStats.declined"}
			{fbvElement type="checkbox" id="es_showAcceptanceRate" checked=$es_showAcceptanceRate label="plugins.generic.editorialStats.acceptanceRate"}
			{fbvElement type="checkbox" id="es_showAvgDaysToPublish" checked=$es_showAvgDaysToPublish label="plugins.generic.editorialStats.avgDaysToPublish"}
			{fbvElement type="checkbox" id="es_showReviewsCompleted" checked=$es_showReviewsCompleted label="plugins.generic.editorialStats.reviewsCompleted"}
			{fbvElement type="checkbox" id="es_showActiveReviewers" checked=$es_showActiveReviewers label="plugins.generic.editorialStats.activeReviewers"}
			{fbvElement type="checkbox" id="es_showSubmissionsPerYear" checked=$es_showSubmissionsPerYear label="plugins.generic.editorialStats.submissionsPerYear"}
			{fbvElement type="checkbox" id="es_showPublishedPerSection" checked=$es_showPublishedPerSection label="plugins.generic.editorialStats.publishedPerSection"}
		{/fbvFormSection}
	{/fbvFormArea}

	{fbvFormButtons id="editorialStatsSettingsFormSubmit" submitText="common.save" hideCancel=true}
</form>
