# Editorial Stats Plugin

This plugin adds comprehensive **Editorial Statistics** to your OJS installation, giving your users or administrators transparent insights into your journal's workflow performance.

## Compatibility

- **OJS 3.3**: Fully compatible and tested.
- **OJS 3.1**: Fully compatible and tested (Note: The "Dashboard" display mode is automatically disabled on OJS 3.1 due to backend template limitations).
- **OJS 3.2**: Untested (Note: The "Dashboard" display mode is also disabled for OJS 3.2).

## Features

- **Flexible Display Modes**: Choose where the statistics appear based on your journal's privacy needs:
  - **Homepage**: Displays beautifully formatted metric cards directly on the journal's homepage.
  - **Separate Page**: Displays the stats on a dedicated public page with a **customizable URL path** (e.g., `/editorial-stats`).
  - **Dashboard (OJS 3.3+ Only)**: Restricts access to the stats to Journal Managers, Site Admins, and Sub Editors inside the OJS backend dashboard.
- **Data Caching & Update Frequency**:
  - The plugin performs heavy database queries to generate statistics. To prevent performance issues on your journal, the plugin includes a built-in caching mechanism.
  - You can configure the **Update Frequency** in the settings to: `Always (No cache)`, `Daily`, `Weekly`, or `Monthly`. The plugin safely stores the serialized cache natively in the OJS database.
- **14 Visual Themes**:
  - The public statistics dashboard includes **14 unique visual themes** to perfectly match your journal's design: _Modern, Monochrome, Outline, Dark Mode, Glassmorphism, Neumorphism, Brutalism, Corporate, Gradient, Material Design, Soft Pastel, Cyberpunk, Elegant,_ and _Playful_.
  - You can instantly switch between these themes directly from the plugin settings.
- **Adaptive Backend UI**:
  - In the backend (Dashboard mode for OJS 3.3+), the stats automatically adapt to use OJS's native components for a seamless, professional administrative experience.
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
5. Click the blue arrow next to the plugin name and select **Settings** to choose your preferred Display Mode, caching frequency, URL path, Visual Theme, and toggle specific metrics.

## Language Support

- English (`en_US`)
- Indonesian (`id_ID`)

## License

Copyright (c) 2026 Indaka Barody  
Distributed under the GNU GPL v3.
