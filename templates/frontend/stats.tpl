<div class="editorial-stats-plugin-container es-theme-{$es_theme|escape}">
	{if !$hideEsTitle}
	<h2 class="es-title">{translate key="plugins.generic.editorialStats.title"}</h2>
	{/if}
	
	<!-- Top Metric Boxes -->
	<div class="es-grid">
		{if $es_showTotalSubmissions}
		<div class="es-card es-blue">
			<div class="es-card-icon">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
			</div>
			<div class="es-card-content">
				<div class="es-card-value">{$es_totalSubmissions}</div>
				<div class="es-card-label">{translate key="plugins.generic.editorialStats.totalSubmissions"}</div>
			</div>
		</div>
		{/if}

		{if $es_showPublished}
		<div class="es-card es-green">
			<div class="es-card-icon">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
			</div>
			<div class="es-card-content">
				<div class="es-card-value">{$es_published}</div>
				<div class="es-card-label">{translate key="plugins.generic.editorialStats.published"}</div>
			</div>
		</div>
		{/if}

		{if $es_showInProgress}
		<div class="es-card es-orange">
			<div class="es-card-icon">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
			</div>
			<div class="es-card-content">
				<div class="es-card-value">{$es_inProgress}</div>
				<div class="es-card-label">{translate key="plugins.generic.editorialStats.inProgress"}</div>
			</div>
		</div>
		{/if}

		{if $es_showDeclined}
		<div class="es-card es-red">
			<div class="es-card-icon">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
			</div>
			<div class="es-card-content">
				<div class="es-card-value">{$es_declined}</div>
				<div class="es-card-label">{translate key="plugins.generic.editorialStats.declined"}</div>
			</div>
		</div>
		{/if}
	</div>

	<!-- Second Row Metric Boxes -->
	<div class="es-grid">
		{if $es_showAcceptanceRate}
		<div class="es-card es-purple">
			<div class="es-card-icon">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="19" y1="5" x2="5" y2="19"></line><circle cx="6.5" cy="6.5" r="2.5"></circle><circle cx="17.5" cy="17.5" r="2.5"></circle></svg>
			</div>
			<div class="es-card-content">
				<div class="es-card-value">{$es_acceptanceRate}%</div>
				<div class="es-card-label">{translate key="plugins.generic.editorialStats.acceptanceRate"}</div>
			</div>
		</div>
		{/if}

		{if $es_showAvgDaysToPublish}
		<div class="es-card es-teal">
			<div class="es-card-icon">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
			</div>
			<div class="es-card-content">
				<div class="es-card-value">{$es_avgDaysToPublish}</div>
				<div class="es-card-label">{translate key="plugins.generic.editorialStats.avgDaysToPublish"}</div>
			</div>
		</div>
		{/if}

		{if $es_showReviewsCompleted}
		<div class="es-card es-indigo">
			<div class="es-card-icon">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><polyline points="9 15 11 17 15 13"></polyline></svg>
			</div>
			<div class="es-card-content">
				<div class="es-card-value">{$es_reviewsCompleted}</div>
				<div class="es-card-label">{translate key="plugins.generic.editorialStats.reviewsCompleted"}</div>
			</div>
		</div>
		{/if}

		{if $es_showActiveReviewers}
		<div class="es-card es-pink">
			<div class="es-card-icon">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
			</div>
			<div class="es-card-content">
				<div class="es-card-value">{$es_activeReviewers}</div>
				<div class="es-card-label">{translate key="plugins.generic.editorialStats.activeReviewers"}</div>
			</div>
		</div>
		{/if}
	</div>

	<div class="es-row-content">
		<!-- Bar Chart -->
		{if $es_showSubmissionsPerYear}
		<div class="es-box">
			<h3 class="es-subtitle">{translate key="plugins.generic.editorialStats.submissionsPerYear"}</h3>
			<div class="es-chart-wrapper">
				<canvas id="esSubmissionsChart"></canvas>
			</div>
		</div>
		{/if}

		<!-- Sections Table -->
		{if $es_showPublishedPerSection}
		<div class="es-table-container es-box">
			<h3 class="es-subtitle">{translate key="plugins.generic.editorialStats.publishedPerSection"}</h3>
			<div class="es-table-responsive">
				<table class="es-table">
					<thead>
						<tr>
							<th>{translate key="plugins.generic.editorialStats.section"}</th>
							<th class="es-text-right">{translate key="plugins.generic.editorialStats.count"}</th>
						</tr>
					</thead>
					<tbody>
						{if $es_sectionsData|@count > 0}
							{foreach from=$es_sectionsData item=section}
							<tr>
								<td>{$section.title|escape}</td>
								<td class="es-text-right"><span class="es-badge">{$section.count}</span></td>
							</tr>
							{/foreach}
						{else}
							<tr>
								<td colspan="2" class="es-text-center">{translate key="plugins.generic.editorialStats.noData"}</td>
							</tr>
						{/if}
					</tbody>
				</table>
			</div>
		</div>
		{/if}
	</div>
</div>

<style>
.editorial-stats-plugin-container {
	margin: 1rem 0;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
	color: #333;
}
.es-title {
	font-size: 1.5rem;
	font-weight: 700;
	margin-top: 0;
	margin-bottom: 1.5rem;
	color: #2c3e50;
}
.es-subtitle {
	font-size: 1.1rem;
	font-weight: 600;
	margin-top: 0;
	margin-bottom: 1rem;
	color: #4a5568;
}
.es-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 1.25rem;
	margin-bottom: 1.25rem;
}
@media (max-width: 1024px) {
	.es-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}
@media (max-width: 640px) {
	.es-grid {
		grid-template-columns: 1fr;
	}
}
.es-card {
	background: #fff;
	border-radius: 12px;
	padding: 1.25rem;
	display: flex;
	align-items: center;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05), 0 1px 3px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s ease, box-shadow 0.2s ease;
	border-left: 5px solid transparent;
}
.es-card:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 15px rgba(0, 0, 0, 0.08), 0 4px 6px rgba(0, 0, 0, 0.05);
}
.es-card-icon {
	width: 48px;
	height: 48px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 1rem;
	flex-shrink: 0;
}
.es-card-icon svg {
	width: 24px;
	height: 24px;
}
.es-card-content {
	display: flex;
	flex-direction: column;
}
.es-card-value {
	font-size: 1.75rem;
	font-weight: 800;
	line-height: 1.2;
	color: #1a202c;
}
.es-card-label {
	font-size: 0.875rem;
	color: #718096;
	font-weight: 500;
	text-transform: uppercase;
	letter-spacing: 0.025em;
	margin-top: 0.25rem;
}

/* Color Themes */
.es-blue { border-left-color: #3b82f6; }
.es-blue .es-card-icon { background: #eff6ff; color: #3b82f6; }
.es-green { border-left-color: #10b981; }
.es-green .es-card-icon { background: #ecfdf5; color: #10b981; }
.es-orange { border-left-color: #f59e0b; }
.es-orange .es-card-icon { background: #fffbeb; color: #f59e0b; }
.es-red { border-left-color: #ef4444; }
.es-red .es-card-icon { background: #fef2f2; color: #ef4444; }
.es-purple { border-left-color: #8b5cf6; }
.es-purple .es-card-icon { background: #f5f3ff; color: #8b5cf6; }
.es-teal { border-left-color: #14b8a6; }
.es-teal .es-card-icon { background: #f0fdfa; color: #14b8a6; }
.es-indigo { border-left-color: #6366f1; }
.es-indigo .es-card-icon { background: #eef2ff; color: #6366f1; }
.es-pink { border-left-color: #ec4899; }
.es-pink .es-card-icon { background: #fdf2f8; color: #ec4899; }

/* Layout for bottom half */
.es-row-content {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 1.25rem;
	margin-top: 1.5rem;
}
@media (max-width: 900px) {
	.es-row-content {
		grid-template-columns: 1fr;
	}
}
.es-box {
	background: #fff;
	border-radius: 12px;
	padding: 1.5rem;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05), 0 1px 3px rgba(0, 0, 0, 0.1);
}
.es-chart-wrapper {
	position: relative;
	height: 300px;
	width: 100%;
}
.es-table-responsive {
	overflow-x: auto;
}
.es-table {
	width: 100%;
	border-collapse: collapse;
	text-align: left;
}
.es-table th {
	padding: 0.75rem 1rem;
	border-bottom: 2px solid #e2e8f0;
	color: #4a5568;
	font-weight: 600;
	font-size: 0.875rem;
	text-transform: uppercase;
}
.es-table td {
	padding: 1rem;
	border-bottom: 1px solid #edf2f7;
	color: #2d3748;
	font-weight: 500;
}
.es-table tr:last-child td {
	border-bottom: none;
}
.es-text-right {
	text-align: right;
}
.es-text-center {
	text-align: center;
}
.es-badge {
	display: inline-block;
	padding: 0.25em 0.75em;
	font-size: 0.875rem;
	font-weight: 600;
	line-height: 1;
	text-align: center;
	white-space: nowrap;
	vertical-align: baseline;
	border-radius: 9999px;
	background-color: #e2e8f0;
	color: #4a5568;
}

/* --- Themes --- */
{if $esThemeTemplatePath}
	{include file=$esThemeTemplatePath}
{/if}

</style>

{if $es_showSubmissionsPerYear}
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
{/if}
<script>
document.addEventListener("DOMContentLoaded", function() {
	// Move the stats container below the About the Journal section
	var statsContainer = document.querySelector('.editorial-stats-plugin-container');
	var aboutSection = document.querySelector('.homepage_about');
	if (statsContainer && aboutSection) {
		aboutSection.parentNode.insertBefore(statsContainer, aboutSection.nextSibling);
	}

	{if $es_showSubmissionsPerYear}
	var ctx = document.getElementById('esSubmissionsChart');
	if (ctx) {
		var years = {$es_yearsList};
		var counts = {$es_countsList};
		
		new Chart(ctx, {
			type: 'bar',
			data: {
				labels: years,
				datasets: [{
					label: '{translate key="plugins.generic.editorialStats.submissions"}',
					data: counts,
					backgroundColor: '{$es_chartColor}',
					borderColor: '{$es_chartColor}',
					borderWidth: 1,
					borderRadius: 4
				}]
			},
			options: {
				indexAxis: 'y', // Makes it a horizontal bar chart
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					legend: {
						display: false
					},
					tooltip: {
						backgroundColor: 'rgba(15, 23, 42, 0.9)',
						titleFont: { size: 14, family: '-apple-system, sans-serif' },
						bodyFont: { size: 14, family: '-apple-system, sans-serif' },
						padding: 12,
						cornerRadius: 8,
						displayColors: false
					}
				},
				scales: {
					x: {
						beginAtZero: true,
						grid: {
							color: '#f1f5f9',
							drawBorder: false
						},
						ticks: {
							precision: 0,
							color: '{$es_theme}' === 'dark' ? '#94a3b8' : '#64748b'
						}
					},
					y: {
						grid: {
							display: false,
							drawBorder: false
						},
						ticks: {
							color: '{$es_theme}' === 'dark' ? '#cbd5e1' : '#475569',
							font: { weight: '600' }
						}
					}
				}
			}
		});
	}
	{/if}
});
</script>
