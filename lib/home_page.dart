import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'assets.dart';
import 'main.dart';

class HomePageGenerator extends StatelessWidget {
  const HomePageGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
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
                Text('hello, ${appState.name}!',
                    style: const TextStyle(fontSize: 24, color: Colors.grey)),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDonutProgress(appState.total, appState.recCal,
                        Colors.blue, Colors.grey.shade100),
                    const SizedBox(width: 16.0),
                    Text('achieved of ${appState.recCal} kCal Goal',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
                // _showCalorieIntake(appState),
                const SizedBox(height: 8.0),
                _chooseMeal(),
                const SizedBox(height: 24.0),
                const Text(
                  'Stats',
                  style: const TextStyle(fontSize: 24, color: Colors.grey),
                ),
                _showStats(appState),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDonutProgress(total, goal, Color color, Color backgroundColor) {
    double value = double.parse(total) / double.parse(goal);
    return Stack(
      alignment: Alignment.center,
      children: [
        // Column(children: [
        //   Text(
        //     '${total}/${goal}',
        //     style: TextStyle(fontSize: 18),
        //   ),
        //   Text('kCal'),
        // ]),
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

  Widget _chooseMeal() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text('Choose your meal!',
        //     style: TextStyle(fontSize: 18, color: Colors.grey)),
        const SizedBox(height: 20.0),
        ChooseMealButton(
          buttonText: 'Breakfast',
          onPressed: () {},
          colorScheme: 'blue',
        ),
        const SizedBox(height: 20.0),
        ChooseMealButton(
          buttonText: 'Morning Snack',
          onPressed: () {},
          colorScheme: 'green',
        ),
        const SizedBox(height: 20.0),
        ChooseMealButton(
          buttonText: 'Lunch',
          onPressed: () {},
          colorScheme: 'blue',
        ),
        const SizedBox(height: 20.0),
        ChooseMealButton(
          buttonText: 'Evening Snack',
          onPressed: () {},
          colorScheme: 'green',
        ),
        const SizedBox(height: 20.0),
        ChooseMealButton(
          buttonText: 'Dinner',
          onPressed: () {},
          colorScheme: 'blue',
        ),
      ],
    );
  }

  Widget _showStats(apps) {
    return Column(
      children: [
        Card.outlined(
          // color: Colors.grey.shade100,
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progress during past 30 days',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                _plotWeightLoss(), //graph
              ],
            ),
          ),
        ),
        Card.outlined(
          child: ExpansionTile(
            // collapsedBackgroundColor: Colors.blue.shade100,
            title: Text('BMI ${apps.bmi}',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                )),
            children: [
              Container(
                width: 400,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    'BMI represents how much you weigh for your given height.\n\nSince your Asian by descent your BMI shows that you are ${apps.bmiCategory}.\n\nYou have to lose a minimum of ${apps.weightToLose} kg to achieve a normal BMI. \n\nminimum is calculated by 22.9 x height^2 according to current guidlines.'),
              ),
            ],
          ),
        ),
        Card.outlined(
          child: ExpansionTile(
            // collapsedBackgroundColor: Colors.blue.shade100,
            title: Text('EER ${apps.eer} kCal/day',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                )),
            children: [
              Container(
                width: 400,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    'EER is your Estimated Energy Requirements per day.\n\nProtein requirements should be around ${apps.protienPerDay} grams per day'),
              ),
            ],
          ),
        ),
        Card.outlined(
          child: ExpansionTile(
            // collapsedBackgroundColor: Colors.blue.shade100,
            title: Text('Goal ${apps.weightLossGoal} kg',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                )),
            children: [
              Container(
                width: 400,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    'Your goal is to lose ${apps.weightLossGoal} kg.\n\nThis is a healthy goal and can be achieved by losing 0.5 kg per week.\n\nThis will help you maintain a healthy lifestyle and keep you fit.'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _plotWeightLoss() {
    return Container(
      height: 200,
      width: 400,
      child: Placeholder(
        color: Colors.grey, //put the graph here
      ),
    );
  }

  Widget _showCalorieIntake(apps) {
    var appState = apps;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _calorieCard('Today', appState.total, 'green'),
        _calorieCard('Goal', appState.recCal, 'blue'),
      ],
    );
  }

  Widget _calorieCard(topicT, totalT, colorScheme) {
    var topicText = topicT;
    var totalText = totalT;

    Color bgcolor;
    Color fgcolor;

    if (colorScheme == 'blue') {
      bgcolor = const Color.fromRGBO(235, 242, 255, 1);
      fgcolor = const Color.fromRGBO(53, 122, 246, 1);
    } else if (colorScheme == 'green') {
      bgcolor = const Color.fromRGBO(231, 248, 247, 1);
      fgcolor = const Color.fromRGBO(13, 177, 173, 1);
    } else {
      // Handle other color schemes or set default values
      bgcolor = Colors.grey.shade100;
      fgcolor = Colors.black;
    }

    return Card.outlined(
      // borderOnForeground: true,
      // color: bgcolor,
      shadowColor: bgcolor,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        // width: 180,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${topicText}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            // const SizedBox(height: 20.0),
            Text('${totalText} kCal',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}
