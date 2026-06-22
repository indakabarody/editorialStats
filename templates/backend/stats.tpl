{**
 * templates/backend/stats.tpl
 *
 * Copyright (c) 2026 Indaka Barody
 * Distributed under the GNU GPL v3.
 *
 * Display Editorial Stats in the backend dashboard
 *}
{extends file="layouts/backend.tpl"}

{block name="page"}
<div class="pkpStats pkpStats--editorial">
    
    <div class="pkpStats__panel">
        <pkp-header>
            <h1 class="pkpHeader__title">{translate key="plugins.generic.editorialStats.title"}</h1>
        </pkp-header>
        
        <div class="pkpStats__container -pkpClearfix">
            <div class="pkpStats__content" style="width: 100%;">
                <div class="pkpStats__table" role="region">
                    <table class="pkpTable">
                        <thead>
                            <tr>
                                <th>{translate key="plugins.generic.editorialStats.metric"|default:"Metric"}</th>
                                <th>{translate key="plugins.generic.editorialStats.value"|default:"Value"}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {if $es_showTotalSubmissions}
                            <tr>
                                <td>{translate key="plugins.generic.editorialStats.totalSubmissions"}</td>
                                <td><span class="pkpBadge">{$es_totalSubmissions}</span></td>
                            </tr>
                            {/if}
                            {if $es_showPublished}
                            <tr>
                                <td>{translate key="plugins.generic.editorialStats.published"}</td>
                                <td><span class="pkpBadge">{$es_published}</span></td>
                            </tr>
                            {/if}
                            {if $es_showInProgress}
                            <tr>
                                <td>{translate key="plugins.generic.editorialStats.inProgress"}</td>
                                <td><span class="pkpBadge">{$es_inProgress}</span></td>
                            </tr>
                            {/if}
                            {if $es_showDeclined}
                            <tr>
                                <td>{translate key="plugins.generic.editorialStats.declined"}</td>
                                <td><span class="pkpBadge">{$es_declined}</span></td>
                            </tr>
                            {/if}
                            {if $es_showAcceptanceRate}
                            <tr>
                                <td>{translate key="plugins.generic.editorialStats.acceptanceRate"}</td>
                                <td><span class="pkpBadge">{$es_acceptanceRate}%</span></td>
                            </tr>
                            {/if}
                            {if $es_showAvgDaysToPublish}
                            <tr>
                                <td>{translate key="plugins.generic.editorialStats.avgDaysToPublish"}</td>
                                <td><span class="pkpBadge">{$es_avgDaysToPublish}</span></td>
                            </tr>
                            {/if}
                            {if $es_showReviewsCompleted}
                            <tr>
                                <td>{translate key="plugins.generic.editorialStats.reviewsCompleted"}</td>
                                <td><span class="pkpBadge">{$es_reviewsCompleted}</span></td>
                            </tr>
                            {/if}
                            {if $es_showActiveReviewers}
                            <tr>
                                <td>{translate key="plugins.generic.editorialStats.activeReviewers"}</td>
                                <td><span class="pkpBadge">{$es_activeReviewers}</span></td>
                            </tr>
                            {/if}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    {if $es_showPublishedPerSection}
    <div class="pkpStats__panel" style="margin-top: 2rem;">
        <pkp-header>
            <h1 class="pkpHeader__title">{translate key="plugins.generic.editorialStats.publishedPerSection"}</h1>
        </pkp-header>
        <div class="pkpStats__container -pkpClearfix">
            <div class="pkpStats__content" style="width: 100%;">
                <div class="pkpStats__table" role="region">
                    <table class="pkpTable">
                        <thead>
                            <tr>
                                <th>{translate key="plugins.generic.editorialStats.section"}</th>
                                <th>{translate key="plugins.generic.editorialStats.count"}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {if $es_sectionsData|@count > 0}
                                {foreach from=$es_sectionsData item=section}
                                <tr>
                                    <td>{$section.title|escape}</td>
                                    <td><span class="pkpBadge">{$section.count}</span></td>
                                </tr>
                                {/foreach}
                            {else}
                                <tr>
                                    <td colspan="2">{translate key="plugins.generic.editorialStats.noData"}</td>
                                </tr>
                            {/if}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    {/if}

    {if $es_showSubmissionsPerYear}
    <div class="pkpStats__panel" style="margin-top: 2rem;">
        <pkp-header>
            <h1 class="pkpHeader__title">{translate key="plugins.generic.editorialStats.submissionsPerYear"}</h1>
        </pkp-header>
        <div class="pkpStats__container -pkpClearfix">
            <div class="pkpStats__content" style="width: 100%;">
                <div class="pkpStats__table" role="region">
                    <table class="pkpTable">
                        <thead>
                            <tr>
                                <th>{translate key="plugins.generic.editorialStats.year"}</th>
                                <th>{translate key="plugins.generic.editorialStats.count"}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {if $es_subsPerYear|@count > 0}
                                {foreach from=$es_subsPerYear key=year item=count}
                                <tr>
                                    <td>{$year|escape}</td>
                                    <td><span class="pkpBadge">{$count}</span></td>
                                </tr>
                                {/foreach}
                            {else}
                                <tr>
                                    <td colspan="2">{translate key="plugins.generic.editorialStats.noData"}</td>
                                </tr>
                            {/if}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    {/if}
</div>
{/block}
