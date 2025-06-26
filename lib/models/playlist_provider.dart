import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/songs.dart';

class PlaylistProvider extends ChangeNotifier {
  //playlist of songs
  final List<Songs> _playlist = [

    //song 1
    Songs(
    songName: "Freedom", 
    artistName: "Akon", 
    albumArtImagePath: "assets/image/akonfreedom.jpg", 
    audioPath: "assets/audio/freedom.mp3",),

  ];

  //Current song playing index
  int? _currentSongIndex;

  /*
  Getter
*/

List<Songs> get playlist => _playlist;
int? get currentSongIndex => _currentSongIndex;
bool get isPlaying => _isPlaying;
Duration get currentDuration => _currentDuration;
Duration get totalDuration => _totalDuration;

/*
AUdio Player Methods
*/

//audio player
final AudioPlayer _audioPlayer = AudioPlayer();

//durations
Duration  _currentDuration = Duration.zero;
Duration _totalDuration = Duration.zero;


//constructor
PlaylistProvider(){
  listenToDuration();
}


//initially not playing
bool _isPlaying = false;

//play the song
void play() async{
  final String path = _playlist[_currentSongIndex!].audioPath;
  await _audioPlayer.stop();
  await _audioPlayer.play(AssetSource(path));
  _isPlaying = true;
  notifyListeners(); 
}

//pause current song
void pause() async {
  await _audioPlayer.pause();
  _isPlaying = false;
  notifyListeners(); 
}

//reume playing
void resume() async {
  await _audioPlayer.resume();
  _isPlaying = true;
  notifyListeners(); 
}

//pause or resume
void pauseOrResume() async {
  if (_isPlaying) {
    pause();
  } else {
    resume();
  }
  notifyListeners();
}

//seek to a specific position in current song
void seek(Duration position) async {
  await _audioPlayer.seek(position);
}

//play next song
void playNext() async {
  if (_currentSongIndex != null){
    if (_currentSongIndex! < _playlist.length - 1) {
    _currentSongIndex = _currentSongIndex! + 1;
    // go to next song if next song is not the last song
  } else {
    //if its the last song, loop back to first song
    _currentSongIndex = 0;
  }
  }
}

//play previous song
void playPrevious() async {
  //if two seconds have passed restart the current song
  if (_currentDuration.inSeconds>2) {
    seek(Duration.zero);
}
//if its within the first 2 seconds of the song go to the second song
else if ( _currentSongIndex! > 0) {
    currentSongIndex = _currentSongIndex! - 1;
    // go to previous song if previous song is not the first song
  } else {
    //if its the first song, loop back to last song
    currentSongIndex = _playlist.length - 1;
  }
}


//list to duration 
void listenToDuration(){
  //listen for total duration
  _audioPlayer.onDurationChanged.listen((newDuration) {
    _totalDuration = newDuration;
    notifyListeners(); 
  });

  //listen for current duration
  _audioPlayer.onPositionChanged.listen((newPosition) {
    _currentDuration = newPosition;
    notifyListeners(); //notify listeners to update UI
  });

  //listen for song completion
  _audioPlayer.onPlayerComplete.listen((event) {
    playNext();
  });
}

//dispose audio player



/*
setters
*/


set currentSongIndex(int? newIndex) {

  //update current song index
  _currentSongIndex = newIndex;

  if(newIndex!=null){
    play();
  }
  //update UI
  notifyListeners(); //notify listeners to update UI



}
}