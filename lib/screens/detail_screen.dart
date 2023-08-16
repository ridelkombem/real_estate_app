import 'package:flutter/material.dart';


import '../model/real_estate_model.dart';
import '../utils/constants/global.dart';

class RealEstateDetailScreenNew extends StatelessWidget {
  final RelatedTopics? selectedProperty;
  const RealEstateDetailScreenNew({super.key, this.selectedProperty});
  @override
  Widget build(BuildContext context) {
    // final realestateId = ModalRoute.of(context)!.settings.arguments as String;
    // final realestate = _items.firstWhere((estate) => estate.id == realestateId);

    final mediaquery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProperty?.text.toString() ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: mediaquery.size.height * 0.32,
              width: double.infinity,
              child: selectedProperty!.icon!.url!.trim().isNotEmpty
                  ? Image.network(
                      "$appendableImageUrl${selectedProperty!.icon!.url!}",
                      fit: BoxFit.contain,
                    )
                  : CircleAvatar(
                      child: Text(selectedProperty!.text.toString()[0]),
                    ),
            ),
            SizedBox(height: mediaquery.size.height * 0.02),
            Text(
              selectedProperty?.text.toString() ?? "No text",
              style: const TextStyle(fontSize: 30, color: Colors.grey),
            ),
            SizedBox(height: mediaquery.size.height * 0.01),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.symmetric(
            //       horizontal: mediaquery.size.height * 0.01),
            //   child: Text(
            //     realestate.description,
            //     textAlign: TextAlign.center,
            //     softWrap: true,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
