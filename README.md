# apple-music-local-lyrics

Fetch lyrics from Apple Music for songs purchased from iTunes Store.

Tested on `macOS Monterey 12.6.5` & `Music 1.2.5.7`.

## Usage

### Prerequisites

* Music app on macOS
* Songs purchased from iTunes Store (songs shared by others work, too)
* Apple Music subscription (trial is enough)

### Steps

1. Open Music app and select songs you need offline lyrics for
2. Open Script Editor app and paste content of script file
3. Switch syntax from AppleScript to JavaScript
4. Run script (⌘R)
5. Wait for it to complete (can run in background)

### Output Example

```
Selected 20 tracks.
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots: No lyrics available, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Hostiles: Has lyrics, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Lonely Press Play: Has lyrics, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Mr Tembo: Has lyrics, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Parakeet: Has lyrics, skipping...
Damon Albarn - Everyday Robots (Special Edition) - The Selfish Giant: Has lyrics, skipping...
Damon Albarn - Everyday Robots (Special Edition) - You & Me: Has lyrics, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Hollow Ponds: Has lyrics, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Seven High: No lyrics available, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Photographs (You Are Taking Now): Lyrics added.
Damon Albarn - Everyday Robots (Special Edition) - The History of a Cheating Heart: Lyrics added.
Damon Albarn - Everyday Robots (Special Edition) - Heavy Seas of Love: Lyrics added.
Damon Albarn - Everyday Robots (Special Edition) - Father's Daughter's Son (bonus track): Lyrics added.
Damon Albarn - Everyday Robots (Special Edition) - Empty Club (bonus track): Lyrics added.
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots (Track by Track): No lyrics available, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots (Live from Fox Studios Los Angeles): No lyrics available, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Hostiles (Live from Fox Studios Los Angeles): No lyrics available, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Lonely Press Play (Live from Fox Studios Los Angeles): No lyrics available, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Hollow Ponds (Live from Fox Studios Los Angeles): No lyrics available, skipping...
 - Everyday Robots (Special Edition) - Digital Booklet - Everyday Robots (Special Edition): Booklet, skipping...
20 tracks processed, lyrics added for 5 tracks, 7 skipped for existing lyrics, 7 skipped for no available lyrics, 1 booklets.
```

### Troubleshooting

* No privilege: Go to `System Preferences` app, `Security & Privacy` - `Accessibility`, allow `Script Editor.app` to control your computer
* Other issues: Sometimes it gives random errors, just reselect the songs and rerun the script

## License

This repository is published under [GNU General Public License v3.0](/LICENSE).
