
class Chanson{

  String idChanson;
  String titre;
  String auteur;
  String paroles;
  String imageUrl;
  String audioUrl;
 // String numero;

  Chanson( this.idChanson, this.titre,this.auteur, this.paroles,this.imageUrl,this.audioUrl
     // this.numero
      );


  factory Chanson.fromJson(Map<String, dynamic> j) => Chanson(

    j['idChanson'],
     j['titre'],
     j['auteur'],
     j['paroles'],
     j['imageUrl'],
      j['audioUrl']
  //  j['numero'],
    );

    // i['idChanson'],
    // i['titre'],
    // i['auteur'],
    // i['parole'],
    // i['imageUrl'],

  Map toMap(){
    return{
      'idChanson':idChanson,
      'titre':titre,
      'auteur':auteur,
      'paroles':paroles,
      'imageUrl':imageUrl,
      'audioUrl':audioUrl
      //'numero':numero,
    };
  }





}