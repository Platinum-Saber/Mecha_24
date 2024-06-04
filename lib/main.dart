import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutri Guide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 125, 167, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
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
    'Nutri Guide',
    'Plan Diet',
    'Calorie Diary',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.shade400, // Set the shadow color
        surfaceTintColor: Colors.white,
        // centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            _titles[_currentIndex],
          ),
        ),

        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       // Navigate back
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
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

class PlanDietPage extends StatelessWidget {
  const PlanDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Plan Diet')),
    );
  }
}

class CalorieDiaryPage extends StatelessWidget {
  const CalorieDiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Calorie Diary')),
    );
  }
}
