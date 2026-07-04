<p align="center">
  <img src="BrandKit/banner.png" alt="Sofra — halal food, mapped" width="100%" />
</p>

# Sofra

A halal restaurant map for NYC. Browse the map, favorite spots, get directions, no guesswork about what's actually halal.

## Status

Pre-launch. Core app works end to end; a few things are intentionally not built yet. If you're picking this up, here's the real state:

**Working**
- Map of ~120 halal spots across Brooklyn, Queens, Manhattan, and the Bronx, seeded from `HalalEats/locations.json`
- Tap a pin → name, address, a Look Around preview, favorite toggle, and a "Directions" button that opens Apple Maps
- Favorites list
- Brand identity (icon, fonts, colors) fully wired into the app, see [`BrandKit/`](BrandKit/)

**Not built yet, don't assume it exists**
- No search or filtering (by cuisine, price, etc.)
- No "use my location" / distance sorting, no `CLLocationManager` in the codebase yet
- `locations.json` has a couple of known duplicate entries (e.g. "BK Jani" / "BK JANI") that need deduping before submission
- Not yet submitted to the App Store

## Tech stack

- SwiftUI + MapKit (native `Map`/`Marker`, no third-party map SDK)
- SwiftData for persistence (`MyFavoriteLocation`, seeded from the bundled JSON on first launch)
- Fraunces (display) + Inter (body/UI), both variable fonts, registered at runtime, see `HalalEats/Theme.swift`

## Project structure

```
HalalEats/
  HalalEatsApp.swift          entry point, registers custom fonts on launch
  ContentView.swift            splash → map root
  SplashScreen.swift            loads locations.json into SwiftData on first run
  Theme.swift                  brand colors + typography, single source of truth in code
  LocationPreview/              the map screen
  SingleLocationView/            the bottom-sheet location card
  Models/                       SwiftData models (MyFavoriteLocation, Collection, ...)
  Fonts/                        Fraunces-Variable.ttf, Inter-Variable.ttf
  Assets.xcassets/               app icon, accent color, splash assets
BrandKit/                     brand reference: wordmark, icon export, palette + type docs
```

## Getting started

1. Clone and open `HalalEats.xcodeproj` in Xcode (15.3+, iOS 17.4+ deployment target)
2. Build and run on a simulator or device, no API keys or config needed, everything is local (bundled JSON + native MapKit)

## Brand kit

Colors, type scale, wordmark, and icon source all live in [`BrandKit/BRANDKIT.md`](BrandKit/BRANDKIT.md). If you're touching UI, check there before introducing a new color or font, `Theme.swift` should stay the only place brand values are defined in code.

## Roadmap

Roughly in order:
1. Dedupe `locations.json`
2. "Use my location" + distance sort
3. Basic search/filter
4. Real App Store screenshots and listing copy
5. Submit
