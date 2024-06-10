import 'package:flutter/material.dart';
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
    var appState = context.watch<MyAppState>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(appState.username,
      //       style: const TextStyle(color: Colors.blue, fontSize: 20)),
      // ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // profile picture
                    Center(
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
                    ),
                    //username
                    Center(
                      child: Text(appState.username,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          )),
                    ),
                    // account information
                    // name
                    TextFormField(
                      initialValue: appState.name,
                      enabled: _isEditing,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: _isEditing
                              ? null
                              : Colors
                                  .black, // Set color to black in non-editing mode
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          appState.name = value;
                        });
                      },
                    ),
                    // email
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: appState.email,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors
                              .black, // Set color to black in non-editing mode
                        ),
                      ),
                    ),
                    // const SizedBox(height: 16),
                    // Center(
                    //   child: Text('Health Information',
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         color: Colors.blue,
                    //       )),
                    // ),
                    const SizedBox(height: 16),
                    // sex
                    DropdownButtonFormField<String>(
                      value: appState.sex,
                      items: const [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                            value: 'Female', child: Text('Female')),
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
                    ),
                    const SizedBox(height: 16),
                    //
                    // date of birth
                    GestureDetector(
                      onTap: _isEditing ? _selectDateOfBirth : null,
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd')
                                .format(appState.dateOfBirth),
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
                            suffixIcon: _isEditing
                                ? const Icon(Icons.calendar_today)
                                : null,
                          ),
                        ),
                      ),
                    ),
                    //
                    // height
                    const SizedBox(height: 16),
                    Row(
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
                              DropdownMenuItem<bool>(
                                  value: true, child: Text('cm')),
                              DropdownMenuItem<bool>(
                                  value: false, child: Text('in')),
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
                    ),
                    //
                    // weight
                    const SizedBox(height: 16),
                    Row(
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
                    ),
                    const SizedBox(height: 16),

                    // dietary preference
                    DropdownButtonFormField<String>(
                      value: appState.vegetarian,
                      items: const [
                        DropdownMenuItem(
                            value: 'Vegetarian', child: Text('Vegetarian')),
                        DropdownMenuItem(
                            value: 'Non-Vegetarian',
                            child: Text('Non-Vegetarian')),
                      ],
                      onChanged: _isEditing
                          ? (value) {
                              setState(() {
                                appState.vegetarian = value!;
                              });
                            }
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Diartary Preference',
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
                    const SizedBox(height: 16),
                    _allergies(),
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

  Future<void> _fetchUsername() async {
    // Simulate fetching the username from a database
    // await Future.delayed(const Duration(seconds: 2));
    // setState(() {
    //   _username = 'John Doe';
    // });
  }

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
}
