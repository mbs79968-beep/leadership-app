# LeadershipOS — Flutter Frontend

> An AI-powered leadership simulator. *Train your mind. Lead your world.*
> **Frontend only** — no backend, no AI logic. Every data source is a static stub
> in `lib/data/dummy/` so the full UI runs offline.

Design language: premium dark mode · executive · black + deep blue + silver ·
Bloomberg Terminal meets Netflix meets Duolingo.

---

## 1. Project folder structure

```
lib/
├── main.dart                      # entry point + ProviderScope
├── app.dart                       # MaterialApp.router root
│
├── core/                          # cross-cutting foundations
│   ├── constants/
│   │   └── routes.dart            # route path constants
│   ├── router/
│   │   └── app_router.dart        # go_router config + bottom-nav shell
│   ├── state/
│   │   └── app_providers.dart     # Riverpod providers (user, onboarding, sim)
│   └── theme/
│       ├── app_colors.dart        # color tokens + intensity() helper
│       ├── app_typography.dart    # Sora / Manrope / JetBrains Mono
│       ├── app_spacing.dart       # 8pt spacing + radii
│       └── app_theme.dart         # ThemeData + glass()/glow() helpers
│
├── data/
│   ├── models/
│   │   └── models.dart            # User, Scenario, Mission, Skill, Feedback…
│   └── dummy/
│       └── dummy_data.dart        # all mock content
│
├── features/                      # one folder per screen (feature-first)
│   ├── splash/splash_screen.dart
│   ├── onboarding/onboarding_screen.dart
│   ├── home/home_screen.dart                 # Mission Control
│   ├── simulation/simulation_screen.dart     # core immersive screen
│   ├── feedback/feedback_screen.dart
│   ├── growth/growth_dashboard_screen.dart
│   ├── library/scenario_library_screen.dart
│   └── mentor/mentor_screen.dart             # Atlas
│
└── shared/
    └── widgets/                   # reusable component system
        ├── ambient_background.dart   # atmospheric backdrop
        ├── app_shell.dart            # persistent bottom nav
        ├── atlas_avatar.dart         # pulsing AI presence
        ├── buttons.dart              # PrimaryButton / GhostButton
        ├── glass_card.dart           # GlassCard / SectionHeader / StatusChip
        ├── stat_card.dart            # StatCard / IntensityMeter
        └── charts.dart               # ProgressLineChart / SkillRadarChart / ScoreRing
```

**Why feature-first?** Each screen owns its file; shared visuals live in
`shared/widgets`; anything app-wide (theme, routing, state) lives in `core`.
Scales to a real backend by swapping `data/dummy` → `data/repositories`.

---

## 2. Screens (all built)

| Screen | File | Highlights |
|---|---|---|
| Splash | `splash_screen.dart` | Logo scale-in, tagline, auto-advance |
| Onboarding | `onboarding_screen.dart` | 5 steps: name, age, goal, weakness, experience |
| Mission Control | `home_screen.dart` | Level, streak, today's mission, quick-start, progress graph, Atlas insight, recent wins |
| **Simulation Room** | `simulation_screen.dart` | AI avatar, pressure + emotional meters, live timer, text + voice input |
| Feedback | `feedback_screen.dart` | 5 scores, overall ring, Atlas summary, mistakes, improvements |
| Growth | `growth_dashboard_screen.dart` | Skill radar, weekly line, progression, weakness trends |
| Scenario Library | `scenario_library_screen.dart` | 5 categories, filter chips, difficulty tags |
| Atlas (Mentor) | `mentor_screen.dart` | Daily counsel, memory thread, personalized missions |

---

## 3. Navigation setup

`go_router` with three layers:

- **Outside shell:** `/` (splash) → `/onboarding`
- **`ShellRoute`** (persistent bottom nav): `/home`, `/library`, `/growth`, `/mentor`
- **Full-screen flows** pushed on the root navigator: `/simulation`, `/feedback`
  (passed their data via `extra:`)

Tab switches use a fade transition; simulation/feedback push over everything so
the immersive screens own the full canvas. See `core/router/app_router.dart`.

---

## 4. UI component system

Reusable, theme-driven widgets — never hard-code a color or size in a screen:

- `GlassCard` — the frosted surface used everywhere (gradient + hairline border + shadow)
- `PrimaryButton` / `GhostButton` — gradient-glow CTA and ghost secondary
- `IntensityMeter` — animated bar; color auto-maps green→amber→red via `AppColors.intensity()`
- `StatCard` — compact metric tile
- `SectionHeader` / `StatusChip` — tracked uppercase labels and pill chips
- `ScoreRing` — animated circular score
- `ProgressLineChart` / `SkillRadarChart` — fl_chart wrappers themed to the palette
- `AtlasAvatar` — pulsing AI presence (breathing glow conveys "live")
- `AmbientBackground` — radial spotlight backdrop for depth

---

## 5. Best packages

| Package | Role | Why |
|---|---|---|
| `flutter_riverpod` | **State management** | Compile-safe, context-free, scales cleanly when stubs become real repos |
| `go_router` | Navigation | Declarative, shell routes, typed `extra` payloads |
| `google_fonts` | Typography | Sora (display) + Manrope (body) + JetBrains Mono (data) |
| `fl_chart` | Charts | Line + radar with full styling control |
| `flutter_animate` | Motion | Staggered reveals, pulses, micro-interactions |

**State management recommendation:** Riverpod. For a larger team you *could*
isolate the live Simulation engine into a Bloc, but Riverpod alone is the right
fit for a frontend this size. Providers already stubbed in `app_providers.dart`:
`userProfileProvider`, `onboardingProvider`, `simulationProvider` (a `family`
keyed by `Scenario`).

---

## 6. Theme configuration

Single dark theme (no light mode — the app is always "in the room").

- **Surfaces:** void black → obsidian → carbon → slate → steel (layered depth)
- **Brand:** deep blue → royal blue → electric (single accent, used sparingly)
- **Text:** platinum / silver / muted / faint
- **Signals:** success green · warning amber · danger red · gold (status/level)
- Helpers: `AppTheme.glass()`, `AppTheme.glow()`, `AppColors.intensity(v)`,
  `AppColors.accentGradient`

All tokens live in `core/theme/` — change the palette in one place, it updates everywhere.

---

## Run it

This package ships the `lib/` source + `pubspec.yaml`. Generate the platform
runners, then run:

```bash
cd leadershipos
flutter create .          # adds android/ ios/ etc. for THIS package
flutter pub get
flutter run
```

> First launch downloads the Google Fonts. Requires Flutter 3.22+ / Dart 3.4+.

---

## What's intentionally NOT here

Per brief: no backend, no AI inference, no auth, no real voice recognition.
The mic button, simulation pressure changes, and scores are deterministic stubs
in `app_providers.dart` / `dummy_data.dart` — wire them to your API/AI layer by
replacing those provider bodies. Screens won't need to change.
