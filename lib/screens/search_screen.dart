import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = ['Dallas', 'Princeton', 'Irving', 'Carrolton', 'Minnesota'];
  final recentCities = [
    'Princeton',
    'Irving',
    'Carrolton',
  ];
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
    final suggestionList = query.isEmpty ? recentCities : cities;
    // .where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: ((context, index) => ListTile(
          onTap: () {
            showResults(context);
          },
          leading: const Icon(Icons.location_city),
          title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(
                    0,
                    query.length,
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                TextSpan(
                    text: suggestionList[index].substring(
                      query.length,
                    ),
                    style: const TextStyle(color: Colors.grey))
              ])))),
      itemCount: suggestionList.length,
    );
  }
}
