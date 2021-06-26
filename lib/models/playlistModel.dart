import 'dart:convert';

class PlaylistModel{
  String idPlaylist;
  String user;
  String nom;



  PlaylistModel({this.nom, this.user,this.idPlaylist});

  factory PlaylistModel.fromJson(Map<String, dynamic> j){
    return PlaylistModel(
      nom: j['nom'],
      user: j['idUser'],
      idPlaylist: j['idPlaylist']
    );
  }

  Map toMap(){
    return{
      "idPlaylist": idPlaylist,
      "idUser": user,
      "nom":nom,

  };
}
}