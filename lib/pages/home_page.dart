import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hello,', style: TextStyle(fontSize: 30)),
              Text('Helena!',
                  style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold)), // add name from database.

              const SizedBox(height: 16.0),

              const Text('Choose your meal!',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the first screen
                  // Navigator.pushNamed(context, '/first');
                },
                child: const Text('Breakfast', style: TextStyle(fontSize: 24)),
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  // Navigator.pushNamed(context, '/second');
                },
                child:
                    const Text('Morning Snack', style: TextStyle(fontSize: 24)),
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  // Navigator.pushNamed(context, '/second');
                },
                child: const Text('Lunch', style: TextStyle(fontSize: 24)),
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  // Navigator.pushNamed(context, '/second');
                },
                child:
                    const Text('Evening Snack', style: TextStyle(fontSize: 24)),
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  // Navigator.pushNamed(context, '/second');
                },
                child: const Text('Dinner', style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
