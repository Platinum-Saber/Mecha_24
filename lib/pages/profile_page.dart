import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;
  String _name = 'Helena Hills'; //get from database
  String _email = 'name@domain.com'; //get from database
  String _username = '@helenahills'; //get from database
  String _sex = 'Male'; //get from database
  DateTime _dateOfBirth = DateTime(1990, 1, 1);
  double _height = 170.0;
  bool _heightInCm = true;
  final _profilepic = ''; //get from database

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_username, style: const TextStyle(color: Colors.grey)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(_profilepic),
                          ),
                          if (_isEditing)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt),
                                onPressed: _changeProfilePicture,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _name,
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
                        _name = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _email,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors
                              .black, // Set color to black in non-editing mode
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Health Information',
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _sex,
                      // enabled: _isEditing,
                      items: const [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                            value: 'Female', child: Text('Female')),
                      ],
                      onChanged: _isEditing
                          ? (value) {
                              setState(() {
                                _sex = value!;
                              });
                            }
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Sex',
                        labelStyle: TextStyle(
                          color: _isEditing ? null : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _isEditing ? _selectDateOfBirth : null,
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd').format(_dateOfBirth),
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: _heightInCm
                                ? _height.toStringAsFixed(2)
                                : (_height / 2.54).toStringAsFixed(2),
                            // ? '${_height.toInt()} cm'
                            // : '${(_height * 0.393701).toInt()} in',
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
                                _height = double.parse(value);
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        // if (_isEditing)
                        DropdownButton<bool>(
                          value: _heightInCm,
                          items: const [
                            DropdownMenuItem(
                              value: true,
                              child: Text('cm'),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text('inches'),
                            ),
                          ],
                          onChanged: _isEditing
                              ? (value) {
                                  setState(() {
                                    _heightInCm = value!;
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
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
        // Save the changes before exiting edit mode
        _saveProfile();
      }
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    // Save the profile changes here
    setState(() {
      _dateOfBirth = _dateOfBirth;
      _height = _height;
      _heightInCm = _heightInCm;
      // _isEditing = false;
    });
  }

  void _changeProfilePicture() {
    // Implement logic to change the profile picture
  }

  Future<void> _fetchUsername() async {
    // Simulate fetching the username from a database
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _username = 'John Doe';
    });
  }

  void _selectDateOfBirth() {
    showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateOfBirth = value;
        });
      }
    });
  }
}
