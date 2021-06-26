import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nouveau_projet/API/api.dart';
import 'package:nouveau_projet/models/Chanson.dart';
import 'package:nouveau_projet/models/playlistModel.dart';
import 'package:nouveau_projet/models/userModel.dart';
import 'package:nouveau_projet/controller//CustomTextField.dart';
import 'package:http/http.dart' as http;
import 'package:nouveau_projet/widgets/playlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bibliotheque extends StatefulWidget{
  Bibliotheque({Key key, this.title}): super(key:key);
  final String title;

  @override
 _BibliothequeState createState() => _BibliothequeState();
}

class _BibliothequeState extends State<Bibliotheque>{
  final _key = GlobalKey<FormState>();
  List<PlaylistModel>playlistModel =[];
  Future<List> getData() async{
    final res = await http.get(Uri.parse("https://salmanta.000webhostapp.com/symphonie/getPlaylist.php"));
    return json.decode(res.body);
  }
 // Future<List> getData() async {
 //    var data = await Api.getPlaylist();
 //    //print(data);
 //    if (data != null) {
 //      playlistModel.clear();
 //      for (Map i in data) {
 //        playlistModel.add(PlaylistModel.fromJson(i));
 //      }
 //      print(playlistModel);
 //    }
 //  }

  CustonTextField nomText =
  new CustonTextField(title: "Nom", placeholder: "Entrer nom");
  PlaylistModel myPlaylist = PlaylistModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        title: Text('Bibliotheque'),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.refresh, size: 35, color: Colors.white,),
          //   onPressed: () {
          //     print('test');
          //     getData();
          //   },),
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
        ],
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add), backgroundColor: Colors.amber,
        onPressed: (){
          showDialog(
            context: context,
            builder: (context)=> AlertDialog(
              title: const Text("Nouvelle playlist"),
              content: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child:Form(
                    key: _key,
                    child:  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 40,
                          child: nomText.textFormField(),
                        ),

                      ],
                    ),
                  )

                ),

              ),
              actions: [
                FlatButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      myPlaylist.nom = nomText.value;
                      myPlaylist.user = UserModel.sessionUser.id;
                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      // print(myPlaylist.user);
                      // print(myPlaylist.user);
                      // prefs.setString('idUser', UserModel.sessionUser.id.toString());
                      await Api.addPlaylist(myPlaylist.toMap());
                     Navigator.pop(context, 'OK');
                     // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Bibliotheque()),).then((value) => value? getData():null);
                    }
                  }

                ),
                // SizedBox(
                //   height: 40,
                //   child: Row(
                //     children: [
                //       Container(
                //         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                //         child: RaisedButton(
                //
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(25.0),
                //             side: BorderSide(color: Colors.black),),
                //           color: Colors.amber,
                //
                //           child: Text("OK",style: TextStyle(color: Colors.black),),
                //           onPressed: () async{
                //             if( _key.currentState.validate()){
                //               myPlaylist.nom= nomText.value;
                //               myPlaylist.user= UserModel.sessionUser.id;
                //               await Api.addPlaylist(myPlaylist.toMap());
                //               Navigator.of(context).pop();
                //
                //             }
                //             // print(UserModel.sessionUser.id);
                //           },
                //         ),
                //       )
                //
                //     ],
                //   ),
                // )
              ],
            ),
          );
        },


      ),
      body: FutureBuilder<List>(
        future: getData(),
        // ignore: missing_return
        builder: (ctx,ss){
          if(ss.hasError){
            print("Erreur");
          }
          if(ss.hasData){
            return Items(playlist:ss.data);
          }
          else{
            return CircularProgressIndicator();
          }
        },
      )
    );
  }
}
class Items extends StatelessWidget {
  //var ctx;
  List playlist;

  Items({this.playlist, List chanson});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playlist == null ? 0 : playlist.length,
      itemBuilder: (ctx, i) {
        return Card(

            margin: EdgeInsets.all(1),
            //elevation: 1,
            child:
            GestureDetector(
              onTap: () {
                _navigateToPlaylist(context);
              },
              child: Column(
                //height: MediaQuery.of(context).size.height/1.25,
                children: [
                  ListTile(
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                          minHeight: 100,
                          maxWidth: 150,
                          maxHeight: 150,
                        ),
                        child: Icon(Icons.music_note)
                    ),
                    title: Row(
                      children: [
                        Text(playlist[i]['nom'],
                          style: TextStyle(fontSize: 25, color: Colors.black),),

                      ],
                    ),


                  )
                ],
              ),
            )
        );
      },
    );
  }

  void _navigateToPlaylist(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Playlist(),

        ));
  }
}
