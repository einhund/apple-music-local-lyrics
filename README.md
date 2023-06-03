# apple-music-local-lyrics

Fetch lyrics and description from Apple Music and Genius for iPod.

Tested on `macOS Monterey 12.6.5` & `Music 1.2.5.7`.

![demo](/demo.jpg)

## Usage

### Prerequisites

* Music app on macOS
* Network connection

If you would like to fetch lyrics from Apple Music, you also need:

* Songs purchased from iTunes Store (songs shared by others work, too)
* Apple Music subscription (trial is enough)

### Steps

1. Open Music app and select songs you need offline lyrics for (if none selected, all songs will be processed) 
2. Open script file with Script Editor app
3. Switch syntax from AppleScript to JavaScript
4. Run script (⌘R)
5. Wait for it to complete (can run in background)

### Configurations

Script can be configured by modifying these constants:

```
const overwriteLyrics = false;          // true if intend to overwrite existing lyrics
const overwriteComment = false;         // true if intend to overwrite existing comment
const addComment = true;                // false if not intend to add description to comment
const sources = [ "genius", "apple" ];  // sources to be used, former with higher priority
```

### Output Example

```
Selected 20 tracks.
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots: No lyrics available on Apple Music, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots: Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Hostiles: Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - Hostiles: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Hostiles: Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Lonely Press Play: Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - Lonely Press Play: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Lonely Press Play: Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Mr Tembo: Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - Mr Tembo: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Mr Tembo: Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Parakeet: Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - Parakeet: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Parakeet: No lyrics available on Genius, skipping...
Damon Albarn - Everyday Robots (Special Edition) - The Selfish Giant: Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - The Selfish Giant: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - The Selfish Giant: Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - You & Me: Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - You & Me: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - You & Me: Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Hollow Ponds: Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - Hollow Ponds: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Hollow Ponds: Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Seven High: No lyrics available on Apple Music, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Seven High: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Seven High: No lyrics available on Genius, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Photographs (You Are Taking Now): Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - Photographs (You Are Taking Now): Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - The History of a Cheating Heart: Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - The History of a Cheating Heart: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - The History of a Cheating Heart: Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Heavy Seas of Love: Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - Heavy Seas of Love: Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Heavy Seas of Love: Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Father's Daughter's Son (bonus track): Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - Father's Daughter's Son (bonus track): Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Empty Club (bonus track): Lyrics added from Apple Music.
Damon Albarn - Everyday Robots (Special Edition) - Empty Club (bonus track): Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Empty Club (bonus track): Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots (Track by Track): No lyrics available on Apple Music, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots (Track by Track): Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots (Track by Track): Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots (Live from Fox Studios Los Angeles): No lyrics available on Apple Music, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots (Live from Fox Studios Los Angeles): Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Everyday Robots (Live from Fox Studios Los Angeles): Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Hostiles (Live from Fox Studios Los Angeles): No lyrics available on Apple Music, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Hostiles (Live from Fox Studios Los Angeles): Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Hostiles (Live from Fox Studios Los Angeles): Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Lonely Press Play (Live from Fox Studios Los Angeles): No lyrics available on Apple Music, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Lonely Press Play (Live from Fox Studios Los Angeles): Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Lonely Press Play (Live from Fox Studios Los Angeles): Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Hollow Ponds (Live from Fox Studios Los Angeles): No lyrics available on Apple Music, skipping...
Damon Albarn - Everyday Robots (Special Edition) - Hollow Ponds (Live from Fox Studios Los Angeles): Comment added.
Damon Albarn - Everyday Robots (Special Edition) - Hollow Ponds (Live from Fox Studios Los Angeles): Lyrics added from Genius.
Damon Albarn - Everyday Robots (Special Edition) - Digital Booklet - Everyday Robots (Special Edition): Booklet (or iTunes LP), skipping...
20 tracks processed, lyrics added from Apple Music for 12 tracks, lyrics added from Genius for 17 tracks, 0 skipped for existing lyrics, 8 skipped for no available lyrics, 1 booklets (or iTunes LPs), comment added for 17 tracks.
```

### Troubleshooting

* No privilege: Go to `System Preferences` app, `Security & Privacy` - `Accessibility`, allow `Script Editor.app` to control your computer
* Other issues: Sometimes it gives random errors, just reselect the songs and rerun the script

## License

This repository is published under [GNU General Public License v3.0](/LICENSE).
