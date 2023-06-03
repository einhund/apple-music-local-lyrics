const app = Application("Music");
const process = Application("System Events").processes["Music"];
let selectedTracks = app.selection();

console.log(`Selected ${selectedTracks.length} tracks.`);
if (selectedTracks.length === 0) {
  selectedTracks = app.sources["library"].playlists["Library"].tracks();
  console.log(`No tracks selected. Processing whole library.`);
}

let skipped = 0;
let added = 0;
let unavailable = 0;
let booklet = 0;

selectedTracks.forEach(track => {
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
  }
  const tabButtons = info.radioGroups.radioButtons;
  if (!tabButtons.name()[0].includes("Lyrics")) {
    // this is a booklet (or iTunes LP)
    console.log(`${track.albumArtist()} - ${track.album()} - ${track.name()}: Booklet, skipping...`);
    booklet++;
  } else {
    tabButtons["Lyrics"].click(); // switch to lyrics tab
    const hasLyrics = info.checkboxes["Custom Lyrics"].value();
    if (hasLyrics) {
      console.log(`${track.albumArtist()} - ${track.album()} - ${track.name()}: Has lyrics, skipping...`);
      skipped++;
    } else {
      while (info.groups[0].busyIndicators.length > 0) {
        // wait for loading (this only works for JXA)
      }
      if (info.groups[0].scrollAreas.length == 0) {
        // no scroll area if no lyrics available
        console.log(`${track.albumArtist()} - ${track.album()} - ${track.name()}: No lyrics available, skipping...`);
        unavailable++;
      } else {
        const lyrics = info.groups[0].scrollAreas[0].textAreas[0].value();
        track.lyrics = lyrics;
        console.log(`${track.albumArtist()} - ${track.album()} - ${track.name()}: Lyrics added.`);
        added++;
      }
    }
  }
  info.buttons["OK"].click();
});

console.log(`${selectedTracks.length} tracks processed, lyrics added for ${added} tracks, ${skipped} skipped for existing lyrics, ${unavailable} skipped for no available lyrics, ${booklet} booklets.`);
