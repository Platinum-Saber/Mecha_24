import 'package:flutter/material.dart';
import 'package:nutrimithu/Authentication/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Authentication/signup_page.dart';
import 'my_home_page.dart';

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
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/home': (context) => const MyHomePage(),
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var measureUnit = "none";
  var units = <bool>[false, false, false];
  var recCal = "1800";
  var total = "0000";

  var mealCals = <double>[0, 0, 0, 0, 0];
  var mealsCompleted = <bool>[
    false,
    false,
    false,
    false,
    false
  ]; //meal completion within a day.

  String mealToPack = '';
  int _mealIndex = 0;

  int get mealIndex => _mealIndex;
  set mealIndex(int value) {
    _mealIndex = value;
    notifyListeners();
  }

  int foodItemIndex = 0;

  Map<String, dynamic> selectedMealPlan = {};
  //these are the variables to store today's meal plan
  // fetched data shud be saved in this format
  var mealItems = [
    ['string hoppers: 10', 'egg: 1', 'potato: L1', 'sambol: L1'],
    ['banana: 1'],
    ['rice: L2', 'fish: 1', 'carrot: L1', 'beans: L1'],
    ['tea'],
    ['noodles: L2', 'egg: 1', 'beans: L1', 'carrot: L1']
  ];

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

  int userId = 0;
  String username = '';
  String name = '';
  String email = '';
  String gender = '';
  DateTime dateOfBirth = DateTime.now();
  double height = 0;
  double weight = 0;
  String dietaryPreference = '';
  String allergies = '';
  String ethnicity = '';
  String activityLevel = '';
  int currentCaloriesPerDay = 0;
  String weightGoal = '';
  double targetWeightKg = 0;
  String weightChangeRate = '0';

  MyAppState() {
    _loadUserData();
  }

  Future<void> initializeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getInt('userId');
    if (storedUserId != null) {
      userId = storedUserId;
      notifyListeners();
    }
  }

  void updateUserId(int newUserId) {
    userId = newUserId;
    notifyListeners();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userData = jsonDecode(userJson);
      updateProfileFromJson(userData);
    }
  }

  void updateProfileFromJson(Map<String, dynamic> json) {
    userId = json['user_id'] ?? userId;
    username = json['username'] ?? username;
    name = json['name'] ?? name;
    email = json['email'] ?? email;
    gender = json['gender'] ?? gender;
    dateOfBirth = json['date_of_birth'] != null
        ? DateTime.parse(json['date_of_birth'])
        : dateOfBirth;
    height = json['height_cm'] != null
        ? double.parse(json['height_cm'].toString())
        : height;
    weight = json['weight_kg'] != null
        ? double.parse(json['weight_kg'].toString())
        : weight;
    dietaryPreference = json['dietary_preference'] ?? dietaryPreference;
    allergies = json['allergies'] ?? allergies;
    ethnicity = json['ethnicity'] ?? ethnicity;
    activityLevel = json['activity_level'] ?? activityLevel;
    currentCaloriesPerDay = json['current_calories_per_day'] != null
        ? int.parse(json['current_calories_per_day'].toString())
        : currentCaloriesPerDay;
    weightGoal = json['weight_goal'] ?? weightGoal;
    targetWeightKg = json['target_weight_kg'] != null
        ? double.parse(json['target_weight_kg'].toString())
        : targetWeightKg;
    weightChangeRate =
        json['weight_change_rate']?.toString() ?? weightChangeRate;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'name': name,
      'email': email,
      'gender': gender,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'height_cm': height,
      'weight_kg': weight,
      'dietary_preference': dietaryPreference,
      'allergies': allergies,
      'ethnicity': ethnicity,
      'activity_level': activityLevel,
      'current_calories_per_day': currentCaloriesPerDay,
      'weight_goal': weightGoal,
      'target_weight_kg': targetWeightKg,
      'weight_change_rate': weightChangeRate,
    };
  }

  // Setters for each field that call notifyListeners()
  set setUsername(String value) {
    username = value;
    notifyListeners();
  }

  set setName(String value) {
    name = value;
    notifyListeners();
  }

  set setEmail(String value) {
    email = value;
    notifyListeners();
  }

  set setGender(String value) {
    gender = value;
    notifyListeners();
  }

  set setDateOfBirth(DateTime value) {
    dateOfBirth = value;
    notifyListeners();
  }

  set setHeight(double value) {
    height = value;
    notifyListeners();
  }

  set setWeight(double value) {
    weight = value;
    notifyListeners();
  }

  set setDietaryPreference(String value) {
    dietaryPreference = value;
    notifyListeners();
  }

  set setAllergies(String value) {
    allergies = value;
    notifyListeners();
  }

  set setEthnicity(String value) {
    ethnicity = value;
    notifyListeners();
  }

  set setActivityLevel(String value) {
    activityLevel = value;
    notifyListeners();
  }

  set setCurrentCaloriesPerDay(int value) {
    currentCaloriesPerDay = value;
    notifyListeners();
  }

  set setWeightGoal(String value) {
    weightGoal = value;
    notifyListeners();
  }

  set setTargetWeightKg(double value) {
    targetWeightKg = value;
    notifyListeners();
  }

  set setWeightChangeRate(String value) {
    weightChangeRate = value;
    notifyListeners();
  }

  void resetState() {
    // Reset all relevant state variables
    userId = 0;
    username = '';
    name = '';
    email = '';
    gender = '';
    dateOfBirth = DateTime.now();
    height = 0;
    weight = 0;
    dietaryPreference = '';
    allergies = '';
    ethnicity = '';
    activityLevel = '';
    currentCaloriesPerDay = 0;
    weightGoal = '';
    targetWeightKg = 0;
    weightChangeRate = '0';
    // Reset other variables as needed
    notifyListeners();
  }

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

  double get bmi {
    if (height > 0) {
      return weight / ((height / 100) * (height / 100));
    } else {
      return 0;
    }
  }

  String get bmiCategory {
    double bmiValue = bmi;
    if (bmiValue < 18.5) {
      return 'Underweight';
    } else if (bmiValue < 24.9) {
      return 'Normal weight';
    } else if (bmiValue < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  double get weightLossGoal {
    // Assuming the target BMI is 22.9 for normal weight
    const double targetBmi = 22.9;
    if (height > 0) {
      double targetWeight = targetBmi * ((height / 100) * (height / 100));
      return weight - targetWeight;
    } else {
      return 0;
    }
  }

  double get eer {
    double pa = 1.0; // Default Physical Activity factor
    // Adjust PA based on activity level
    switch (activityLevel.toLowerCase()) {
      case 'sedentary':
        pa = 1.0;
        break;
      case 'low active':
        pa = 1.12;
        break;
      case 'active':
        pa = 1.27;
        break;
      case 'very active':
        pa = 1.45;
        break;
    }

    double heightInMeters = height / 100;
    int age = DateTime.now().year - dateOfBirth.year;

    if (gender.toLowerCase() == 'male') {
      return 662 -
          (9.53 * age) +
          pa * (15.91 * weight + 539.6 * heightInMeters);
    } else {
      return 354 - (6.91 * age) + pa * (9.36 * weight + 726 * heightInMeters);
    }
  }

  double get proteinPerDay {
    // Recommended daily protein intake: 0.8 grams per kilogram of body weight
    return weight * 0.8;
  }

  double weightLossRate = 0.5;

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

  void updateUserName(String newName) {
    name = newName;
    notifyListeners();
  }
}
