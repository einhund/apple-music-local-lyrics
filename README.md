# apple-music-local-lyrics

Fetch lyrics from Apple Music for songs purchased from iTunes Store.

Tested on `macOS Monterey 12.6.5` & `Music 1.2.5.7`.

## Usage

### Prerequisites

* Music app on macOS
* Songs purchased from iTunes Store
* Apple Music subscription (trial is enough)

### Steps

1. Open Music app and select songs you need offline lyrics for
2. Open Script Editor app and paste content of script file
3. Switch syntax from AppleScript to JavaScript
4. Run script (⌘R)
5. Wait for it to complete

### Output Example

```
Selected 18 tracks.
Damon Albarn - Dr Dee - The Golden Dawn: No lyrics available, skipping...
Damon Albarn - Dr Dee - Apple Carts: Has lyrics, skipping...
Damon Albarn - Dr Dee - O Spirit, Animate Us: Has lyrics, skipping...
Damon Albarn - Dr Dee - The Moon Exalted: Lyrics added.
Damon Albarn - Dr Dee - A Man of England: Lyrics added.
Damon Albarn - Dr Dee - Saturn: No lyrics available, skipping...
Damon Albarn - Dr Dee - Coronation: Lyrics added.
Damon Albarn - Dr Dee - The Marvelous Dream: Lyrics added.
Damon Albarn - Dr Dee - A Prayer: Lyrics added.
Damon Albarn - Dr Dee - Edward Kelley: Lyrics added.
Damon Albarn - Dr Dee - Preparation: Lyrics added.
Damon Albarn - Dr Dee - 9 Point Star: Lyrics added.
Damon Albarn - Dr Dee - Temptation Comes in the Afternoon: Lyrics added.
Damon Albarn - Dr Dee - Watching the Fire That Waltzed Away: Lyrics added.
Damon Albarn - Dr Dee - Moon (Interlude): No lyrics available, skipping...
Damon Albarn - Dr Dee - Cathedrals: Lyrics added.
Damon Albarn - Dr Dee - Tree of Beauty: Lyrics added.
Damon Albarn - Dr Dee - The Dancing King: Lyrics added.
18 tracks processed, lyrics added for 13 tracks, 2 skipped for existing lyrics, 3 skipped for no available lyrics.
```

### Troubleshooting

* No privilege: Go to `System Preferences` app, `Security & Privacy` - `Accessibility`, allow `Script Editor.app` to control your computer
* Other issues: Sometimes it gives random errors, just reselect the songs and rerun the script

## License

This repository is published under [GNU General Public License v3.0](/LICENSE).
