import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutri Guide',
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const MyHomePage(title: 'My Home'),
      //   '/plan-diet': (context) => const MyHomePage(title: 'Plan Diet'),
      //   // '/calorie-diary': (context) => const MyHomePage(title: 'Calorie Diary'),
      //   // '/profile': (context) => const MyHomePage(title: 'Profile'),
      // },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 125, 167, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // title: Text(widget.title),
        elevation: 2.0,
        shadowColor: Colors.grey.shade400, // Set the shadow color
        surfaceTintColor: Colors.white,

        title: Center(
          child: Text(widget.title),
        ),

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back
              Navigator.of(context).pop();
            },
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigator.pushReplacementNamed(
                // context, '/'); // Navigate to home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Plan Diet'),
              onTap: () {
                // Navigate to home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Calorie Diary'),
              onTap: () {
                // Navigate to home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                // Navigate to settings screen
              },
            ), // Drawer items go here
          ],
        ),
      ),

      body: Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello,', style: TextStyle(fontSize: 30)),
              Text('Helena!',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold)), // add name from database.

              SizedBox(height: 16.0),

              Text('Choose your meal!',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),

              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the first screen
                  // Navigator.pushNamed(context, '/first');
                },
                child: Text('Breakfast', style: TextStyle(fontSize: 24)),
              ),

              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  // Navigator.pushNamed(context, '/second');
                },
                child: Text('Morning Snack', style: TextStyle(fontSize: 24)),
              ),

              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  // Navigator.pushNamed(context, '/second');
                },
                child: Text('Lunch', style: TextStyle(fontSize: 24)),
              ),

              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  // Navigator.pushNamed(context, '/second');
                },
                child: Text('Evening Snack', style: TextStyle(fontSize: 24)),
              ),

              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  // Navigator.pushNamed(context, '/second');
                },
                child: Text('Dinner', style: TextStyle(fontSize: 24)),
              ),

              SizedBox(height: 32.0),

              Text('Want to change?',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),

              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Navigate to the second screen
              //       // Navigator.pushNamed(context, '/second');
              //     },
              //     child: Text('Change Meal Plan'),
              //   ),
              // ),
              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  // Navigator.pushNamed(context, '/second');
                },
                child: Text('Change Meal Plan', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),

        // ),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        // child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.

        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).

        // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        // action in the IDE, or press "p" in the console), to see the
        // wireframe for each widget.
        // mainAxisAlignment: MainAxisAlignment.start,
        // children: <Widget>[
        //   const Text(
        //     'Hello,',
        //   ),
        //   Text(
        //     'Helena!', // add name from database.
        //     // '$_counter',
        //     // style: Theme.of(context).textTheme.headlineMedium,
        //   ),
        // ],
      ),
      // ),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: _incrementCounter,
      //     tooltip: 'Increment',
      //     child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
