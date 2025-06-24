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
    audioPath: "assets/audio/song1.mp3"),

    

  ];

  //Current song playing index
  int? _currentSongIndex;

  /*
  Getter
*/

List<Songs> get playlist => _playlist;
int? get currentSongIndex => _currentSongIndex; 

/*
setters
*/


set currentSongIndex(int? index) {

  //update current song index
  _currentSongIndex = index;
  //update UI
  notifyListeners(); //notify listeners to update UI



}
}