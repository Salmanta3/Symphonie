import 'package:flutter/material.dart';
import 'package:nouveau_projet/models/Chanson.dart';

class Playlist extends StatefulWidget{
  Playlist({Key key, @required this.chanson}) : super(key: key);
  final Chanson chanson;

  @override

  _PlaylistState createState() =>_PlaylistState(chanson);

}
class _PlaylistState extends State <Playlist>{
  Chanson chanson;
  _PlaylistState(this.chanson);
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       centerTitle: true,
       backgroundColor: Colors.amberAccent,
       title: Text("liste 1"),
     ),
   );
  }

}