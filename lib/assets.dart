import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';

// class

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final String image;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/$image.jpg'), // Replace with your image
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: 300, // Replace with your desired width
          height: 100, // Replace with your desired height
          alignment: Alignment.center,
          child: Text(buttonText),
        ),
      ),
    );
  }
}

class UnitButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool pressed;

  const UnitButtons({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (pressed) {
              return Colors.lightBlue.shade400;
            } else {
              return const Color(0xffF0F0F2); // The default color
            }
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (pressed) {
              return Colors.white; // Text color when button is pressed
            } else {
              return Colors.black; // Default text color
            }
          },
        ),
      ),
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}

class CustomSmallButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool pressed;
  final IconData buttonIcon;

  const CustomSmallButtons({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.pressed,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (pressed) {
              return Colors.lightBlue.shade400;
            } else {
              return const Color(0xffF0F0F2); // The default color
            }
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (pressed) {
              return Colors.white; // Text color when button is pressed
            } else {
              return Colors.black; // Default text color
            }
          },
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(buttonText),
          const SizedBox(
              width:
                  4.0), // You can adjust the space between the text and the icon
          Icon(buttonIcon),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      // title: Center(
      //     child: Text(
      //   title,
      //   style: const TextStyle(fontWeight: FontWeight.bold),
      // )),
      leading: BackButton(),
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back),
      //   onPressed: () {
      //     if (Navigator.canPop(context)) {
      //       Navigator.pop(context);
      //     }
      //   },
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BigCard extends StatelessWidget {
  final String text_;

  const BigCard({super.key, required this.text_});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style1 = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
    );

    return Card(
      color: const Color(0xffF0F0F2),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text_,
          style: style1,
        ),
      ),
    );
  }
}

class SmallCard extends StatelessWidget {
  final String text_;
  final VoidCallback onPressed;

  const SmallCard({
    super.key,
    required this.text_,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style1 = theme.textTheme.displaySmall!
        .copyWith(color: theme.colorScheme.primary, fontSize: 16.0);

    return ListTile(
      title: Text(
        text_,
        style: style1,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.close),
        onPressed: onPressed,
      ),
    );
  }
}

class CustomTextFormFieldRow extends StatelessWidget {
  final String placeholder;
  final String prefixText;
  final ValueChanged<String> onChanged;

  const CustomTextFormFieldRow({
    super.key,
    required this.placeholder,
    required this.prefixText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Change this to your desired color
        border: Border.all(
            color: Colors.grey,
            width: 1), // Change border color and width as needed
        borderRadius: BorderRadius.circular(
            10), // Change this to your desired border radius
      ),
      child: CupertinoTextFormFieldRow(
        padding: const EdgeInsets.all(36),
        prefix: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(prefixText, style: const TextStyle(fontSize: 24)),
        ),
        keyboardType: TextInputType.number,
        placeholder: placeholder,
        onChanged: onChanged,
      ),
    );
  }
}

class CustomTextInputBox extends StatelessWidget {
  final String placeholder;
  final String prefixText;
  final double? fontSize1;
  final ValueChanged<String> onChanged;

  const CustomTextInputBox({
    super.key,
    required this.placeholder,
    required this.prefixText,
    required this.fontSize1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            prefixText,
            style: TextStyle(fontSize: fontSize1, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: Colors.lightBlue[50], // light blue color
              filled: true,
              labelText: placeholder,
            ),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}

class CustomDropDownBox extends StatefulWidget {
  final String placeholder;
  final String prefixText;
  final List<String> suggestions;
  final ValueChanged<String> onChanged;
  final Set<String> mealItems;

  const CustomDropDownBox({
    super.key,
    required this.placeholder,
    required this.prefixText,
    required this.suggestions,
    required this.onChanged,
    required this.mealItems,
  });

  @override
  _CustomDropDownBoxState createState() => _CustomDropDownBoxState();
}

class _CustomDropDownBoxState extends State<CustomDropDownBox> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.prefixText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return widget.suggestions;
                }
                return widget.suggestions.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                _controller.text = selection;
                widget.onChanged(selection);
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.lightBlue[50], // light blue color
                    filled: true,
                    labelText: widget.placeholder,
                  ),
                  onChanged: widget.onChanged,
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          // Step 2: Create an add button
          child: const Text('Add'),
          onPressed: () {
            setState(() {
              if (_controller.text != '') {
                widget.mealItems.add(_controller.text);
                _controller.clear();
              }
            });
            _controller.clear(); // Clear the text field
          },
        ),
      ],
    );
  }
}

class CustomCalendar extends StatefulWidget {
  final Function(DateTime, DateTime) onDaySelected;

  const CustomCalendar({super.key, required this.onDaySelected});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        widget.onDaySelected(selectedDay, focusedDay);
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.blue[600],
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.blue[200],
          shape: BoxShape.circle,
        ),
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.red[0],
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        formatButtonShowsNext: false,
        formatButtonDecoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5.0),
        ),
        formatButtonTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class CustomExpandingWidget extends StatefulWidget {
  final String listTitle;
  final List<String> suggestions;
  final ValueChanged<String> onChanged;
  final String units;
  final ValueNotifier<double> amount;
  final Set<String> mealItems;

  const CustomExpandingWidget(
      {super.key,
      required this.listTitle,
      required this.suggestions,
      required this.onChanged,
      required this.units,
      required this.amount,
      required this.mealItems});

  @override
  _CustomExpandingWidget createState() => _CustomExpandingWidget();
}

class _CustomExpandingWidget extends State<CustomExpandingWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: ListTile(
                    title: Text(widget.listTitle),
                    trailing: ValueListenableBuilder<double>(
                      valueListenable: widget.amount,
                      builder: (context, value, child) {
                        return Text(value.toString());
                      },
                    ),
                  ),
                );
              },
              body: Container(
                color: Colors.grey[100],
                child: Column(
                  children: <Widget>[
                    CustomTextInputBox(
                        placeholder: widget.units,
                        prefixText: 'Total Amount',
                        fontSize1: 18,
                        onChanged: (value) {
                          setState(() {
                            widget.amount.value = double.parse(value);
                          });
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomDropDownBox(
                      placeholder: 'choose item',
                      prefixText: 'Food Item          ',
                      suggestions: widget.suggestions,
                      onChanged: widget.onChanged,
                      mealItems: widget.mealItems,
                    ),
                    ...widget.mealItems.map(
                      (item) => SmallCard(
                        text_: item,
                        onPressed: () {
                          setState(() {
                            widget.mealItems.remove(item);
                            print(widget.mealItems);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              isExpanded: _isExpanded,
            ),
          ],
        );
      },
    );
  }
}
