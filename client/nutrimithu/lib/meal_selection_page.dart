import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

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
        print('Parsed meal options: $mealOptions');
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
          _buildMealSection('Breakfast', widget.appState.mealCals[0]),
          _buildMealSection('Snack 1', widget.appState.mealCals[1]),
          _buildMealSection('Lunch', widget.appState.mealCals[2]),
          _buildMealSection('Snack 2', widget.appState.mealCals[3]),
          _buildMealSection('Dinner', widget.appState.mealCals[4]),
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

  Widget _buildMealSection(String mealType, double calories) {
    final meals = mealOptions[mealType] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(mealType,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        if (meals.isEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Loading meals...'),
          )
        else
          ...meals.map((meal) => CustomMealTile(
                title: meal['name'],
                calories: meal['calories'].toString(),
                isSelected:
                    selectedMeals[mealType] == meal['meal_id'].toString(),
                onTap: () {
                  setState(() {
                    selectedMeals[mealType] = meal['meal_id'].toString();
                  });
                },
              )),
        SizedBox(height: 16),
      ],
    );
  }

  Future<void> _saveMealPlan() async {
    if (selectedMeals.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a meal for each category')),
      );
      return;
    }

    // Store selected meal IDs locally
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedMealPlan', json.encode(selectedMeals));

    widget.appState.selectedMealPlan = selectedMeals;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Meal plan saved successfully')),
    );
  }
}

class CustomMealTile extends StatelessWidget {
  final String title;
  final String calories;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomMealTile({
    Key? key,
    required this.title,
    required this.calories,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$calories calories',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? Colors.green : Colors.grey,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
