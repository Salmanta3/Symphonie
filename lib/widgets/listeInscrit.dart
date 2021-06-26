import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nouveau_projet/API/api.dart';
import 'package:nouveau_projet/controller/CustomTextField.dart';
import 'package:nouveau_projet/models/Chanson.dart';
import 'package:nouveau_projet/models/Chanson.dart';
import 'package:nouveau_projet/models/userModel.dart';
import 'package:nouveau_projet/widgets/Paroles.dart';
import 'package:http/http.dart' as http;
import 'package:nouveau_projet/widgets/aPropos.dart';

import 'Home.dart';
import 'bibliotheque.dart';
import 'favoris.dart';

class ListeInscrit extends StatefulWidget {
  final VoidCallback login;

  ListeInscrit({Key key, @required this.chanson, this.login,}) : super(key: key);
  final Chanson chanson;

  @override
  _ListeInscritState createState() => _ListeInscritState();
}

class _ListeInscritState extends State<ListeInscrit> {
  List<Chanson> chanson = [];

  // List<Chanson>chansonFiltered = [];
  TextEditingController searchController = new TextEditingController();
  CustonTextField search =
      new CustonTextField(title: "Rechercher", placeholder: "rechercher");


  Future<List> getData() async{
    final res = await http.get(Uri.parse("https://salmanta.000webhostapp.com/symphonie/getChanson.php"));
    return json.decode(res.body);
  }
    // getData() async {
    //    var data = await Api.getChanson();
    //
    //    if (data !=null) {
    //      chanson.clear();
    //      for(Map i in data){
    //        chanson.add(Chanson.fromJson(i));
    //      }
    //      }
    //    }



  @override
  Widget build(BuildContext context) {
   //List chanson;
  //  List <Chanson>chanson=List<Chanson>();
    List <Chanson>chanson=[ ];
  // List<Chanson> chanson ;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
          title: Text("Symphonie...", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
          actions: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                  backgroundColor: Colors.red,
                  textTheme: TextTheme().apply(bodyColor: Colors.white),
                  dividerColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.white)),
              child: Row(children: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                PopupMenuButton<int>(
                  color: Colors.black,
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(value: 0, child: Text("A Propos")),
                    PopupMenuDivider(),
                    PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text("Logout"),
                          ],
                        )),
                  ],
                  onSelected: (item) => SelectedItem(context, item),
                ),
              ]),
            )
          ],
        ),

        // Padding(
        //     padding: EdgeInsets.only(right: 20.0),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: Icon(
        //         Icons.search,
        //         size: 26.0,
        //       ),
        //     )
        // ),

        // Padding(
        //     padding: EdgeInsets.only(right: 20.0),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: Icon(
        //           Icons.more_vert
        //       ),
        //     )
        // ),
        //   )
        //  ],
        // ),
        drawer: Drawer(
            child: Container(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    width: 400,
                    height: 250,
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/musiq.jpeg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black54,
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 90,
                            width: 90,
                            child: Image.asset('assets/images/logoo.png'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Text(
                              'Symphonie de l Epouse',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              'RECUEIL DE CHANTS',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: RaisedButton(
                        onPressed: () {
                          _navigateToListe(context);
                        },
                        color: Colors.amberAccent,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                            Text(
                              'Acceuil',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: RaisedButton(
                        onPressed: () {
                          _navigateToFavoris(context);
                        },
                        color: Colors.amberAccent,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.black,
                            ),
                            Text(
                              'favoris',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: RaisedButton(
                        onPressed: () {
                          _navigateToBibliotheque(context);
                        },
                        color: Colors.amberAccent,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.book,
                              color: Colors.black,
                            ),
                            Text(
                              'bibliotheque',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
        body: FutureBuilder<List>(
          future: getData(),
          // ignore: missing_return
          builder: (ctx,ss){
            if(ss.hasError){
              print("Erreur");
            }
            if(ss.hasData){
              return Items(chanson:ss.data);
            }
            else{
              return CircularProgressIndicator();
            }
          },
        )

        // FutureBuilder<List>(
        //   future: getData(),
        //   // ignore: missing_return
        //   builder: (ctx,ss)
        //   {
        //
        //
        //     if(ss.hasError){
        //       print("Erreur");
        //     }
        //     if(ss.hasData){
        //       return Items(chanson:ss.data);
        //     }
        //     else{
        //       return CircularProgressIndicator();
        //     }
        //   },
        // )
        );
  }
  searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Rechercher...'),
        onChanged: (text){
          text=text.toLowerCase();
          setState((){
            chanson= chanson.where((chant){
              var  chansonTitre =chant.titre.toLowerCase();
              return chansonTitre.contains(text);
            }).toList();
          });
        },
      ),
    );
  }




  void _navigateToBibliotheque(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Bibliotheque()));
  }

  void _navigateToFavoris(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Favoris()));
  }

  void _navigateToListe(BuildContext context) {
    var chanson;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListeInscrit(
                  chanson: chanson,
                )));
  }
}



class Items extends StatelessWidget{

  TextEditingController searchController = new TextEditingController();
 // bool isSearching = searchController.text.isNotEmpty;


  //var ctx;
  List chanson;

  final bool isSelected;
  final ValueChanged<Chanson> onSelectedChanson;
  Items({this.chanson, this.isSelected,this.onSelectedChanson});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chanson==null?0:chanson.length,
      itemBuilder: (ctx,i){
        return
        //   i==0? Padding(
        //     padding: const EdgeInsets.all(0.8),
        //   child: TextField(
        //     controller: searchController,
        //     decoration: InputDecoration(
        //       labelText: 'rechercher',
        //       border: OutlineInputBorder(
        //         borderSide: BorderSide(
        //
        //         )
        //       ),
        //       prefixIcon: Icon(
        //         Icons.search,
        //       )

        //     ),
        //   )
        // ):
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Parole(chanson: Chanson(
                  chanson[i]['idChanson'],
                  chanson[i]['titre'],
                  chanson[i]['auteur'],
                  chanson[i]['paroles'],
                  chanson[i]['imageUrl'],
                  chanson[i]['audioUrl'],

                ) ),
              )),
          child: Card(


              margin: EdgeInsets.all(1),
              //elevation: 1,
              child:
              Column(
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
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(chanson[i]['imageUrl']),
                        ),
                    ),
                    title: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(chanson[i]['idChanson'], style: TextStyle(fontSize: 20, color: Colors.black),),
                        Text('.', style: TextStyle(fontSize: 25, color: Colors.black),),
                        Text(chanson[i]['titre'], style: TextStyle(fontSize: 20, color: Colors.blueAccent),),
                        Icon(Icons.music_note,color: Colors.grey,)
                      ],
                    ),


                    subtitle: Text(chanson[i]['auteur'], style: TextStyle(fontSize: 16, color: Colors.black),),

                  )
                ],
              )
          ),
        );
      },
    );
  }

}



void SelectedItem(BuildContext context, item) {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => APropos()));
      break;

    case 1:
      print("User Logged out");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyHomePage()),
          (route) => false);
      break;
  }
}
