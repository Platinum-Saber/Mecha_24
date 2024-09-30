import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../App/app.dart';
import '../../Resources/assets.dart';
import 'dart:ui';

class CalorieDiaryPageGenerator extends StatefulWidget {
  const CalorieDiaryPageGenerator({super.key});

  @override
  _CalorieDiaryPageState createState() => _CalorieDiaryPageState();
}

class _CalorieDiaryPageState extends State<CalorieDiaryPageGenerator> {
  Map<String, dynamic> mealPlan = {};

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchCalorieDiary(String userId, String date) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/calorie-diary/$userId/$date'));

    if (response.statusCode == 200) {
      setState(() {
        mealPlan = json.decode(response.body);
        print('mealPlan is $mealPlan');
        print("//////////////////////////////////////////////");
      });
    } else {
      throw Exception('Failed to load calorie diary');
    }
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
                String formattedDate =
                    selectedDay.toIso8601String().split('T')[0];
                print(
                    'appState.userId.toString() is ${appState.userId.toString()}');
                print('formatted Date is ${formattedDate}');

                fetchCalorieDiary(appState.userId.toString(), formattedDate);
              },
            ),
            const SizedBox(height: 60.0),
            CustomExpandingWidgetVer3(
                listTitle: 'Breakfast',
                units: 'Calories',
                pairList: _getItemList('breakfast')),
            const SizedBox(
              height: 20,
            ),
            CustomExpandingWidgetVer3(
                listTitle: 'Snack 1',
                units: 'Calories',
                pairList: _getItemList('snack1')),
            const SizedBox(
              height: 20,
            ),
            CustomExpandingWidgetVer3(
                listTitle: 'Lunch',
                units: 'Calories',
                pairList: _getItemList('lunch')),
            const SizedBox(
              height: 20,
            ),
            CustomExpandingWidgetVer3(
                listTitle: 'Snack 2',
                units: 'Calories',
                pairList: _getItemList('snack2')),
            const SizedBox(
              height: 20,
            ),
            CustomExpandingWidgetVer3(
                listTitle: 'Dinner',
                units: 'Calories',
                pairList: _getItemList('dinner')),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Set<Map<String, double>> _getItemList(String mealType) {
    if (mealPlan.isEmpty || !mealPlan.containsKey(mealType)) {
      return {};
    }

    var itemList = mealPlan[mealType].map<Map<String, double>>((item) {
      return {item['name']: item['calories'].toDouble()};
    }).toSet();

    print('Item list for $mealType: $itemList');
    return itemList;
  }
}
