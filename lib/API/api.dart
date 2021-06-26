import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static getChanson() async {
    final response = await http.get(Uri.parse(Url.getChanson));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static getPlaylist() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String idUser = prefs.getString('idUser');
    final response = await http.post(
      Uri.parse(Url.getPlaylist),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      // body: {'idUser': idUser},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static addPlaylist(Map data) async {
    final response = await http
        .post(Uri.parse(Url.addPlaylist), body: {"data": jsonEncode(data)});
    if (response.statusCode == 200) {
      print(response.body);
    }
  }
}

class Url {
  // static String getChanson="http://127.0.0.1/php/getChanson.php";
  static String getChanson =
      "https://salmanta.000webhostapp.com/symphonie/getChanson.php";
  static String addPlaylist =
      "https://salmanta.000webhostapp.com/symphonie/addPlaylist.php";
  static String getPlaylist =
      "https://salmanta.000webhostapp.com/symphonie/getPlaylist.php";
}
