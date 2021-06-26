import 'package:flutter/material.dart';
import 'package:nouveau_projet/models/Chanson.dart';

import 'Paroles.dart';


// class Items extends StatefulWidget{
//   Items({Key key, @required this.chansons}) : super(key: key);
//   final Chanson chansons;
//   @override
//   ItemsState createState()=>ItemsState(chansons);
//
// }
// class ItemsState extends State<Items>{
//  // List<Chanson>chanson = [];
//  Chanson chansons;
//   ItemsState(this.chansons);
//   TextEditingController searchController = new TextEditingController();
//   // bool isSearching = searchController.text.isNotEmpty;
//
//
//   //var ctx;
//   List chanson;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: chanson==null?0:chanson.length,
//       itemBuilder: (ctx,i){
//         return i==0? Padding(
//             padding: const EdgeInsets.all(0.8),
//             child: TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                   labelText: 'rechercher',
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide(
//
//                       )
//                   ),
//                   prefixIcon: Icon(
//                     Icons.search,
//                   )
//               ),
//             )
//         ):GestureDetector(
//           onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => Parole(chanson: Chanson(
//                   chanson[i]['idChanson'],
//                   chanson[i]['titre'],
//                   chanson[i]['auteur'],
//                   chanson[i]['paroles'],
//                   chanson[i]['imageUrl'],
//                   chanson[i]['audioUrl'],
//
//                 ) ),
//               )),
//           child: Card(
//
//
//               margin: EdgeInsets.all(1),
//               //elevation: 1,
//               child:
//               Column(
//                 //height: MediaQuery.of(context).size.height/1.25,
//                 children: [
//                   ListTile(
//                     leading: ConstrainedBox(
//                       constraints: BoxConstraints(
//                         minWidth: 100,
//                         minHeight: 100,
//                         maxWidth: 150,
//                         maxHeight: 150,
//                       ),
//                       child:  Image.network(chanson[i]['imageUrl']),
//                     ),
//                     title: Row(
//                       children: [
//                         Text(chanson[i]['idChanson'], style: TextStyle(fontSize: 25, color: Colors.black),),
//                         Text('.', style: TextStyle(fontSize: 25, color: Colors.black),),
//                         Text(chanson[i]['titre'], style: TextStyle(fontSize: 25, color: Colors.blueAccent),),
//                       ],
//                     ),
//
//
//                     subtitle: Text(chanson[i]['auteur'], style: TextStyle(fontSize: 15),),
//
//                   )
//                 ],
//               )
//           ),
//         );
//       },
//     );
//   }
//
// }

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
                        child:  Image.network(chanson[i]['imageUrl']),
                      ),
                      title: Row(
                        children: [
                          Text(chanson[i]['idChanson'], style: TextStyle(fontSize: 25, color: Colors.black),),
                          Text('.', style: TextStyle(fontSize: 25, color: Colors.black),),
                          Text(chanson[i]['titre'], style: TextStyle(fontSize: 25, color: Colors.blueAccent),),
                        ],
                      ),


                      subtitle: Text(chanson[i]['auteur'], style: TextStyle(fontSize: 15),),

                    )
                  ],
                )
            ),
          );
      },
    );
  }

}