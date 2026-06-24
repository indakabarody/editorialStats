# Editorial Stats Plugin for OJS 3.3

This plugin adds comprehensive **Editorial Statistics** to your OJS 3.3 installation, giving your users or administrators transparent insights into your journal's workflow performance.

## Features

- **Flexible Display Modes**: Choose where the statistics appear based on your journal's privacy needs:
  - **Homepage**: Displays beautifully formatted metric cards directly on the journal's homepage.
  - **Separate Page**: Displays the stats on a dedicated public page with a **customizable URL path** (e.g., `/editorial-stats`).
  - **Dashboard**: Restricts access to the stats to Journal Managers, Site Admins, and Sub Editors inside the OJS backend dashboard.
- **14 Visual Themes**:
  - The public statistics dashboard includes **14 unique visual themes** to perfectly match your journal's design: _Modern, Monochrome, Outline, Dark Mode, Glassmorphism, Neumorphism, Brutalism, Corporate, Gradient, Material Design, Soft Pastel, Cyberpunk, Elegant,_ and _Playful_.
  - You can instantly switch between these themes directly from the plugin settings.
- **Adaptive Backend UI**:
  - In the backend (Dashboard), the stats automatically adapt to use OJS's native `pkpStats` and `pkpTable` components for a seamless, professional administrative experience.
- **Toggleable Metrics**: Easily turn individual metrics on or off from the plugin's settings page.
- **Custom Chart Color**: Customize the color of the bar chart for "Submissions Per Year" to match your journal's branding.

## Available Metrics

- **General metrics**: Total Submissions, Published, In Progress, Declined.
- **Performance metrics**: Acceptance Rate (%), Avg. Days to Publish, Reviews Completed, Active Reviewers.
- **Submissions Per Year**: Horizontal Bar Chart (Frontend) or Data Table (Backend). Includes a customizable color picker for the chart bars.
- **Published Articles per Section**: Table showing the count of published articles categorized by journal section.

## Installation & Configuration

1. Upload the `editorialStats` folder to the `plugins/generic/` directory of your OJS installation.
2. Log in as a Journal Manager or Site Administrator.
3. Go to **Settings > Website > Plugins**.
4. Enable the **Editorial Stats** plugin under the _Generic Plugins_ section.
5. Click the blue arrow next to the plugin name and select **Settings** to choose your preferred Display Mode, customize the URL path, select a Visual Theme, and toggle specific metrics.

## Language Support

- English (`en_US`)
- Indonesian (`id_ID`)

## License

Copyright (c) 2026 Indaka Barody  
Distributed under the GNU GPL v3.
