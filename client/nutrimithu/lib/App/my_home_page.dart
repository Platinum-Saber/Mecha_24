import 'package:flutter/material.dart';
import 'package:nutrimithu/Authentication/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages/Home/home_page.dart';
import '../Pages/Profile/profile_page.dart';
import '../Pages/plan_diet/plan_diet_page.dart';
import '../Pages/calorie_diary/calorieDiary_page.dart';
import 'app.dart';

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

  void _handleLogout() async {
    try {
      // Clear user data from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      // Reset the app state
      Provider.of<MyAppState>(context, listen: false).resetState();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error during logout: $e');
      // Handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        shadowColor: Colors.grey.shade400, // Set the shadow color
        surfaceTintColor: Colors.white,

        title: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          height: 120,
        ),

        centerTitle: true,
        // title: Text(_titles[_currentIndex],
        //     style: const TextStyle(color: Colors.grey)),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 4) {
            _handleLogout();
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        selectedItemColor: Colors.green.shade800,

        // selectedItemColor: const Color.fromARGB(
        // 255, 125, 167, 255), // Set the color for selected items
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
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
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
