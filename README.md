# Editorial Stats Plugin for OJS 3.3

This plugin adds comprehensive **Editorial Statistics** to your OJS 3.3 installation, giving your users or administrators transparent insights into your journal's workflow performance.

## Features

- **Flexible Display Modes**: Choose where the statistics appear based on your journal's privacy needs:
  - **Homepage**: Displays beautifully formatted metric cards directly on the journal's homepage.
  - **Separate Page**: Displays the stats on a dedicated public page (`/editorialStats`).
  - **Dashboard Only**: Restricts access to the stats to Journal Managers, Site Admins, and Sub Editors inside the OJS backend dashboard.
- **Adaptive UI**:
  - In the frontend (Homepage/Separate Page), the stats are displayed using rich aesthetics with a colorful metric grid and an interactive Chart.js bar graph.
  - In the backend (Dashboard), the stats automatically adapt to use OJS's native `pkpStats` and `pkpTable` components for a seamless, professional administrative experience.
- **Toggleable Metrics**: Easily turn individual metrics on or off from the plugin's settings page.

## Available Metrics

- **General metrics**: Total Submissions, Published, In Progress, Declined.
- **Performance metrics**: Acceptance Rate (%), Avg. Days to Publish, Reviews Completed, Active Reviewers.
- **Submissions Per Year**: Horizontal Bar Chart (Frontend) or Data Table (Backend).
- **Published Articles per Section**: Table showing the count of published articles categorized by journal section.

## Installation & Configuration

1. Upload the `editorialStats` folder to the `plugins/generic/` directory of your OJS installation.
2. Log in as a Journal Manager or Site Administrator.
3. Go to **Settings > Website > Plugins**.
4. Enable the **Editorial Stats** plugin under the *Generic Plugins* section.
5. Click the blue arrow next to the plugin name and select **Settings** to choose your preferred Display Mode and toggle specific metrics.

## Language Support

- English (`en_US`)
- Indonesian (`id_ID`)

## License

Copyright (c) 2026 Indaka Barody  
Distributed under the GNU GPL v3.
