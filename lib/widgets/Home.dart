import 'package:flutter/material.dart';
import 'package:nouveau_projet/models/Chanson.dart';
import 'package:nouveau_projet/models/userModel.dart';
import 'package:nouveau_projet/screens/authentification/Connection.dart';
import 'package:nouveau_projet/screens/authentification/Inscription.dart';

import 'liste.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{

 bool login=false;
  bool visible =false;
  // isConnected()async{
  //   await UserModel.getUser();
  //   if(UserModel.sessionUser ==null){
  //     setState(() {
  //       login= true;
  //     });
  //   }else{
  //     setState(() {
  //       login=false;
  //     });
  //   }
  // }
  toggle(){
    setState(() {
      visible=!visible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:  new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
               image: new DecorationImage(
                 image: new AssetImage("assets/images/fond.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
             //   color: Colors.red,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.1),
                    Colors.black12.withOpacity(0.8),
                  ],
                  stops: [
                    0.0,
                    1.0,
                  ]
                )
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  new Image.asset( 'assets/images/logoo.png',
                    width: 200.0,
                    height: 190.0,
                    //fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    //height: 10,
                    child: Container(

                      //padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("SYMPHONIE DE L'EPOUSE",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                          SizedBox(
                            height: 10,
                          ),
                          Text("RECUEIL DE CHANTS",style: TextStyle(color: Colors.amber,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Nouvelle edition",style: TextStyle(color: Colors.white,fontSize: 20),)
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 5,
                    height: 60,
                  ),

                  SizedBox(
                    width: 220,
                    height: 50,

                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () {
                       // return visible? Inscription():Connection(toggle());
                        _navigateToInscription(context);
                      },
                      color: Colors.transparent.withOpacity(0.1),
                      textColor: Colors.white,
                      child: Text("Inscription".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,

                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () {
                        // if (visible) {
                        //   return Connection(toggle());
                        // } else {
                        //   return Inscription(toggle());
                        // }
                        _navigateToConnection(context);
                      },
                      color: Colors.transparent.withOpacity(0.1),
                      textColor: Colors.white,
                      child: Text("Connection".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,

                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () {
                      // //  return login?Liste():Connection();
                      //   if (login){
                      //     _navigateToListe(context);
                      //   }else{
                      //     _navigateToConnection(context);
                      //   }
                       _navigateToListe(context);
                      },
                      color: Colors.transparent.withOpacity(0.1),
                       textColor: Colors.white,
                      child: Text("Entrer".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                    ),
                  ),

                ],
              ),
            )
          ],
        )
    );
  }
  void _navigateToConnection(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Connection(),
        ));
  }
  void _navigateToInscription(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(

          builder: (context) => Inscription(),
        ));
  }
  void _navigateToListe (BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Liste(),

        ));
  }

}
