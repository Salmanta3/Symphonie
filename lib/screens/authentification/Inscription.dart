import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nouveau_projet/controller//CustomTextField.dart';
import 'package:http/http.dart' as http;
import 'package:nouveau_projet/controller/loading.dart';
import 'package:nouveau_projet/models/userModel.dart';
import 'package:nouveau_projet/widgets/listeInscrit.dart';
import 'Connection.dart';

class Inscription extends StatefulWidget {
  final String title;
 //  final Function toggle;
 //  Inscription(this.toggle);
  Inscription( {Key key, @required this.title,this.login}) : super(key: key);
  final Function login;
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  bool login=false;
  String error = "";
  bool _loading = false;
  isLogin(){
    setState(() {
      login=!login;
    });

  }
  CustonTextField nomText =
  new CustonTextField(title: "Nom", placeholder: "Entrer nom");
  CustonTextField emailText =
  new CustonTextField(title: "Email", placeholder: "Entrer email");
  CustonTextField passText = new CustonTextField(
    title: "Mot de passe",
    placeholder: "***********",
    ispass: true,
  );
  CustonTextField confirmpassText = new CustonTextField(
    title: "Confirmer",
    placeholder: "***********",
    ispass: true,
  );

  Future inscription(String name, String email, String pass) async {
    print("inscription click");
    setState(() {
      _loading = true;
    });
    var response = await http.post(
      Uri.parse("https://salmanta.000webhostapp.com/symphonie/inscrip.php"),
    // Uri.parse("http://127.0.0.1/php/inscrip.php"),
      body: {
        "name": name,
        "email": email,
        "pass": pass,
      },
    );
    if (response.statusCode == 200) {
      // print("status code: "+ response.statusCode.toString());
      var data = jsonDecode(response.body);
      var result = data['data'];
      int succes = result[1];
      if (succes == 1) {
        setState(() {
          error = result[0];
          //UserModel.saveUser(UserModel.fromJson( result[2]));
          _loading = false;
          login=true;
        });
      } else {
        setState(() {
          error = result[0];
          _loading = false;
          login=false;
        });
        print(data);
      }
    }
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nomText.err = "Entrer nom";
    emailText.err = "Entrer email";
    passText.err = "Entrer mot de passe";
    final bottom = MediaQuery
        .of(context)
        .viewInsets
        .bottom;
    return _loading ? Loading() : login?ListeInscrit(): Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fond.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.darken),
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
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottom),
                  child: Column(
                    children: [
                      Container(

                          child: Form(
                            key: _key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  height: 20.0,
                                ),
                                Image.asset(
                                  'assets/images/log.png',
                                  width: 50.0,
                                  height: 200.0,
                                  //fit: BoxFit.cover,
                                ),
                                Center(
                                  child: Text(
                                    'Inscription',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Garamond',
                                      fontSize: 40,
                                      height: 0.1,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.all(30),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            child: nomText.textFormField(),
                                          ),

                                          SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: emailText.textFormField(),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: passText.textFormField(),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: confirmpassText
                                                .textFormField(),
                                          ),
                                          // emailText.textFormField(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 110),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(25.0),
                                            side: BorderSide(
                                                color: Colors.white)),
                                        onPressed: () {
                                          if (_key.currentState.validate()) {
                                            inscription(nomText.value,
                                                emailText.value,
                                                passText.value);
                                            if (passText.value ==
                                                confirmpassText.value) {} else {
                                              print(
                                                  "les mots de passe sont differents");
                                            }
                                          }
                                        },
                                        color: Colors.transparent.withOpacity(0.1),
                                        textColor: Colors.white,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.music_note, color: Colors.greenAccent,),
                                            Text("Inscription".toUpperCase(), style: TextStyle(fontSize: 14))
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Avez-vous un compte?',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    FlatButton(
                                        onPressed:
                                            () {
                                          _navigateToConnection(context);
                                        },
                                        child: Text(
                                          'Connection',
                                          style: TextStyle(
                                              color: Colors.greenAccent,
                                              fontSize: 20),
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 00,
                                ),
                                Container(
                                    child: Text(error, style: TextStyle(
                                        color: Colors.greenAccent, fontSize: 20),
                                      textAlign: TextAlign.center,)
                                )
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                )
            )
        ),
      ],
    );

  }

  void _navigateToConnection(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Connection(),
        ));
    // }
  }
}
