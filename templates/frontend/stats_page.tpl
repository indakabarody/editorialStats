{**
 * templates/frontend/stats_page.tpl
 *
 * Copyright (c) 2026 Indaka Barody
 * Distributed under the GNU GPL v3.
 *
 * Display Editorial Stats on a separate frontend page
 *}
{include file="frontend/components/header.tpl" pageTitle="plugins.generic.editorialStats.title"}

<div class="page page_editorial_stats">
	{include file=$esStatsTemplatePath}
</div>

{include file="frontend/components/footer.tpl"}
