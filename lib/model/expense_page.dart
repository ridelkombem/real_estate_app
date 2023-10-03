import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expense.dart';
import 'expenses.dart';

class ExpensesPageManager extends StatefulWidget {
  const ExpensesPageManager({super.key});

  @override
  State<ExpensesPageManager> createState() => _ExpensesPageManagerState();
}

class _ExpensesPageManagerState extends State<ExpensesPageManager> {
  var activeScreen = 'exp-page';
  void switchScreen() {
    setState(() {
      activeScreen = 'add-exp-page';
    });
  }

  var selectedCategory = Category.food;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = ExpensesPage(selectedDate, selectedCategory);

    if (activeScreen == 'exp-page') {
      screenWidget = ExpensesPage(selectedDate, selectedCategory);
    }

    if (activeScreen == 'add-exp-page') {
      screenWidget = const AddExpensePage();
    }

    return Scaffold(body: screenWidget);
  }
}


class ExpensesPage extends StatefulWidget {
  ExpensesPage(this.selectedDate, this.selectedCategory, {super.key});

  Category selectedCategory;
  DateTime? selectedDate;

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final form = GlobalKey<FormState>();
  

  datePicker() async {
    var now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      widget.selectedDate = pickedDate;
    });
  }

  DropdownButton<Category> dropdown() {
    return DropdownButton<Category>(
      items: (Category.values)
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category.name),
              ))
          .toList(),
      onChanged: (value) {
        widget.selectedCategory = value!;
      },
      value: widget.selectedCategory,
    );
  }

  removeExpense(Expense expense) {
    setState(() {
      expenses.remove(expense);
    });
  }

  
  void submit(amount, title) {
    final isValid = form.currentState!.validate();
    if (!isValid && widget.selectedDate == null) {
      return;
    } else {
      print(title);
      print(amount);
      print(widget.selectedDate);
      print(widget.selectedCategory);

      setState(() {
        expenses.add((Expense(
            title: title,
            amount: amount,
            category: widget.selectedCategory,
            date: widget.selectedDate!)));
      });

      Navigator.pop(context);
    }

    form.currentState!.reset();
  }

  void showOverlayScreen() {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (context) {
          return Container(
              margin: const EdgeInsets.all(15),
              child: Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a title';
                        }
                        if (value.trim().length <= 3) {
                          return 'The description should have a minimum of 3 characters';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(hintText: 'Amount'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a amount.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please provide a valid number.';
                        }
                        if (double.parse(value.trim()) <= 0) {
                          return 'Please provide a value greater than 0';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                datePicker();
                              },
                              icon: const Icon(Icons.calendar_month)),
                          Text(widget.selectedDate == null
                              ? 'Chose Date'
                              : widget.selectedDate.toString()),
                          const Spacer(),
                          dropdown()
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple),
                          onPressed: () {
                            var amount =
                                double.parse(amountController.text.trim());
                            var title = titleController.text.trim();
                            submit(amount, title);
                          },
                          child: const Text(
                            'submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.purple),
                            )),
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(),
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: ((context, index) {
                // Widget getIcon() {
                //   var resultIcon = const Icon(Icons.dangerous);
                //   if (expenses[index].category == Category.leisure) {
                //     resultIcon = const Icon(Icons.movie);
                //   } else if (expenses[index].category == Category.food) {
                //     resultIcon = const Icon(Icons.lunch_dining);
                //   } else if (expenses[index].category == Category.travel) {
                //     resultIcon = const Icon(Icons.flight_takeoff);
                //   } else if (expenses[index].category == Category.work) {
                //     resultIcon = const Icon(Icons.work);
                //   }
                //   return resultIcon;
                // }

                return Dismissible(
                  key: ValueKey(expenses[index]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    var expense = expenses[index];
                    removeExpense(expense);
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child:
                            FittedBox(child: Text('${expenses[index].amount}')),
                      ),
                      title: Text(expenses[index].title),
                      subtitle:
                          Text(DateFormat.yMd().format(expenses[index].date)),
                      trailing: Icon(categoryIcons[expenses[index].category]),
                    ),
                  ),
                );
              }),
              itemCount: expenses.length,
            ),
          ),
          const Chart()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showOverlayScreen();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  List<Expense> expenses;
  double get totalExpenses {
    double sum = 0.0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}

class Chart extends StatefulWidget {
  const Chart({
    super.key,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Row(
        children: buckets.map((bucket) {
          var bucketAmount = bucket.totalExpenses / maxTotalExpense;
          return Expanded(
            child: Column(
              children: [
                SizedBox(
                    height: maxTotalExpense,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                            heightFactor: bucketAmount,
                            widthFactor: 0.5,
                            child: const DecoratedBox(
                                decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8)),
                            ))))),
                SizedBox(
                  child: Icon(categoryIcons[bucket.category]),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );

    // );
  }
}

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
