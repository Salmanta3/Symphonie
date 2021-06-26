import 'package:flutter/material.dart';
import 'package:nouveau_projet/models/Chanson.dart';
import 'package:nouveau_projet/models/userModel.dart';
import 'package:nouveau_projet/widgets/liste.dart';
import 'package:nouveau_projet/widgets/listeInscrit.dart';

import 'Home.dart';

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}
  class _State extends State<MyApp> {
  Chanson chanson;
    bool login=false;
    isConnected()async{
      await UserModel.getUser();
      if(UserModel.sessionUser ==null){
        setState(() {
          login= false;
        });
      }else{
        setState(() {
          login=true;
        });
      }
    }
  isLogin(){
    setState(() {
      login=!login;
    });

  }
    @override
    void initState(){
    super.initState();
    isConnected();
  }
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: login?ListeInscrit(chanson: chanson,login: isLogin): MyHomePage(title: 'Home page'),
      );
    }
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   void initState(){
//     super.initState();
//     isConnected();
//   }
//   Widget build(BuildContext context) {
//     return MaterialApp(
//        title: 'Symphonie de l Epouse',
//       debugShowCheckedModeBanner: false,
//        theme: ThemeData(
//          primarySwatch: Colors.blue,
//         ),
//       home: MyHomePage(title: 'Home page'),
//     );
//   }
// }
  }