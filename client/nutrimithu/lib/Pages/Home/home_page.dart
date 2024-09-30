// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Resources/assets.dart';
import '../../App/app.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../Resources/image_preloader.dart';
import '../../App/my_home_page.dart';
import 'dart:ui';

class HomePageGenerator extends StatefulWidget {
  const HomePageGenerator({super.key});

  @override
  State<HomePageGenerator> createState() => _HomePageGeneratorState();
}

class _HomePageGeneratorState extends State<HomePageGenerator> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImages();
  }

  Future<void> _preloadImages() async {
    await ImagePreloader.preloadImages(context);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset(
          'assets/bg.png',
          fit: BoxFit.cover,
          // height: 120,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'hello, ${appState.name}!',
                    style: const TextStyle(fontSize: 24, color: Colors.black54),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      // color: const Color.fromRGBO(200, 230, 201, 0.5),
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    // color: Colors.green.shade100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildDonutProgress(
                          appState.total,
                          appState.recCal,
                          Colors.blue,
                          Colors.grey.shade100,
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          'achieved of ${appState.recCal} kCal Goal',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // my meals container
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'My Meals',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          _chooseMeal(context),
                        ],
                      )),
                  const SizedBox(height: 16.0),
                  // my stats container
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'My Stats',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          _showStats(appState),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildDonutProgress(
      String total, String goal, Color color, Color backgroundColor) {
    double value = double.parse(total) / double.parse(goal);
    return Stack(
      alignment: Alignment.center,
      children: [
        Text('${(value * 100).round()}%', style: const TextStyle(fontSize: 18)),
        SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 10,
            color: color,
            backgroundColor: backgroundColor,
          ),
        ),
      ],
    );
  }

  Widget _chooseMeal(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        ChooseMealButton(
          buttonText: 'Breakfast',
          colorScheme: 'green',
          mealIndex: 0,
        ),
        SizedBox(height: 8.0),
        ChooseMealButton(
          buttonText: 'Morning Snack',
          colorScheme: 'green',
          mealIndex: 1,
        ),
        SizedBox(height: 8.0),
        ChooseMealButton(
          buttonText: 'Lunch',
          colorScheme: 'green',
          mealIndex: 2,
        ),
        SizedBox(height: 8.0),
        ChooseMealButton(
          buttonText: 'Evening Snack',
          colorScheme: 'green',
          mealIndex: 3,
        ),
        SizedBox(height: 8.0),
        ChooseMealButton(
          buttonText: 'Dinner',
          colorScheme: 'green',
          mealIndex: 4,
        ),
      ],
    );
  }

  Widget _showStats(MyAppState appState) {
    return Column(
      children: [
        // Card.outlined(
        //   child: Container(
        //     width: 400,
        //     padding: const EdgeInsets.all(16.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const Text(
        //           'Progress during past 30 days',
        //           style: TextStyle(
        //             color: Colors.grey,
        //             fontSize: 18,
        //           ),
        //         ),
        //         _plotWeightLoss(),
        //       ],
        //     ),
        //   ),
        // ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ExpansionTile(
            // collapsedBackgroundColor: Colors.green[50],
            title: Text(
              'BMI = ${appState.bmi.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            // backgroundColor: Colors.lightGreen.shade100,
            children: [
              Container(
                width: 400,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'BMI represents how much you weigh for your given height.\n\nSince your Asian by descent your BMI shows that you are ${appState.bmiCategory}.\n\nYou have to lose a minimum of ${appState.weightLossGoal.toStringAsFixed(2)} kg to achieve a normal BMI. \n\nminimum is calculated by 22.9 x height^2 according to current guidlines.',
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ExpansionTile(
            // collapsedBackgroundColor: Colors.green[50],
            title: Text(
              'Estimated Energy Requirement = ${appState.eer.round()} Cal/day',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            children: [
              Container(
                width: 400,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'EER is your Estimated Energy Requirements per day.\n\nProtein requirements should be around ${appState.proteinPerDay.round()} grams per day',
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // borderOnForeground: false,
          child: ExpansionTile(
            // collapsedBackgroundColor: Colors.green[50],
            title: Text(
              'Weight Goal = ${appState.weightLossGoal.toStringAsFixed(2)} kg',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            children: [
              Container(
                width: 400,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your goal is to lose ${appState.weightLossGoal.toStringAsFixed(2)} kg.\n\nThis is a healthy goal and can be achieved by losing ${appState.weightLossRate} kg per week.\n\nThis will help you maintain a healthy lifestyle and keep you fit.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _plotWeightLoss() {
    return const SizedBox(
      height: 200,
      width: 400,
      child: Placeholder(
        color: Colors.grey,
      ),
    );
  }
}

class ChooseMealButton extends StatelessWidget {
  final String buttonText;
  final String colorScheme;
  final int mealIndex;

  const ChooseMealButton({
    super.key,
    required this.buttonText,
    required this.colorScheme,
    required this.mealIndex,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Color bgcolor;
    Color fgcolor;
    if (colorScheme == 'blue') {
      bgcolor = const Color.fromRGBO(235, 242, 255, 1);
      fgcolor = const Color.fromRGBO(53, 122, 246, 1);
    } else if (colorScheme == 'green') {
      // bgcolor = const Color.fromRGBO(231, 248, 247, 1);
      // fgcolor = const Color.fromRGBO(13, 177, 173, 1);
      bgcolor = Colors.grey.shade200;
      fgcolor = Colors.green;
    } else {
      // Handle other color schemes or set default values
      bgcolor = Colors.white;
      fgcolor = Colors.black;
    }

    return ElevatedButton(
      onPressed: () {
        appState.mealToPack = buttonText;
        appState.mealIndex = mealIndex;
        appState.foodItemIndex = 0;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PackMyMealPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor,
        foregroundColor: fgcolor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        minimumSize: const Size(400, 60), //////// HERE
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 28,
        ),
      ),
    );
  }
}

class PackMyMealPageGenerator extends StatefulWidget {
  const PackMyMealPageGenerator({super.key});

  @override
  PackMyMealPageState createState() => PackMyMealPageState();
}

class PackMyMealPageState extends State<PackMyMealPageGenerator> {
  bool _isEditing = false;
  // final bool _isNutriScale = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: CustomAppBar(
        title: appState.mealToPack,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            // margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _editCalories(appState),
                _showDividers(appState),
                _showScale(appState),
                // _isNutriScale ? _showScale(appState) : _showDividers(appState),
                const SizedBox(height: 16.0),
                _confirmationButton(appState),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editCalories(apps) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: apps.mealCals[apps.mealIndex].toString(),
            enabled: _isEditing,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8.0),
              suffixText: 'kCal',
            ),
            onChanged: (value) {
              setState(() {
                apps.mealCals[apps.mealIndex] = double.parse(value);
              });
            },
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
          highlightElevation: 0,
          onPressed: () {
            setState(() {
              _isEditing = !_isEditing;
            });
          },
          // disabledElevation: 0,
          child: Icon(_isEditing ? Icons.done : Icons.edit),
        ),
      ],
    );
  }

  Widget _showFoodBox(apps) {
    //remove hardcode these to get actual data
    final food = apps.mealItems[apps.mealIndex];
    Map<String, double> dataMap = {
      food[0]: 1,
      food[1]: 1,
      food[2]: 1,
      food[3]: 1,
    };

    final colorList = <Color>[
      Colors.yellow,
      Colors.pinkAccent,
      Colors.green,
      Colors.lightGreen,
    ];

    return PieChart(
      dataMap: dataMap,
      // animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 1.5,
      colorList: colorList,
      initialAngleInDegree: -90,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      // centerText: "HYBRID",

      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        // legendTextStyle: TextStyle(
        //   fontWeight: FontWeight.bold,
        // ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: false,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
      ),
    );
  }

  Widget _showDividers(apps) {
    return Card.outlined(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16.0),
        child: (apps.mealIndex == 1 || apps.mealIndex == 3)
            ? Text('Nutri Box not needed.')
            : Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Use the following dividers!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  _showFoodBox(apps),
                ],
              ),
      ),
    );
  }

  Widget _confirmationButton(apps) {
    return Center(
      child: TextButton(
        onPressed: () {
          apps.mealsCompleted[apps.mealIndex] =
              true; //meals completed not mentioned in appstate
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.green.shade100,
          foregroundColor: Colors.green.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Text('Completed ${apps.mealToPack}!'),
      ),
    );
  }

  Widget _showScale(MyAppState apps) {
    return BreakfastItemsWidget(
      // meal: apps.mealIndex,
      items: apps
          .mealItems[apps.mealIndex], //this should be the actual value needed.
      // items: ['rice', 'dhal', 'carrot', 'spinnach'],
      currentIndex: apps.foodItemIndex,
      onPrevious: () {
        setState(() {
          apps.foodItemIndex = (apps.foodItemIndex - 1) %
              4; // 4 is the length of appState.breakfast. alter it for variable lengths.
        });
      },
      onNext: () {
        setState(() {
          apps.foodItemIndex = (apps.foodItemIndex + 1) % 4;
        });
      },
    );
  }
}

class BreakfastItemsWidget extends StatefulWidget {
  final List<String> items;
  final int currentIndex;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  // final VoidCallback meal;

  const BreakfastItemsWidget({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onPrevious,
    required this.onNext,
    // required this.meal,
  });

  @override
  _BreakfastItemsWidgetState createState() => _BreakfastItemsWidgetState();
}

class _BreakfastItemsWidgetState extends State<BreakfastItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Start serving your meal!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 200,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed:
                        widget.currentIndex > 0 ? widget.onPrevious : null,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.items[widget.currentIndex],
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: widget.currentIndex < widget.items.length - 1
                        ? widget.onNext
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
