import 'package:flutter/material.dart';
import 'lister.dart';
import 'places_page.dart';

// double rating = 100.0;



// class HomePage extends StatefulWidget {
//   static String tag = 'budget-page';
 
//   @override
//   _HomePageState createState() => _HomePageState();
// }





// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Shopping Budget App'),backgroundColor: Colors.blueGrey,
//         ),
//         body: Center(
//           child:Container(
//             height: 500,
//             width: 300,
//             child: Column(
//               children: <Widget>[Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('Please set your budget'),
//               ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Slider(
//                             onChanged: (newRating) {
//                               setState(()=>{
//                                 rating=newRating
//                               });
//                             }, 
//                             min: 0.0,
//                             max: 2500.0,
//                             value: rating,
//                             divisions: 25,
//                             label: "${rating.round()}",
//                           ),
//                 ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: RaisedButton(
//                             child:Text('Set Budget'),
//                             onPressed: (){
//                               Navigator.push(
//                                 context, 
//                                 MaterialPageRoute(
//                                   builder:(context)=>ListerApp(rating)));
//                             },
//                           ),
//                         ),
//               ],
//               mainAxisAlignment: MainAxisAlignment.center,
//             ),
//           ),
                
//               ),
//       ); 
    
//   }
// }

