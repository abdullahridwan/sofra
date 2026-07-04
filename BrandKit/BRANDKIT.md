# Sofra Brand Kit

Halal food, mapped. Everything needed to apply the Sofra brand lives in this folder.

![Brand kit overview](brand-kit-overview.png)

## Wordmark

![Wordmark](wordmark.png)

Set in Fraunces, medium weight, tight tracking. Use on the splash screen, marketing site, and any full lockup context. Don't recolor it outside the palette below.

## Icon mark

![Icon mark](icon-mark.png)

A bold Fraunces "S," red on white, bled to the edges of the frame rather than centered with heavy padding. This is the source for the App Store icon (see `Sofra/Assets.xcassets/AppIcon.appiconset`). Flat square, no pre-baked corner rounding, no alpha channel, iOS applies its own mask.

## Color

| Token | Hex | Usage |
|---|---|---|
| Background | `#FFFFFF` | Primary background |
| Surface | `#F6F4F2` | Cards, subtle fills |
| Border | `#E7E3DE` | Hairline dividers/borders |
| Text | `#2B2320` | Primary text (warm charcoal, not pure black) |
| Text Muted | `#7A6F66` | Secondary text, addresses, captions |
| Primary | `#E62336` | Vivid red. Brand accent, map pins, active states, any brand moment |
| Blue | `#007AFF` | Apple-standard blue. Bookmarked map pins, bookmark icons, Directions button |

Two functional accents: red and blue. Red owns brand moments and regular map pins. Blue is the action/navigation color: bookmarks, directions, anything the user does. Keep them separate; don't swap their roles.

## Typography

- **Display**: Fraunces, medium/semibold weight. Restaurant names, headers, the wordmark. Warm serif, carries the brand's personality.
- **Body / Label**: Inter, regular/medium weight. Addresses, buttons, captions, anything functional. Neutral and highly legible.

Both are variable fonts (`Fraunces-Variable.ttf`, `Inter-Variable.ttf` in this folder), registered at runtime in the app via `Theme.swift` / `FontRegistrar`, no static weight files needed.

## Where this is wired into the app

`Sofra/Theme.swift` is the single source of truth in code, `SofraTheme` exposes the colors above and `SofraTheme.Typography` exposes the two type roles. Applied in:

- `SplashScreen.swift`: wordmark, background
- `LocationPreview/LocationPreviewView.swift`: map pin tint (primary for regular, blue for bookmarked); search filters visible pins
- `SingleLocationView/SingleLocationView.swift`: restaurant name (text), address (textMuted), bookmark toggle (blue/textMuted), directions button (blue)
- `FavoritesButton.swift`: Sofra wordmark pill (text/background), expandable search bar, bookmark bubble (blue)
- `FavoritesView.swift`: bookmarked locations list

If the palette or type scale changes, update `Theme.swift` and this file together so they don't drift.
