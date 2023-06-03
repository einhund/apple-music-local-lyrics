ObjC.import('Cocoa')

// Config

const overwriteLyrics = false;
const overwriteComment = false;
const addComment = true;
const sources = [ "genius", "apple" ];

// Utils

function fetchURL(url) {
  const data = $.NSData.dataWithContentsOfURL($.NSURL.URLWithString(url));
  const string = ObjC.unwrap($.NSString.alloc.initWithDataEncoding(data, $.NSUTF8StringEncoding));
  return string;
}

const availableSources = {
  apple: processTrackWithAppleMusic,
  genius: processTrackWithGenius,
};

// Cache

const albumLib = {};

// Stats

let skipped = 0;
let addedApple = 0;
let addedGenius = 0;
let unavailable = 0;
let booklet = 0;
let comment = 0;

// Functions

function normalised(string) {
  return string.normalize("NFKD").replace(/\p{Diacritic}/gu, "").toLowerCase();
}

function logItemForTrack(track) {
  return `${track.albumArtist() || track.artist()} - ${track.album()} - ${track.name()}`;
}

function processTrack(track) {
  if (["HLS media"].includes(track.kind())) {
    // will encounter permission error for protected content
    console.log(`${logItemForTrack(track)}: Protected content, skipping...`);
    unavailable++;
    return;
  }
  if (["PDF document", "iTunes LP"].includes(track.kind())) {
    console.log(`${logItemForTrack(track)}: Booklet (or iTunes LP), skipping...`);
    booklet++;
    return;
  }

  const shouldSkipLyrics = !overwriteLyrics && track.lyrics();
  if (shouldSkipLyrics) {
    console.log(`${logItemForTrack(track)}: Has lyrics, skipping...`);
    skipped++;
  }
  const shouldSkipComment = addComment ? !overwriteComment && track.comment() : true;
  if (addComment && shouldSkipComment) {
    console.log(`${logItemForTrack(track)}: Has comment, skipping...`);
  }
  // reverse here to make the former have higher priority
  [...sources].reverse().forEach(s => availableSources[s](track, shouldSkipLyrics, shouldSkipComment));
}

function processTrackWithAppleMusic(track, shouldSkipLyrics) {
  if (shouldSkipLyrics) return;

  // cache lyrics before checking in case Apple Music doesn't have it
  let cachedLyrics = track.lyrics();
  track.lyrics = "";

  track.reveal(); // select() doesn't work for some unknown reason
  process.menuBars[0].menus["Song"].menuItems["InfoÉ"].click(); // open info window
  const windows = process.windows;
  let info;
  if (windows.name().includes("Song Info")) {
    // this is a song or a booklet
    info = windows["Song Info"];
  } else if (windows.name().includes("Music Video Info")) {
    // this is a music video
    info = windows["Music Video Info"];
  } else {
    console.log(`${logItemForTrack(track)}: Unknown kind, skipping...`);
    unavailable++;
    return;
  }
  const tabButtons = info.radioGroups.radioButtons;
  if (!tabButtons.name()[0].includes("Lyrics")) {
    // this is a booklet (or iTunes LP)
    // theoretically the precheck should prevent script from going into this block
    console.log(`${logItemForTrack(track)}: Booklet, skipping...`);
    booklet++;
  } else {
    tabButtons["Lyrics"].click(); // switch to lyrics tab
    while (info.groups[0].busyIndicators.length > 0) {
      // wait for loading (this only works for JXA)
    }
    if (info.groups[0].scrollAreas.length == 0) {
      // no scroll area if no lyrics available
      console.log(`${logItemForTrack(track)}: No lyrics available on Apple Music, skipping...`);
      if (cachedLyrics) {
        track.lyrics = cachedLyrics; // revert to cached if possible
      } else {
        unavailable++;
      }
    } else {
      const lyrics = info.groups[0].scrollAreas[0].textAreas[0].value();
      track.lyrics = lyrics;
      console.log(`${logItemForTrack(track)}: Lyrics added from Apple Music.`);
      addedApple++;
    }
  }
  info.buttons["OK"].click();
}

function processTrackWithGenius(track, shouldSkipLyrics, shouldSkipComment) {
  if (shouldSkipLyrics && shouldSkipComment) return;

  // Extract basic information

  // prefer album artist since artist sometimes includes other people, could pollute search parameters
  const artist = normalised(track.albumArtist() || track.artist());
  // remove contents between parentheses and brackets, they could pollute search parameters
  //   examples: (Deluxe Version), (Special Edition)
  // meanwhile, keep it if the title begins with one
  //   example: (What's The Story) Morning Glory? [Deluxe Remastered Edition]
  const album = normalised(track.album())
    .replace(/ +\[[^\]]*]/g, '')
    .replace(/ +\([^\)]*\)/g, '')
    .replace(/ *- *(Single|EP)/g, '');
  // remove contents between parentheses and brackets, they could pollute search parameters
  //   example: [Remastered]
  const title = normalised(track.name())
    .replace(/ +\[[^\]]*]/g, '')
    .replace(/ +\([^\)]*\)/g, '');

  // Search for album

  let albumData = albumLib[album];
  if (!albumData) {
    const searchTerm = `${artist} ${album}`;
    const searchURL = `https://genius.com/api/search/multi?q=${encodeURIComponent(searchTerm)}`;
    try {
      const albumURL = JSON.parse(fetchURL(searchURL)).response.sections.filter(s => s.type === "album" )[0].hits[0].result.url;
      const albumPath = albumURL.replace(/^https:\/\/genius.com/, "");
      const albumDataURL = `https://genius.com/api/page_data/album?page_path=${encodeURIComponent(albumPath)}`;
      albumData = JSON.parse(fetchURL(albumDataURL)).response.page_data;
      albumLib[album] = albumData;
    } catch (e) {
      console.log(e);
    }
  }

  let songID;
  try {
    if (!albumData) {
      // search for song within album
      // match name first, then track number
      songID = (
        albumData.album_appearances.filter(a => normalised(a.song.title).includes("title"))[0]
        || albumData.album_appearances.filter(a => a.track_number === track.trackNumber())[0]
      ).song.id;
    } else {
      // Search for song directly
      const songSearchTerm = `${artist} ${title}`;
      const songSearchURL = `https://genius.com/api/search/multi?q=${encodeURIComponent(songSearchTerm)}`;
      songID = JSON.parse(fetchURL(songSearchURL)).response.sections.filter(s => s.type === "song" )[0].hits[0].result.id;
    }
  } catch (e) {
    console.log(e);
  }

  if (songID > 0) {
    try {
      const songURL = `https://genius.com/api/songs/${encodeURIComponent(songID)}`;
      const songData = JSON.parse(fetchURL(songURL)).response.song;

      // add description to comment
      // unfortunately there is a length limit of 255 characters
      const description = songData.description_preview;
      if (!shouldSkipComment && description) {
        track.comment = description;
        console.log(`${logItemForTrack(track)}: Comment added.`);
        comment++;
      }

      if (shouldSkipLyrics) return;

      // fetch lyrics
      if (songData.lyrics_placeholder_reason) {
        // if placeholder exists, no lyrics available
        console.log(`${logItemForTrack(track)}: No lyrics available on Genius, skipping...`);
        if (!track.lyrics()) {
          unavailable++;
        }
      } else {
        const lyricsPath = songData.path;
        const lyricsURL = `https://genius.com/api/page_data/song?page_path=${encodeURIComponent(lyricsPath)}`;
        const lyricsData = JSON.parse(fetchURL(lyricsURL)).response.page_data.lyrics_data.body.html;
        track.lyrics = lyricsData.replace(/<[^>]*>/g, "");
        console.log(`${logItemForTrack(track)}: Lyrics added from Genius.`);
        addedGenius++;
      }
      return;
    } catch (e) {
      console.log(e);
      console.log(`${logItemForTrack(track)}: Failed to get lyrics, skipping...`);
      unavailable++;
    }
  } else {
    console.log(`${logItemForTrack(track)}: Failed to get song ID, skipping...`);
    unavailable++;
  }
}

// Main

const app = Application("Music");
const process = Application("System Events").processes["Music"];
let selectedTracks = app.selection();

console.log(`Selected ${selectedTracks.length} tracks.`);
if (selectedTracks.length === 0) {
  selectedTracks = app.sources["library"].playlists["Library"].tracks();
  console.log(`No tracks selected. Processing whole library.`);
}

selectedTracks.forEach(processTrack);

console.log(`${selectedTracks.length} tracks processed, lyrics added from Apple Music for ${addedApple} tracks, lyrics added from Genius for ${addedGenius} tracks, ${skipped} skipped for existing lyrics, ${unavailable} skipped for no available lyrics, ${booklet} booklets (or iTunes LPs), comment added for ${comment} tracks.`);
