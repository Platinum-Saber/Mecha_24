import 'package:flutter/material.dart';
import 'package:nutrimithu/login_page.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'profile_page.dart';
import 'plan_diet_page.dart';
import 'calorieDiary_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'NutriMithu',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 125, 167, 255)),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var measureUnit = "none";
  var units = <bool>[false, false, false];
  var recCal = "1800";
  var total = "1000";
  var mealCals = <double>[0, 0, 0, 0, 0];

  var breakfast = <String>{}.toSet();
  var snack1 = <String>{}.toSet();
  var lunch = <String>{}.toSet();
  var snack2 = <String>{}.toSet();
  var dinner = <String>{}.toSet();

  final ValueNotifier<double> snack1Portion = ValueNotifier<double>(0.0);
  final ValueNotifier<double> lunchPortion = ValueNotifier<double>(0.0);
  final ValueNotifier<double> snack2Portion = ValueNotifier<double>(0.0);
  final ValueNotifier<double> dinnerPortion = ValueNotifier<double>(0.0);
  final ValueNotifier<double> breakfastPortion = ValueNotifier<double>(0.0);

  final Set<Map<String, double>> breakfastPrescription = {};
  final Set<Map<String, double>> lunchPrescription = {};
  final Set<Map<String, double>> dinnerPrescription = {};

  var name = 'Helena Hills'; //get from database
  var email = 'name@domain.com'; //get from database
  var username = '@helenahills'; //get from database
  var profilepic = ''; //get from database
  var sex = 'Female'; //get from database
  var vegetarian = 'Vegetarian'; //get from database
  var dateOfBirth = DateTime(1990, 1, 1);
  var height = 170.0;
  var heightUnit = 'none';
  var heightInCm = true;
  var weight = 60.0;
  var allergies = 'None';
  var bmi = 20.76;
  var bmiCategory = 'Normal Weight';
  // var weightToLose = 2;
  var eer = 20;
  var weightLossGoal = 10;
  var weightLossRate = 500;
  var protienPerDay = 50;
  var srilankan = 'Sri Lankan';
  var activityLevel = 'Moderate';
  var maintainWeight = false;
  var currentCalorieIntake = 1800;

  var mealToPack = 'Breakfast';
  var mealIndex = 0;
  var mealsCompleted = <bool>[false, false, false, false, false];

  void getUnit(String unit) {
    measureUnit = unit;
    switch (unit) {
      case "Calories":
        units = [true, false, false];
        break;
      case "Cups":
        units = [false, true, false];
        break;
      case "Grams":
        units = [false, false, true];
        break;
      default:
        units = [false, false, false];
    }
    notifyListeners();
  }

  void getHeightUnit(String unit) {
    heightUnit = unit;
    if (unit == "cm") {
      heightInCm = true;
    } else {
      heightInCm = false;
    }
    notifyListeners();
  }

  void getTotal() {
    double tot = 0;
    for (int i = 0; i < 5; i++) {
      tot += mealCals[i];
    }
    total = tot.toString();
    notifyListeners();
  }

  void printMeal(String list) {
    print(list[0]);
    notifyListeners();
  }

  void changeProfilePicture() {
    // Implement logic to change the profile picture
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const PlanDietPage(),
    const CalorieDiaryPage(),
    const ProfilePage(),
  ];

  final List<String> _titles = [
    'NutriMithu',
    'Plan Diet',
    'Calorie Diary',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        shadowColor: Colors.grey.shade400, // Set the shadow color
        surfaceTintColor: Colors.white,
        // centerTitle: true,
        title: Text(_titles[_currentIndex],
            style: const TextStyle(color: Colors.grey)),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color.fromARGB(
            255, 125, 167, 255), // Set the color for selected items
        unselectedItemColor: Colors.grey,
        type:
            BottomNavigationBarType.fixed, // Set the color for unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Plan Diet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Calorie Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends HomePageGenerator {
  const HomePage({super.key});
}

class PackMyMealPage extends PackMyMealPageGenerator {
  const PackMyMealPage({super.key});
}

class PlanDietPage extends PlanDietPageGenerator {
  const PlanDietPage({super.key});
}

class GenerateMealPlanPage extends GenerateMealPlanPageGenerator {
  const GenerateMealPlanPage({super.key});
}

class CustomMealPlanPage extends CustomMealPlanPageGenerator {
  const CustomMealPlanPage({super.key});
}

class CalorieDiaryPage extends CalorieDiaryPageGenerator {
  const CalorieDiaryPage({super.key});
}

class PrescriptionMealPlanPage extends PrescriptionMealPlanPageGenerator {
  const PrescriptionMealPlanPage({super.key});
}

class ProfilePage extends ProfilePageGenerator {
  const ProfilePage({super.key});
}
