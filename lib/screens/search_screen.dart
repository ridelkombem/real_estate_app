import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:real_estate_final_app/screens/detail_screen.dart';

import '../model/real_estate_model.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<RelatedTopics> _properties = <RelatedTopics>[];

  Future<List<RelatedTopics>> fetchProperties() async {
    var url = Uri.parse(
        'http://api.duckduckgo.com/?q=simpsons+characters&format=json');
    var response = await http.get(url);

    var properties = <RelatedTopics>[];
    if (response.statusCode == 200) {
      var propertiesJson = json.decode(response.body);
      for (var propertyJson in propertiesJson["RelatedTopics"]) {
        properties.add(RelatedTopics.fromJson(propertyJson));
      }
    }
    return properties;
  }

  @override
  void initState() {
    fetchProperties().then((value) {
      setState(() {
        _properties.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Real Estate Search',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch(_properties));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate {
  final List<RelatedTopics> props;

  DataSearch(this.props);

  // final cities = ['Dallas', 'Princeton', 'Irving', 'Carrolton', 'Minnesota'];

  List<RelatedTopics> recentCities = <RelatedTopics>[];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null.toString());
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Card(
        color: Colors.red,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty && recentCities.isNotEmpty
        ? recentCities
        : props.where((p) => p.firstUrl.toString().contains(query)).toList();
    return ListView.builder(
        itemBuilder: ((context, index) => Card(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                ),
                child: ListTile(
                    onTap: () {
                      // showResults(context);

                      recentCities.add(suggestionList[index]);

                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (context) {
                        return RealEstateDetailScreenNew(
                          selectedProperty: suggestionList[index],
                        );
                      }));
                    },
                    leading: const Icon(Icons.location_city),
                    title: RichText(
                        text: TextSpan(
                            text: suggestionList[index].firstUrl.toString()
                            // .substring(
                            //   0,
                            //   query.length
                            //   ,
                            // )
                            ,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                          TextSpan(
                              text: suggestionList[index]
                                  .firstUrl
                                  .toString()
                                  .substring(
                                    query.length,
                                  ),
                              style: const TextStyle(color: Colors.grey))
                        ]))),
              ),
            )),
        itemCount: suggestionList.length);
  }
}
