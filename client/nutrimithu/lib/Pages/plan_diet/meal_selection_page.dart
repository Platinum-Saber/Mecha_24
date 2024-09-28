import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../App/app.dart';
import '../../Resources/assets.dart';

class MealSelectionPage extends StatefulWidget {
  final MyAppState appState;

  const MealSelectionPage({Key? key, required this.appState}) : super(key: key);

  @override
  _MealSelectionPageState createState() => _MealSelectionPageState();
}

class _MealSelectionPageState extends State<MealSelectionPage> {
  Map<String, String> selectedMeals = {};
  Map<String, List<Map<String, dynamic>>> mealOptions = {};

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  Future<void> _fetchMeals() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/meals'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          mealOptions = {
            'Breakfast': List<Map<String, dynamic>>.from(data['breakfast']),
            'Snack 1': List<Map<String, dynamic>>.from(data['snack1']),
            'Lunch': List<Map<String, dynamic>>.from(data['lunch']),
            'Snack 2': List<Map<String, dynamic>>.from(data['snack2']),
            'Dinner': List<Map<String, dynamic>>.from(data['dinner']),
          };
        });
      } else {
        print('Failed to load meals. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching meals: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Meals')),
      body: ListView(
        children: [
          MealSelectionWidget(
            mealType: 'Breakfast',
            mealOptions: mealOptions['Breakfast'] ?? [],
            selectedMealId: selectedMeals['Breakfast'],
            onMealSelected: (mealId) {
              setState(() {
                selectedMeals['Breakfast'] = mealId;
              });
            },
          ),
          MealSelectionWidget(
            mealType: 'Snack 1',
            mealOptions: mealOptions['Snack 1'] ?? [],
            selectedMealId: selectedMeals['Snack 1'],
            onMealSelected: (mealId) {
              setState(() {
                selectedMeals['Snack 1'] = mealId;
              });
            },
          ),
          MealSelectionWidget(
            mealType: 'Lunch',
            mealOptions: mealOptions['Lunch'] ?? [],
            selectedMealId: selectedMeals['Lunch'],
            onMealSelected: (mealId) {
              setState(() {
                selectedMeals['Lunch'] = mealId;
              });
            },
          ),
          MealSelectionWidget(
            mealType: 'Snack 2',
            mealOptions: mealOptions['Snack 2'] ?? [],
            selectedMealId: selectedMeals['Snack 2'],
            onMealSelected: (mealId) {
              setState(() {
                selectedMeals['Snack 2'] = mealId;
              });
            },
          ),
          MealSelectionWidget(
            mealType: 'Dinner',
            mealOptions: mealOptions['Dinner'] ?? [],
            selectedMealId: selectedMeals['Dinner'],
            onMealSelected: (mealId) {
              setState(() {
                selectedMeals['Dinner'] = mealId;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _saveMealPlan,
              child: Text('Confirm Selections'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveMealPlan() async {
    if (selectedMeals.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a meal for each category')),
      );
      return;
    }

    final filteredMeals = Map.fromEntries(
      selectedMeals.entries.where((entry) => entry.value != 'null'),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedMealPlan', json.encode(filteredMeals));

    widget.appState.selectedMealPlan = filteredMeals;

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/save-meal-plan'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': widget.appState.userId,
          'mealPlan': filteredMeals,
          'mealCals': widget.appState.mealCals
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Meal plan saved successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save meal plan')),
        );
      }
    } catch (e) {
      print('Error saving meal plan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving meal plan')),
      );
    }
  }
}
