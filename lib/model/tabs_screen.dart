import 'package:flutter/material.dart';
import 'package:real_estate_final_app/model/categories.dart';
import 'package:real_estate_final_app/model/meal.dart';
import 'package:real_estate_final_app/model/meals.app.dart';

import 'category.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Meal> availableMeals = [];
  late Meal sortMeal;

  var activeScreen = 'categories-screen';
  var activeScreenTitle = 'Categories';
  void onSelectCategory(Category category) {
    setState(() {
      var newMeals =
          meals.where((meal) => meal.categories.contains(category.id)).toList();
      availableMeals = newMeals;
      activeScreen = 'meals-screen';
      activeScreenTitle = 'Meals';
    });
  }

  void onSelectMeal(Meal availableMealz) {
    setState(() {
      var sortedMeal = availableMeals
          .firstWhere((availableMeal) => availableMeal.id == availableMealz.id);
      sortMeal = sortedMeal;
      activeScreen = 'detail-screen';
      activeScreenTitle = availableMealz.title;
    });
  }

  int currentIndex = 0;

  void onSelectPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void onSetScreen(String identifier) async {
    if (identifier == 'Meals') {
      Navigator.pop(context);
    }
    if (identifier == 'filters') {
      Navigator.pop(context);
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    }
  }

  final List<Meal> _favoriteMeals = [];

  void _showInfoMessageFavorite(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void toggleMealFavoritestatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessageFavorite('Meal is no longer a Favorite');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessageFavorite('Marked as a Favorite!');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = CatgoriesScreen(
      onSelectCategory,
    );
    if (activeScreen == 'categories-screen') {
      screenWidget = CatgoriesScreen(
        onSelectCategory,
      );
    }
    if (activeScreen == 'meals-screen') {
      screenWidget = MealsScreen(availableMeals, onSelectMeal);
    }
    if (activeScreen == 'detail-screen') {
      screenWidget =
          DetailScreen(availableMeals, sortMeal, toggleMealFavoritestatus);
    }
    if (currentIndex == 1) {
      screenWidget = MealsScreen(_favoriteMeals, toggleMealFavoritestatus);
      activeScreenTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
        backgroundColor: Colors.red,
      ),
      body: screenWidget,
      drawer: Drawer(
          child: Column(children: [
        Container(
          height: 120,
          width: double.infinity,
          color: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Cooking Up!',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Colors.amber,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dining),
          title: Text('Meals'),
          onTap: () {
            onSetScreen('Meals');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {
            onSetScreen('Settings');
          },
        ),
      ])),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red,
          currentIndex: currentIndex,
          onTap: onSelectPage,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorites'),
          ]),
    );
  }
}

class CatgoriesScreen extends StatelessWidget {
  const CatgoriesScreen(this.getCategory, {super.key});
  final void Function(Category category) getCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15),
        child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10),
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: () {
                  var category = categories[i];
                  getCategory(category);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: categories[i].color,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(categories[i].title),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class MealsScreen extends StatelessWidget {
  const MealsScreen(this.availableMeals, this.onSelectMeal, {super.key});
  final List<Meal> availableMeals;
  final void Function(Meal availableMeal) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: availableMeals.map((availableMeal) {
        return Expanded(
          child: Column(
            children: [
              SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    onSelectMeal(availableMeal);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(availableMeal.imageUrl),
                                fit: BoxFit.cover)),
                        child: Center(
                            child: Text(
                          availableMeal.title,
                          style: const TextStyle(
                              color: Colors.amber,
                              backgroundColor: Colors.black54),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.duo_sharp),
                                Text(availableMeal.duration.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.money),
                                Text(availableMeal.affordability.name),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.macro_off),
                                Text(availableMeal.complexity.name),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      this.availableMeals, this.sortMeal, this.toggleMealFavoritestatus,
      {super.key});
  final List<Meal> availableMeals;
  final Meal sortMeal;
  final void Function(Meal meal) toggleMealFavoritestatus;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.sortMeal.imageUrl),
                    fit: BoxFit.cover)),
          ),
          const Text('Ingredients'),
          Container(
            margin: const EdgeInsets.all(15),
            height: 100,
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    Container(
                      color: Colors.amber,
                      child: Text(widget.sortMeal.ingredients[i]),
                    ),
                  ],
                );
              },
              itemCount: widget.sortMeal.ingredients.length,
            ),
          ),
          const Text('Steps'),
          Container(
            margin: const EdgeInsets.all(15),
            height: 100,
            child: ListView.builder(
                itemCount: widget.sortMeal.steps.length,
                itemBuilder: (ctx, i) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.sortMeal.steps[i]),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      widget.toggleMealFavoritestatus(widget.sortMeal);
                    },
                    color: Colors.amber,
                    icon: Icon(
                      Icons.star,
                      size: 50,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Text('Filters')],
      ),
    );
  }
}
