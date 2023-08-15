// import 'package:flutter/material.dart';

// class RealEstateDetailScreen extends StatelessWidget {
//   const RealEstateDetailScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final realestateId = ModalRoute.of(context)!.settings.arguments as String;
//     final realestate = _items.firstWhere((estate) => estate.id == realestateId);

//     final mediaquery = MediaQuery.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(realestate.name),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: mediaquery.size.height * 0.32,
//               width: double.infinity,
//               child: Hero(
//                 tag: realestate.id,
//                 child: Image.network(
//                   realestate.imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: mediaquery.size.height * 0.02),
//             Text(
//               realestate.name,
//               style: const TextStyle(fontSize: 30, color: Colors.grey),
//             ),
//             SizedBox(height: mediaquery.size.height * 0.01),
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(
//                   horizontal: mediaquery.size.height * 0.01),
//               child: Text(
//                 realestate.description,
//                 textAlign: TextAlign.center,
//                 softWrap: true,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
