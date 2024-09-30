import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Resources/assets.dart';
import '../../App/app.dart';
import 'meal_selection_page.dart';
import '../../App/my_home_page.dart';
import 'dart:ui';

class PlanDietPageGenerator extends StatelessWidget {
  const PlanDietPageGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          // title: Text('Tab View Example'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.build), text: 'Custom'),
              Tab(icon: Icon(Icons.generating_tokens), text: 'Generate'),
              Tab(icon: Icon(Icons.book), text: 'Prescription'),
            ],
            labelColor: Colors.green.shade800,
            indicatorColor: Colors.green.shade800,
          ),
        ),
        body: const TabBarView(
          children: [
            CustomMealPlanPage(),
            GenerateMealPlanPage(),
            PrescriptionMealPlanPage(),
          ],
        ),
      ),
    );
  }

  //   return Scaffold(
  //     body: Stack(
  //       fit: StackFit.expand,
  //       children: <Widget>[
  //         Image.asset(
  //           'assets/bg.png',
  //           fit: BoxFit.cover,
  //           // height: 120,
  //         ),
  //         BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  //           child: Container(
  //             color: Colors.white.withOpacity(0.8),
  //           ),
  //         ),
  //         Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Expanded(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     BigCard(text_: appState.recCal),
  //                     const Text(
  //                       "Recommended",
  //                       style: TextStyle(fontSize: 12),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Expanded(
  //                 flex: 2,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     _buildButton(
  //                       context,
  //                       "Custom",
  //                       '3',
  //                       const CustomMealPlanPage(),
  //                     ),
  //                     _buildButton(
  //                       context,
  //                       "Generate",
  //                       '10',
  //                       const GenerateMealPlanPage(),
  //                     ),
  //                     _buildButton(
  //                       context,
  //                       "Prescription",
  //                       '1',
  //                       const PrescriptionMealPlanPage(),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildButton(
      BuildContext context, String text, String image, Widget page) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            buttonText: "",
            image: image,
          ),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class GenerateMealPlanPageGenerator extends StatefulWidget {
  const GenerateMealPlanPageGenerator({super.key});

  @override
  _GenerateMealPlanPageState createState() => _GenerateMealPlanPageState();
}

class _GenerateMealPlanPageState extends State<GenerateMealPlanPageGenerator> {
  double tot = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
        // appBar: const CustomAppBar(title: "Generate Meal Plan"),
        body: SingleChildScrollView(
            child: Column(
      children: [
        const SizedBox(height: 30.0),
        const Center(
            child: Text(
          "Enter the amounts you want",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        const Center(
            child: Text(
          "We will give you the meal plan",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        const SizedBox(height: 25.0),
        Row(mainAxisSize: MainAxisSize.min, children: [
          UnitButtons(
            onPressed: () {
              appState.getUnit("Calories");
            },
            buttonText: "Calories",
            pressed: appState.units[0],
          ),
          const SizedBox(width: 20.0),
          UnitButtons(
            onPressed: () {
              appState.getUnit("Cups");
            },
            buttonText: "Cups",
            pressed: appState.units[1],
          ),
          const SizedBox(width: 20.0),
          UnitButtons(
            onPressed: () {
              appState.getUnit("Grams");
            },
            buttonText: "Grams",
            pressed: appState.units[2],
          ),
        ]),
        const SizedBox(
          height: 30,
        ),
        CustomTextInputBox(
            placeholder: appState.measureUnit,
            prefixText: 'Breakfast',
            fontSize1: 24,
            onChanged: (value) {
              setState(() {
                appState.mealCals[0] = double.parse(value);
                appState.getTotal();
              });
            }),
        const SizedBox(
          height: 10,
        ),
        CustomTextInputBox(
            placeholder: appState.measureUnit,
            prefixText: 'Snack      ',
            fontSize1: 24,
            onChanged: (value) {
              setState(() {
                appState.mealCals[1] = double.parse(value);
                appState.getTotal();
              });
            }),
        const SizedBox(
          height: 10,
        ),
        CustomTextInputBox(
            placeholder: appState.measureUnit,
            prefixText: 'Lunch      ',
            fontSize1: 24,
            onChanged: (value) {
              setState(() {
                appState.mealCals[2] = double.parse(value);
                appState.getTotal();
              });
            }),
        const SizedBox(
          height: 10,
        ),
        CustomTextInputBox(
            placeholder: appState.measureUnit,
            prefixText: 'Snack      ',
            fontSize1: 24,
            onChanged: (value) {
              setState(() {
                appState.mealCals[3] = double.parse(value);
                appState.getTotal();
              });
            }),
        const SizedBox(
          height: 10,
        ),
        CustomTextInputBox(
            placeholder: appState.measureUnit,
            prefixText: 'Dinner     ',
            fontSize1: 24,
            onChanged: (value) {
              setState(() {
                appState.mealCals[4] = double.parse(value);
                appState.getTotal();
              });
            }),
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
            'Tip! Try to spread your calories equally throughout the meals of the day to avoid getting hungry',
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //const SizedBox(width: 20,),
            Column(
              children: [
                BigCard(text_: appState.recCal),
                const Text(
                  'Recommended',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            Column(
              children: [
                BigCard(text_: appState.total),
                const Text(
                  'Your Total',
                  style: TextStyle(fontSize: 18),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () {
            print('Generate meal plan');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MealSelectionPage(appState: appState)),
            );
          },
          child: const Text('Generate', style: TextStyle(fontSize: 16)),
        ),
      ],
    )));
  }
}

class CustomMealPlanPageGenerator extends StatefulWidget {
  const CustomMealPlanPageGenerator({super.key});

  @override
  _CustomMealPlanPageState createState() => _CustomMealPlanPageState();
}

class _CustomMealPlanPageState extends State<CustomMealPlanPageGenerator> {
  final List<String> foodItems = [
    'rice',
    'potato',
    'bread',
    'dhal',
    'eggplant',
    'bean'
  ];
  final List<String> snackItems = ['biscuit', 'cake', 'fruit'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      // appBar: const CustomAppBar(title: "Custom Meal Plan"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            const Center(
                child: Text(
              "Tell us what you want to eat.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            const Center(
                child: Text(
              "We will recommend the intake.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 8.0),
            CustomCalendar(
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {});
              },
            ),
            const SizedBox(height: 25.0),
            Row(mainAxisSize: MainAxisSize.min, children: [
              UnitButtons(
                onPressed: () {
                  appState.getUnit("Calories");
                },
                buttonText: "Calories",
                pressed: appState.units[0],
              ),
              const SizedBox(width: 20.0),
              UnitButtons(
                onPressed: () {
                  appState.getUnit("Cups");
                },
                buttonText: "Cups",
                pressed: appState.units[1],
              ),
              const SizedBox(width: 20.0),
              UnitButtons(
                onPressed: () {
                  appState.getUnit("Grams");
                },
                buttonText: "Grams",
                pressed: appState.units[2],
              ),
            ]),
            const SizedBox(height: 20.0),
            CustomExpandingWidget(
              listTitle: 'Breakfast',
              suggestions: foodItems,
              onChanged: (value) {
                setState(() {
                  // appState.mealCals[0] = double.parse(value);
                  // appState.breakfast.add(value);
                  // print(appState.breakfast);
                });
                // Print the list
              },
              units: appState.measureUnit,
              amount: appState.breakfastPortion,
              mealItems: appState.breakfast,
            ),
            const SizedBox(height: 20.0),
            CustomExpandingWidget(
              listTitle: 'Snack',
              suggestions: snackItems,
              onChanged: (value) {
                setState(() {
                  print(appState.snack1);
                });
                // Print the list
              },
              units: appState.measureUnit,
              amount: appState.snack1Portion,
              mealItems: appState.snack1,
            ),
            const SizedBox(height: 20.0),
            CustomExpandingWidget(
              listTitle: 'Lunch',
              suggestions: foodItems,
              onChanged: (value) {
                setState(() {
                  print(appState.lunch);
                });
                // Print the list
              },
              units: appState.measureUnit,
              amount: appState.lunchPortion,
              mealItems: appState.lunch,
            ),
            const SizedBox(height: 20.0),
            CustomExpandingWidget(
              listTitle: 'Snack',
              suggestions: snackItems,
              onChanged: (value) {
                setState(() {
                  print(appState.snack2);
                });
              },
              units: appState.measureUnit,
              amount: appState.snack2Portion,
              mealItems: appState.snack2,
            ),
            const SizedBox(height: 20.0),
            CustomExpandingWidget(
              listTitle: 'Dinner',
              suggestions: foodItems,
              onChanged: (value) {
                setState(() {
                  print(appState.dinner);
                });
                // Print the list
              },
              units: appState.measureUnit,
              amount: appState.dinnerPortion,
              mealItems: appState.dinner,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  print('Generate custom meal plan');
                },
                child: Text('Done',
                    style:
                        TextStyle(fontSize: 16, color: Colors.green.shade800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrescriptionMealPlanPageGenerator extends StatefulWidget {
  const PrescriptionMealPlanPageGenerator({super.key});

  @override
  _PrescriptionMealPlanPageGenerator createState() =>
      _PrescriptionMealPlanPageGenerator();
}

class _PrescriptionMealPlanPageGenerator
    extends State<PrescriptionMealPlanPageGenerator> {
  final List<String> foodItems = [
    'rice',
    'potato',
    'bread',
    'dhal',
    'eggplant',
    'bean'
  ];
  final List<String> snackItems = ['biscuit', 'cake', 'fruit'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      // appBar: const CustomAppBar(title: "Prescription Meal Plan"),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 30.0),
          const Center(
              child: Text(
            "Tell us what you want to eat.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          const Center(
              child: Text(
            "We will recommend the intake.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 8.0),
          CustomCalendar(
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {});
            },
          ),
          const SizedBox(height: 25.0),
          Row(mainAxisSize: MainAxisSize.min, children: [
            UnitButtons(
              onPressed: () {
                appState.getUnit("Calories");
              },
              buttonText: "Calories",
              pressed: appState.units[0],
            ),
            const SizedBox(width: 20.0),
            UnitButtons(
              onPressed: () {
                appState.getUnit("Cups");
              },
              buttonText: "Cups",
              pressed: appState.units[1],
            ),
            const SizedBox(width: 20.0),
            UnitButtons(
              onPressed: () {
                appState.getUnit("Grams");
              },
              buttonText: "Grams",
              pressed: appState.units[2],
            ),
          ]),
          const SizedBox(height: 20.0),
          CustomExpandingWidgetVer2(
            listTitle: 'Breakfast',
            suggestions: foodItems,
            onChanged: (value) {
              setState(() {
                print(appState.dinner);
              });
            },
            units: appState.measureUnit,
            pairList: appState.breakfastPrescription,
          ),
          const SizedBox(height: 20.0),
          CustomExpandingWidgetVer2(
            listTitle: 'Snack',
            suggestions: snackItems,
            onChanged: (value) {
              setState(() {
                print(appState.dinner);
              });
            },
            units: appState.measureUnit,
            pairList: appState.breakfastPrescription,
          ),
          const SizedBox(height: 20.0),
          CustomExpandingWidgetVer2(
            listTitle: 'Lunch',
            suggestions: foodItems,
            onChanged: (value) {
              setState(() {
                print(appState.dinner);
              });
            },
            units: appState.measureUnit,
            pairList: appState.breakfastPrescription,
          ),
          const SizedBox(height: 20.0),
          CustomExpandingWidgetVer2(
            listTitle: 'Snack',
            suggestions: snackItems,
            onChanged: (value) {
              setState(() {
                print(appState.dinner);
              });
            },
            units: appState.measureUnit,
            pairList: appState.breakfastPrescription,
          ),
          const SizedBox(height: 20.0),
          CustomExpandingWidgetVer2(
            listTitle: 'Dinner',
            suggestions: foodItems,
            onChanged: (value) {
              setState(() {
                print(appState.dinner);
              });
            },
            units: appState.measureUnit,
            pairList: appState.breakfastPrescription,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                print('Generate custom meal plan');
              },
              child: Text('Done',
                  style: TextStyle(fontSize: 16, color: Colors.green.shade800)),
            ),
          ),
        ]),
      ),
    );
  }
}
