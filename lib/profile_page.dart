import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
// import 'assets.dart';
import 'main.dart';

class ProfilePageGenerator extends StatefulWidget {
  const ProfilePageGenerator({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageGenerator> {
  bool _isEditing = false;
  // @override
  // void initState() {
  //   super.initState();
  //   _fetchUsername();
  // }

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profilePicture(),
                    _usernameShow(),
                    _name(),
                    const SizedBox(height: 16),
                    _email(),
                    const SizedBox(height: 16),
                    _sex(),
                    const SizedBox(height: 16),
                    _dateOfBirth(),
                    const SizedBox(height: 16),
                    _height(),
                    const SizedBox(height: 16),
                    _weight(),
                    const SizedBox(height: 16),
                    _diataryPreference(),
                    const SizedBox(height: 16),
                    _allergies(),
                    const SizedBox(height: 16),
                    _srilankan(),
                    const SizedBox(height: 16),
                    _activityLevel(),
                    _currentCalorieIntake(),
                    const SizedBox(height: 16),
                    _needToLoseWeight(),
                    const SizedBox(height: 16),
                    _weightLossGoal(),
                    const SizedBox(height: 16),
                    _weightLossRate(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Positioned(
        bottom: 16.0,
        right: 16.0,
        child: FloatingActionButton(
          onPressed: _toggleEditMode,
          child: Icon(_isEditing ? Icons.done : Icons.edit),
        ),
      ),
    );
  }

  void _toggleEditMode() {
    setState(() {
      if (!_isEditing) {
        _saveProfile();
      }
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    // Save the profile changes here
    setState(() {
      _isEditing = false;
    });
  }

  // Future<void> _fetchUsername() async {
  // Fetch the username from the database
  // var username = await fetchUsername();
  // var appState = context.read<MyAppState>();
  // appState.username = username;
  // }

  void _selectDateOfBirth() {
    var appState = context.read<MyAppState>();
    showDatePicker(
      context: context,
      initialDate: appState.dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          appState.dateOfBirth = value;
        });
      }
    });
  }

  Widget _profilePicture() {
    var appState = context.read<MyAppState>();
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(appState.profilepic),
          ),
          if (_isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  appState.changeProfilePicture();
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _usernameShow() {
    var appState = context.read<MyAppState>();
    return Center(
      child: Text(appState.username,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 20,
          )),
    );
  }

  Widget _name() {
    var appState = context.read<MyAppState>();
    return TextFormField(
      initialValue: appState.name,
      enabled: _isEditing,
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(
          color: _isEditing
              ? null
              : Colors.black, // Set color to black in non-editing mode
        ),
      ),
      onChanged: (value) {
        setState(() {
          appState.name = value;
        });
      },
    );
  }

  Widget _email() {
    var appState = context.read<MyAppState>();
    return TextFormField(
      initialValue: appState.email,
      enabled: false,
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Colors.black, // Set color to black in non-editing mode
        ),
      ),
    );
  }

  Widget _sex() {
    var appState = context.read<MyAppState>();
    return DropdownButtonFormField<String>(
      value: appState.sex,
      items: const [
        DropdownMenuItem(value: 'Male', child: Text('Male')),
        DropdownMenuItem(value: 'Female', child: Text('Female')),
      ],
      onChanged: _isEditing
          ? (value) {
              setState(() {
                appState.sex = value!;
              });
            }
          : null,
      decoration: InputDecoration(
        labelText: 'Sex',
        labelStyle: TextStyle(
          color: _isEditing ? null : Colors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(95, 162, 159, 167),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _dateOfBirth() {
    var appState = context.read<MyAppState>();
    return GestureDetector(
      onTap: _isEditing ? _selectDateOfBirth : null,
      child: AbsorbPointer(
        child: TextFormField(
          controller: TextEditingController(
            text: DateFormat('yyyy-MM-dd').format(appState.dateOfBirth),
          ),
          enabled: _isEditing,
          style: TextStyle(
            color: _isEditing ? Colors.black : Colors.grey,
          ),
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            labelStyle: TextStyle(
              color: _isEditing ? null : Colors.black,
            ),
            suffixIcon: _isEditing ? const Icon(Icons.calendar_today) : null,
          ),
        ),
      ),
    );
  }

  Widget _height() {
    var appState = context.read<MyAppState>();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: appState.height.toStringAsFixed(2),
            enabled: _isEditing,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Height',
              labelStyle: TextStyle(
                color: _isEditing ? null : Colors.black,
              ),
            ),
            onChanged: (value) {
              setState(() {
                appState.height = double.parse(value);
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        IntrinsicWidth(
          child: DropdownButtonFormField<bool>(
            value: appState.heightInCm,
            // enabled: _isEditing,
            items: const [
              DropdownMenuItem<bool>(value: true, child: Text('cm')),
              DropdownMenuItem<bool>(value: false, child: Text('in')),
            ],
            onChanged: _isEditing
                ? (value) {
                    if (value != null) {
                      setState(() {
                        appState.heightInCm = value;
                      });
                    }
                  }
                : null,
            decoration: InputDecoration(
              labelText: 'Unit',
              labelStyle: TextStyle(
                color: _isEditing ? null : Colors.black,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(95, 162, 159, 167),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _weight() {
    var appState = context.read<MyAppState>();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: appState.weight.toStringAsFixed(2),
            enabled: _isEditing,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Weight in kg',
              labelStyle: TextStyle(
                color: _isEditing ? null : Colors.black,
              ),
            ),
            onChanged: (value) {
              setState(() {
                appState.weight = double.parse(value);
              });
            },
          ),
        ),
        // const SizedBox(width: 8),
        // const Text('kg'),
      ],
    );
  }

  Widget _diataryPreference() {
    var appState = context.read<MyAppState>();
    return DropdownButtonFormField<String>(
      value: appState.vegetarian,
      items: const [
        DropdownMenuItem(value: 'Vegetarian', child: Text('Vegetarian')),
        DropdownMenuItem(
            value: 'Non Vegetarian', child: Text('Non Vegetarian')),
        DropdownMenuItem(value: 'Vegan', child: Text('Vegan')),
      ],
      onChanged: _isEditing
          ? (value) {
              setState(() {
                appState.vegetarian = value!;
              });
            }
          : null,
      decoration: InputDecoration(
        labelText: 'Dietary Preference',
        labelStyle: TextStyle(
          color: _isEditing ? null : Colors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(95, 162, 159, 167),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _allergies() {
    var appState = context.read<MyAppState>();
    return TextFormField(
      initialValue: appState.allergies,
      enabled: _isEditing,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Do you have any allergies?',
        labelStyle: TextStyle(
          color: _isEditing ? null : Colors.black,
        ),
      ),
      onChanged: (value) {
        setState(() {
          appState.allergies = value;
        });
      },
    );
  }

  Widget _srilankan() {
    var appState = context.read<MyAppState>();
    return DropdownButtonFormField<String>(
      value: appState.srilankan.toString(),
      items: const [
        DropdownMenuItem(value: 'Sri Lankan', child: Text('Sri Lankan')),
        DropdownMenuItem(value: 'South Asian', child: Text('South Asian')),
        DropdownMenuItem(value: 'Asian', child: Text('Asian')),
        DropdownMenuItem(value: 'Non Asian', child: Text('Non Asian')),
      ],
      onChanged: _isEditing
          ? (value) {
              setState(() {
                appState.srilankan = value!;
              });
            }
          : null,
      decoration: InputDecoration(
        labelText: 'Are you Sri Lankan by descent?',
        labelStyle: TextStyle(
          color: _isEditing ? null : Colors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(95, 162, 159, 167),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _activityLevel() {
    var appState = context.read<MyAppState>();
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: appState.activityLevel,
          items: const [
            DropdownMenuItem(value: 'Light', child: Text('Light')),
            DropdownMenuItem(value: 'Moderate', child: Text('Moderate')),
            DropdownMenuItem(value: 'Active', child: Text('Active')),
            DropdownMenuItem(value: 'Very Active', child: Text('Very Active')),
          ],
          onChanged: _isEditing
              ? (value) {
                  setState(() {
                    appState.activityLevel = value!;
                  });
                }
              : null,
          decoration: InputDecoration(
            labelText: 'What is your general activity level?',
            labelStyle: TextStyle(
              color: _isEditing ? null : Colors.black,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(95, 162, 159, 167),
                width: 1,
              ),
            ),
          ),
        ),
        const ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text('Activity Level Description',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          children: [
            Text(
                'Light: light physical activity associated with independent living.\nModerate: light + half an hour of moderate to vigorous exercise per day.\nActive: at least one hour of exercise per day.\nVery Active: physically active for several hours each day.'),
          ],
        ),
      ],
    );
  }

  Widget _currentCalorieIntake() {
    var appState = context.read<MyAppState>();
    return TextFormField(
      initialValue: appState.currentCalorieIntake.toStringAsFixed(2),
      enabled: _isEditing,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'What is your current calorie intake per day?',
        labelStyle: TextStyle(
          color: _isEditing ? null : Colors.black,
        ),
      ),
      onChanged: (value) {
        setState(() {
          appState.currentCalorieIntake = int.parse(value);
        });
      },
    );
  }

  Widget _needToLoseWeight() {
    var appState = context.read<MyAppState>();
    return DropdownButtonFormField<bool>(
      value: appState.maintainWeight,
      // enabled: _isEditing,
      items: const [
        DropdownMenuItem<bool>(value: true, child: Text('Lose Weight')),
        DropdownMenuItem<bool>(value: false, child: Text('Maintain Weight')),
      ],
      onChanged: _isEditing
          ? (value) {
              if (value != null) {
                setState(() {
                  appState.maintainWeight = value;
                });
              }
            }
          : null,
      decoration: InputDecoration(
        labelText: 'Do you need to maintain your weight or lose weight?',
        labelStyle: TextStyle(
          color: _isEditing ? null : Colors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(95, 162, 159, 167),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _weightLossGoal() {
    var appState = context.read<MyAppState>();
    return TextFormField(
      initialValue: appState.weightLossGoal.toStringAsFixed(2),
      enabled: _isEditing,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'If yes, how much weight you want to lose?',
        labelStyle: TextStyle(
          color: _isEditing ? null : Colors.black,
        ),
      ),
      onChanged: (value) {
        setState(() {
          appState.weightLossGoal = int.parse(value);
        });
      },
    );
  }

  Widget _weightLossRate() {
    var appState = context.read<MyAppState>();
    return DropdownButtonFormField<double>(
      value: appState.weightLossRate.toDouble(),
      items: const [
        DropdownMenuItem(value: 200, child: Text('200g per week')),
        DropdownMenuItem(value: 500, child: Text('500g per week')),
        DropdownMenuItem(value: 750, child: Text('750g per week')),
        DropdownMenuItem(value: 1000, child: Text('1kg per week')),
      ],
      onChanged: _isEditing
          ? (value) {
              setState(() {
                appState.weightLossRate = value!.toInt();
              });
            }
          : null,
      decoration: InputDecoration(
        labelText: 'Prefered rate of weight loss',
        labelStyle: TextStyle(
          color: _isEditing ? null : Colors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(95, 162, 159, 167),
            width: 1,
          ),
        ),
      ),
    );
  }
}
