import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:music_app/models/songs.dart';
import 'package:music_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //get the playlist provider
  late final PlaylistProvider playlistProvider;

  @override
  void initState() {
    super.initState();

    //get the playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

    //Go to a song
    void goToSongs(int songindex) {
    //Upadate the current song index
    playlistProvider.currentSongIndex = songindex;

    //Navigate to the song page
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SongPage(),
    ),
    );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text("P L A Y L I S T")),
      drawer: MyDrawer(),
      body: 
      Consumer<PlaylistProvider>(
        builder: (context,value, child){
          return ListView.builder(
          itemCount: value.playlist.length,
          itemBuilder:(context, index){
            //get individual song
            final Songs songs = value.playlist[index];

            //Return list view UI
            return ListTile(  
              title: Text(songs.songName),
              subtitle: Text(songs.artistName),
              leading:Image.asset(songs.albumArtImagePath),
              onTap: () => goToSongs(index),
            );
          }
          );
        },
          ),
    );
  }
}
