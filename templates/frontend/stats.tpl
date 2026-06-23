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

/* Theme: Monochrome */
.es-theme-monochrome .es-card { border-left-color: transparent !important; }
.es-theme-monochrome .es-card-icon { background: #f1f5f9 !important; color: #334155 !important; }
.es-theme-monochrome .es-badge { background-color: #f1f5f9; color: #334155; }

/* Theme: Outline */
.es-theme-outline .es-card { background: transparent; border: 1px solid #e2e8f0; border-left-width: 5px; box-shadow: none; }
.es-theme-outline .es-box { background: transparent; border: 1px solid #e2e8f0; box-shadow: none; }
.es-theme-outline .es-card:hover { box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05); }

/* Theme: Dark */
.es-theme-dark { color: #f8fafc; }
.es-theme-dark .es-title, .es-theme-dark .es-subtitle { color: #f8fafc; }
.es-theme-dark .es-card, .es-theme-dark .es-box { background: #1e293b; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3); border-color: #334155; }
.es-theme-dark .es-card-value { color: #f8fafc; }
.es-theme-dark .es-card-label { color: #94a3b8; }
.es-theme-dark .es-table th { border-bottom-color: #334155; color: #cbd5e1; }
.es-theme-dark .es-table td { border-bottom-color: #334155; color: #f8fafc; }
.es-theme-dark .es-badge { background-color: #334155; color: #f8fafc; }
.es-theme-dark .es-card-icon { background: rgba(255, 255, 255, 0.1) !important; }

/* Theme: Glassmorphism */
.es-theme-glassmorphism .es-card, .es-theme-glassmorphism .es-box {
	background: rgba(255, 255, 255, 0.4);
	backdrop-filter: blur(10px);
	-webkit-backdrop-filter: blur(10px);
	border: 1px solid rgba(255, 255, 255, 0.3);
	box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.05);
	border-left-width: 5px;
}

/* Theme: Neumorphism */
.es-theme-neumorphism .es-card, .es-theme-neumorphism .es-box {
	background: #e0e5ec;
	border: none;
	box-shadow: 9px 9px 16px rgb(163, 177, 198, 0.6), -9px -9px 16px rgba(255, 255, 255, 0.5);
}
.es-theme-neumorphism .es-card:hover {
	transform: none;
	box-shadow: inset 6px 6px 10px 0 rgba(163, 177, 198, 0.6), inset -6px -6px 10px 0 rgba(255, 255, 255, 0.5);
}

/* Theme: Brutalism */
.es-theme-brutalism .es-card, .es-theme-brutalism .es-box {
	background: #fff;
	border: 3px solid #000;
	border-radius: 0;
	box-shadow: 6px 6px 0px #000;
	transition: transform 0.1s, box-shadow 0.1s;
}
.es-theme-brutalism .es-card:hover {
	transform: translate(2px, 2px);
	box-shadow: 4px 4px 0px #000;
}
.es-theme-brutalism .es-card-icon { border: 2px solid #000; border-radius: 0; }
.es-theme-brutalism .es-badge { border: 2px solid #000; border-radius: 0; background: #fff; color: #000; font-weight: 800; }
.es-theme-brutalism .es-title, .es-theme-brutalism .es-subtitle { color: #000; font-weight: 900; text-transform: uppercase; }
.es-theme-brutalism .es-card-value { color: #000; font-weight: 900; }
.es-theme-brutalism .es-table th { border-bottom: 3px solid #000; color: #000; font-weight: 900; }
.es-theme-brutalism .es-table td { border-bottom: 1px solid #000; color: #000; font-weight: bold; }

/* Theme: Corporate */
.es-theme-corporate .es-card, .es-theme-corporate .es-box {
	background: #ffffff;
	border: 1px solid #e2e8f0;
	border-radius: 2px;
	box-shadow: none;
}
.es-theme-corporate .es-card { border-left: 4px solid #334155; }
.es-theme-corporate .es-card-icon { background: transparent !important; color: #475569 !important; border-radius: 2px; }
.es-theme-corporate .es-title, .es-theme-corporate .es-subtitle { color: #1e293b; text-transform: uppercase; font-size: 1rem; letter-spacing: 0.05em; }
.es-theme-corporate .es-card-label { color: #64748b; font-size: 0.75rem; }

/* Theme: Gradient */
.es-theme-gradient .es-card { border: none; color: #fff; }
.es-theme-gradient .es-card-value, .es-theme-gradient .es-card-label { color: #fff; }
.es-theme-gradient .es-card-icon { background: rgba(255,255,255,0.2) !important; color: #fff !important; }
.es-theme-gradient .es-blue { background: linear-gradient(135deg, #3b82f6, #2563eb); }
.es-theme-gradient .es-green { background: linear-gradient(135deg, #10b981, #059669); }
.es-theme-gradient .es-orange { background: linear-gradient(135deg, #f59e0b, #ea580c); }
.es-theme-gradient .es-red { background: linear-gradient(135deg, #ef4444, #dc2626); }
.es-theme-gradient .es-purple { background: linear-gradient(135deg, #8b5cf6, #7c3aed); }
.es-theme-gradient .es-teal { background: linear-gradient(135deg, #14b8a6, #0d9488); }
.es-theme-gradient .es-indigo { background: linear-gradient(135deg, #6366f1, #4f46e5); }
.es-theme-gradient .es-pink { background: linear-gradient(135deg, #ec4899, #db2777); }
/* Theme: Material Design */
.es-theme-material .es-card, .es-theme-material .es-box {
	background: #fff;
	border: none;
	border-radius: 4px;
	box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
	transition: all 0.3s cubic-bezier(.25,.8,.25,1);
}
.es-theme-material .es-card:hover {
	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}
.es-theme-material .es-card-icon {
	border-radius: 50%;
	width: 50px;
	height: 50px;
	box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

/* Theme: Soft Pastel */
.es-theme-pastel .es-card, .es-theme-pastel .es-box {
	background: #fdfbf7;
	border: 2px solid #f1e9db;
	border-radius: 16px;
	box-shadow: none;
	color: #5c5c5c;
}
.es-theme-pastel .es-title, .es-theme-pastel .es-subtitle { color: #8e8579; font-weight: 600; }
.es-theme-pastel .es-blue { background: #e3f2fd; border-color: #bbdefb; color: #1e88e5; }
.es-theme-pastel .es-blue .es-card-value { color: #1e88e5; }
.es-theme-pastel .es-green { background: #e8f5e9; border-color: #c8e6c9; color: #43a047; }
.es-theme-pastel .es-green .es-card-value { color: #43a047; }
.es-theme-pastel .es-orange { background: #fff3e0; border-color: #ffe0b2; color: #fb8c00; }
.es-theme-pastel .es-orange .es-card-value { color: #fb8c00; }
.es-theme-pastel .es-red { background: #ffebee; border-color: #ffcdd2; color: #e53935; }
.es-theme-pastel .es-red .es-card-value { color: #e53935; }
.es-theme-pastel .es-purple { background: #f3e5f5; border-color: #e1bee7; color: #8e24aa; }
.es-theme-pastel .es-purple .es-card-value { color: #8e24aa; }
.es-theme-pastel .es-teal { background: #e0f2f1; border-color: #b2dfdb; color: #00897b; }
.es-theme-pastel .es-teal .es-card-value { color: #00897b; }
.es-theme-pastel .es-indigo { background: #e8eaf6; border-color: #c5cae9; color: #3949ab; }
.es-theme-pastel .es-indigo .es-card-value { color: #3949ab; }
.es-theme-pastel .es-pink { background: #fce4ec; border-color: #f8bbd0; color: #d81b60; }
.es-theme-pastel .es-pink .es-card-value { color: #d81b60; }
.es-theme-pastel .es-card-icon { background: rgba(255,255,255,0.5) !important; color: inherit !important; border-radius: 12px; }

/* Theme: Cyberpunk */
.es-theme-cyberpunk { color: #fff; }
.es-theme-cyberpunk .es-title, .es-theme-cyberpunk .es-subtitle { color: #0ff; text-shadow: 0 0 5px #0ff; text-transform: uppercase; letter-spacing: 2px; }
.es-theme-cyberpunk .es-card, .es-theme-cyberpunk .es-box {
	background: #090909;
	border: 1px solid #f0f;
	box-shadow: 0 0 10px rgba(255, 0, 255, 0.5), inset 0 0 5px rgba(255, 0, 255, 0.2);
	border-radius: 0;
	color: #fff;
}
.es-theme-cyberpunk .es-card:hover { border-color: #0ff; box-shadow: 0 0 15px rgba(0, 255, 255, 0.8), inset 0 0 10px rgba(0, 255, 255, 0.3); }
.es-theme-cyberpunk .es-card-value { color: #ff003c; text-shadow: 0 0 8px #ff003c; font-family: monospace; font-size: 2.5rem; }
.es-theme-cyberpunk .es-card-label { color: #0ff; font-family: monospace; letter-spacing: 1px; }
.es-theme-cyberpunk .es-card-icon { background: transparent !important; color: #f0f !important; text-shadow: 0 0 10px #f0f; border-radius: 0; }
.es-theme-cyberpunk .es-card:hover .es-card-icon { color: #0ff !important; text-shadow: 0 0 10px #0ff; }
.es-theme-cyberpunk .es-table th { border-bottom-color: #f0f; color: #0ff; font-family: monospace; }
.es-theme-cyberpunk .es-table td { border-bottom-color: #333; color: #fff; font-family: monospace; }
.es-theme-cyberpunk .es-badge { background-color: #f0f; color: #000; font-weight: bold; border-radius: 0; box-shadow: 0 0 5px #f0f; }
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
	// Move the stats container below the About the Journal section
	var statsContainer = document.querySelector('.editorial-stats-plugin-container');
	var aboutSection = document.querySelector('.homepage_about');
	if (statsContainer && aboutSection) {
		aboutSection.parentNode.insertBefore(statsContainer, aboutSection.nextSibling);
	}

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
					backgroundColor: 'rgba(59, 130, 246, 0.8)',
					borderColor: 'rgba(37, 99, 235, 1)',
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
});
</script>
