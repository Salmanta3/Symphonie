import 'package:flutter/material.dart';

class Favoris extends StatefulWidget{
  Favoris({Key key, this.title}): super(key:key);
  final String title;
  @override
 _FavorisState createState() => _FavorisState();

}
class _FavorisState extends State<Favoris>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        title: Text('Favoris'),
    /*actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
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
        ],*/
  ),
);
  }

}