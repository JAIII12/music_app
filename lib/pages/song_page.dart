import 'package:flutter/material.dart';
import 'package:music_app/components/neo_box.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<PlaylistProvider>(
      builder:(context,value, child) {

        //get playlist 
    final playlist= value.playlist;

    //get current song index
    final currentSong = playlist[value.currentSongIndex ?? 0];

    //return scaffold UI
        return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
          child: Column(
            children: [
              //app bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //back button 
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                  ),
                  //title
                  Text("P L A Y L I S T",),
          
                  // menu button
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.menu),
                  ),
                ],
              ),
          
              //album artwork
              NeoBox(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                      currentSong.albumArtImagePath,
                       ),
                    ),
                    //song and artist name
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //song and artist name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.songName,
                             style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          Text(currentSong.artistName,
                           style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          ),
                        ],
                      ),
                  
                      //heart icon
                      Icon(Icons.favorite, color: Colors.red, size: 30,),
                    ],
                  ),
                )
                  ],
                ),
                ),
                
                const SizedBox(height: 25,),

                // song Duration progress
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //start Time
                          Text(value.currentDuration.toString()),
                      
                          //shuffle icon
                          Icon(Icons.shuffle, size: 30,),
                      
                          //repeat icon
                          Icon(Icons.repeat, size: 30,),
                      
                          //end time
                          Text(value.currentDuration.toString()),
                           ],
                      ),
                    ),
                
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                      ),
                      child: Slider(min: 0,
                      max: value.totalDuration.inSeconds.toDouble(),
                      value: value.currentDuration.inSeconds.toDouble(),
                      activeColor: Colors.green,
                       onChanged: (double double) {
                        //during when the user is dragging the slider
                       },
                       onChangeEnd: (double double){
                        value.seek(Duration(seconds: double.toInt()));
                       },
                       ),
                    ),
                  ],
                ),

                const SizedBox(height: 25,),

                //playback controls

                Row(
                  children: [
                    //skip previous button
                    Expanded(
                       child: GestureDetector(
                        onTap: value.playPrevious,
                        child: NeoBox(child:
                        Icon(Icons.skip_previous,)),
                      ),
                    ),

                    const SizedBox(width: 10,),


                    //play pause
                     Expanded(
                       child: GestureDetector(
                        onTap: value.pauseOrResume,
                        child: NeoBox(child:
                        Icon(value.isPlaying ? 
                        Icons.pause: 
                        Icons.play_arrow,)),
                      ),
                    ),

                    const SizedBox(width: 10,),


                    //skip forward
                     Expanded(
                       child: GestureDetector(
                        onTap: value.playNext,
                        child: NeoBox(child:
                        Icon(Icons.skip_next,)),
                      ),
                    ),
                     ],
                )

            ],
          ),
        ),
        
      ),
    );
      }
    );
  }
}