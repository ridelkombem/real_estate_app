import 'package:flutter/material.dart';
import 'package:real_estate_final_app/model/grocery_item.dart';
import 'package:real_estate_final_app/model/grocery_items.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  removeGrocery(Grocery grocery) {
    setState(() {
      groceries.remove(grocery);
    });
  }

  onAddGrocery() async {
    var newItem = await Navigator.of(context).push<Grocery>(
        MaterialPageRoute(builder: (ctx) => AddGroceriesScreen()));

    if (newItem == null) {
      return;
    } else {
      setState(() {
        groceries.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(onPressed: onAddGrocery, icon: const Icon(Icons.add))
        ],
      ),
      body: SizedBox(
        height: 300,
        child: ListView.builder(
            itemCount: groceries.length,
            itemBuilder: ((context, index) {
              return Dismissible(
                key: ValueKey(groceries[index]),
                onDismissed: (direction) {
                  var grocery = groceries[index];
                  removeGrocery(grocery);
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor:
                          groceryCategoryColors[GroceryCategory.fruits]),
                  title: Text(groceries[index].name),
                  trailing: Text('${groceries[index].quantity}'),
                ),
              );
            })),
      ),
    );
  }
}

class AddGroceriesScreen extends StatefulWidget {
  AddGroceriesScreen();

  @override
  State<AddGroceriesScreen> createState() => _AddGroceriesScreenState();
}

class _AddGroceriesScreenState extends State<AddGroceriesScreen> {
  final titleController = TextEditingController();
  final quantityController = TextEditingController();
  final form = GlobalKey<FormState>();
  var selectedCategory = GroceryCategory.vegetables;

  void submit() {
    var title = titleController.text;
    var quantity = int.parse(quantityController.text);

    Navigator.of(context).pop(
        Grocery(name: title, quantity: quantity, category: selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Groceries')),
      body: Form(
        key: form,
        child: Container(
          margin: const EdgeInsets.all(15),
          height: 500,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: quantityController,
                      decoration: const InputDecoration(hintText: 'Quantity'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: DropdownButtonFormField(
                          value: selectedCategory,
                          items: (GroceryCategory.values)
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            selectedCategory = value!;
                          }),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Reset')),
                  ElevatedButton(
                      onPressed: submit, child: const Text('Add Item'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
