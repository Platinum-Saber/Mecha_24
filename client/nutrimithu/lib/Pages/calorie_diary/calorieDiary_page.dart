import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../App/app.dart';
import '../../Resources/assets.dart';

class CalorieDiaryPageGenerator extends StatefulWidget {
  const CalorieDiaryPageGenerator({super.key});

  @override
  _CalorieDiaryPageState createState() => _CalorieDiaryPageState();
}

class _CalorieDiaryPageState extends State<CalorieDiaryPageGenerator> {
  final List<String> foodItems = [
    'rice',
    'potato',
    'bread',
    'dhal',
    'eggplant',
    'bean'
  ];
  final List<String> snackItems = ['biscuit', 'cake', 'fruit'];
  final Set<Map<String, double>> itemList = {
    {'rice': 100},
    {'bread': 120},
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            CustomCalendar(
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {});
              },
            ),
            const SizedBox(height: 60.0),
            CustomExpandingWidgetVer3(
                listTitle: 'Breakfast', units: 'Calories', pairList: itemList),
            const SizedBox(
              height: 20,
            ),
            CustomExpandingWidgetVer3(
                listTitle: 'Snack', units: 'Calories', pairList: itemList),
            const SizedBox(
              height: 20,
            ),
            CustomExpandingWidgetVer3(
                listTitle: 'Lunch', units: 'Calories', pairList: itemList),
            const SizedBox(
              height: 20,
            ),
            CustomExpandingWidgetVer3(
                listTitle: 'Snack', units: 'Calories', pairList: itemList),
            const SizedBox(
              height: 20,
            ),
            CustomExpandingWidgetVer3(
                listTitle: 'Dinner', units: 'Calories', pairList: itemList),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
