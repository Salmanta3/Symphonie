import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nouveau_projet/models/Chanson.dart';
import 'package:nouveau_projet/models/userModel.dart';
import 'package:nouveau_projet/controller//CustomTextField.dart';
import 'package:nouveau_projet/controller//loading.dart';
import 'package:nouveau_projet/widgets/listeInscrit.dart';
import 'Inscription.dart';
import 'package:http/http.dart' as http;

class Connection extends StatefulWidget{
  final title;
  //final Function toggle;
 //Connection( this.toggle);
Connection( {Key key, @required this.title, this.login}) : super(key: key);

  final Function login;


  @override
 _ConnectionState createState() => _ConnectionState();
}
class _ConnectionState extends State< Connection>{
  bool login=false;
   String error = "";
   bool _loading= false;
   isLogin(){
     setState(() {
       login=!login;
     });

   }
  void Connection( String email, String pass)async{
    setState(() {
      error="";
      _loading = true;
    });
   final response = await http.post(Uri.parse("http://salmanta.000webhostapp.com/symphonie/login.php"),body: {
   // final response = await http.post(Uri.parse("http://127.0.0.1/php/login.php"),body: {
    "email": email,
    "pass":pass,
  });
  if(response.statusCode == 200){
    var data = jsonDecode(response.body);
   // print(data);
    var result = data['data'];
    int succes = result[1];
    if(succes==1) {
      setState(() {
         error=result[0];
        UserModel.saveUser(UserModel.fromJson( result[2]));
        _loading=false;
         //widget.login.call();
        login=true;
      });
    }else{
      setState(() {
       error=result[0];
        _loading=false;
        login=false;

      });

    }
  }
  }

  CustonTextField emailText = new CustonTextField(
    title: "Email",
    placeholder: "Entrer email"
  );
  CustonTextField passText = new CustonTextField(
      title: "Mot de passe",
      placeholder: "***********",
    ispass: true,
  );
  final _key = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {
    emailText.err="Entrer email";
    passText.err="Entrer mot de passe";
   final bottom = MediaQuery.of (context) .viewInsets.bottom;
    Chanson chanson;
    return
      _loading?Loading():login?ListeInscrit(chanson: chanson):
      Stack(
        children: [
          Container(

            decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage("assets/images/fond.jpg"),
                fit: BoxFit.cover,
                colorFilter:
                ColorFilter.mode(Colors.black.withOpacity(0.2),
                    BlendMode.darken ),
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
                      Colors.white.withOpacity(0.2),
                      Colors.black12.withOpacity(0.7),
                    ],
                    stops: [
                      0.0,
                      1.0,
                    ]
                )
            ),
          ),
            Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
                extendBody: true,
                body: SingleChildScrollView(
                    reverse: true,
                    child:Padding(
                      padding: EdgeInsets.only(bottom: bottom),
                      child: Stack(
                        children: [
                          Form(
                            key: _key,
                            child: SingleChildScrollView(
                              reverse: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Image.asset('assets/images/log.png',
                                    width: 50.0,
                                    height: 200.0,
                                    //fit: BoxFit.cover,
                                  ),
                                  Center(
                                    child: Text('Connection',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Garamond',
                                        fontSize: 40,
                                        height: 0.1,
                                      ),),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(

                                    child: Container(
                                      padding: EdgeInsets.all(30),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: emailText.textFormField() ,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: passText.textFormField() ,
                                          ),

                                          // emailText.textFormField(),
                                        ],
                                      ),
                                    ),
                                  ) ,

                                  SizedBox(
                                    height: 15.0,
                                  ),
                                    SizedBox(

                                        height: 45,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical:2,horizontal: 110),
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(26.0),
                                                side: BorderSide(color: Colors.white)),
                                            onPressed: () async {
                                                if(_key.currentState.validate()){
                                                  Connection(emailText.value, passText.value);
                                                 }
                                                // if(isLogin()){
                                                //   _navigateToListeInscrit(context);
                                                // }
                                              // if(login==false){
                                              //   _navigateToListeInscrit(context);
                                              // }
                                              //   else{
                                              //    return Connection(emailText.value, passText.value);
                                              //   }

                                            },
                                            color: Colors.transparent.withOpacity(0.1),
                                            textColor: Colors.white,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.music_note, color: Colors.greenAccent,),
                                                Text("Connection".toUpperCase(), style: TextStyle(fontSize: 14))
                                              ],
                                            ),
                                          ),
                                        )
                                    ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Avez-vous un compte?', style: TextStyle(color: Colors.white,fontSize: 20),),
                                      FlatButton(
                                          onPressed:
                                              (){
                                           _navigateToInscription(context);
                                            },
                                          child: Text('Inscription', style: TextStyle(color: Colors.greenAccent, fontSize: 20),))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 00,
                                  ),
                                  Container(
                                      child: Text(error, style: TextStyle(color: Colors.greenAccent, fontSize: 20), textAlign: TextAlign.center,)
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                )
            )
        ],
      );

  }
  void _navigateToInscription(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Inscription(),
        ));
  }
   // void _navigateToListeInscrit (BuildContext context) {
   //   Navigator.push(
   //       context,
   //       MaterialPageRoute(
   //         builder: (context) => ListeInscrit(chanson: Chanson(
   //             "1.",
   //             "Crois seulrment",
   //             "Paul Rader",
   //             "'lozxjncjcnujcnidjcddddddddddddddduhefuhedidjkijjjjjjjjjjjjjjjjjjjjjjjjjndncddjhuhdeuyyyyyyyyyyggybhjojojejiejeihdjndjfndjf'",
   //             "assets/images/logoo.png"
   //
   //         ) ),
   //       ));
   // }
  // void _navigateToConnection(BuildContext context) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Connection(),
  //       ));
  // }
}