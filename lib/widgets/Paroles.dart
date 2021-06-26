import 'dart:convert';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
//import 'package:assets_audio_player/assets_audio_player.dart';
//import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:nouveau_projet/audio/audioManager.dart';
import 'package:nouveau_projet/models/Chanson.dart';
import 'package:http/http.dart' as http;




// class Parole extends StatelessWidget {
// const Parole({Key key, @required this.chanson}):super(key:key);
// final Chanson chanson;
class Parole extends StatefulWidget{


  Parole({Key key, @required this.chanson}) : super(key: key);
  final Chanson chanson;

  @override
  _ParoleState createState()=>_ParoleState(chanson);
}
class _ParoleState extends State<Parole>{
Chanson chanson;
 _ParoleState(this.chanson);
 AudioManager _audioManager;


@override
void dispose() {
  _audioManager.dispose();
  super.dispose();
}

@override
void initState() {
  super.initState();
  _audioManager = AudioManager(chanson);
}
// AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        actions: <Widget>[
          Row(
           // mainAxisAlignment: MainAxisAlignment.end,
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: EdgeInsets.only(right: 40),
                child: Column(
                  children: [
                    Align(
                        //alignment: Alignment.center,

                        child:
                        Row(

                          children: [
                            SizedBox(
                              height: 55,
                              width: 55,
                              child: Image.network(chanson.imageUrl),
                            ),
                            Row(
                              children: [
                                Text(chanson.idChanson, style: TextStyle(
                                    fontSize: 25, color: Colors.blueAccent),),
                                Text(".", style: TextStyle(
                                    fontSize: 25, color: Colors.blueAccent),),
                               // Text(chanson.idChanson, style: TextStyle(fontSize: 25),),
                                Text(chanson.titre, style: TextStyle(
                                    fontSize: 25, color: Colors.blueAccent),)
                              ],
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                        Icons.more_vert
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/musiq.jpeg"),
                fit: BoxFit.cover,
                colorFilter:
                ColorFilter.mode(Colors.black45.withOpacity(0.7),
                    BlendMode.darken),
              ),
            ),
           child: Stack(
              children: [
                Padding(
                  padding:  const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          ValueListenableBuilder <ProgressBarState>(
                            valueListenable : _audioManager.progressNotifier,
                            builder : (_, value, __) {
                              return ProgressBar (
                               //progressBarColor: Colors.,
                               // bufferedBarColor: Colors.amber,
                                progress : value.current,
                                buffered : value.buffered,
                                total : value.total,
                              );
                            },
                          ),
                          ValueListenableBuilder <ButtonState>(
                            valueListenable : _audioManager.buttonNotifier,
                            // ignore: missing_return
                            builder : (_, value, __) {
                              switch (value) {
                                case ButtonState.loading :
                                  return Container(
                                    margin: EdgeInsets.all(8.0),
                                    width: 32.0,
                                    height: 32.0,
                                    child: CircularProgressIndicator(),
                                  );
                                case ButtonState.paused :
                                  return IconButton(
                                    icon: Icon(Icons.play_arrow,color: Colors.amber,),
                                    iconSize: 35.0,
                                    // onPressed :()=> audioPlayer.open(
                                    //   Audio('assets/audios/song1.mp3'),
                                    // ),
                                    onPressed : _audioManager.play,
                                    // onPressed : _audioManager.pause,
                                  );
                                case ButtonState.playing :
                                  return IconButton(
                                    icon: Icon(Icons.pause,color: Colors.amber,),
                                    iconSize: 35.0,
                                    // onPressed :()=> audioPlayer.open(
                                    //     Audio('assets/audios/song1.mp3'),
                                  //  ),
                                    onPressed : _audioManager.pause,
                                     //onPressed : _audioManager.play,
                                    //onPressed :()=> widget.advancedPlayer
                                  );
                              }
                            },
                          ),                        ],
                      ),

                    ],
                  ),
                ) ,
                Center(
                    child: Column(
                      children: [


                        // SizedBox(
                        //   height: 60,
                        // ),
                        Container(

                          // adding margin
                            margin: const EdgeInsets.all(00.0),

                            // adding padding
                            padding: const EdgeInsets.all(20.0),

                            // height should be fixed for vertical scrolling
                            height: 500.0,
                            width: 400,
                            decoration: BoxDecoration(

                              // adding borders around the widget

                            ),
                            // SingleChildScrollView should be
                            // wrapped in an Expanded Widget
                            child: Column(
                              children: [
                                Expanded(

                                  // SingleChildScrollView contains a
                                  // single child which is scrollable
                                  child: SingleChildScrollView(

                                    // for Vertical scrolling
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      chanson.paroles,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        letterSpacing: 4,
                                        wordSpacing: 4,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    )
                )
              ],
           ),
          ),


        ],
      )
    );
  }
}