import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../App/app.dart';

class FirstTimeLoginPage extends StatefulWidget {
  final String userId;

  const FirstTimeLoginPage({Key? key, required this.userId}) : super(key: key);

  @override
  _FirstTimeLoginPageState createState() => _FirstTimeLoginPageState();
}

class _FirstTimeLoginPageState extends State<FirstTimeLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _profileData = {
    'gender': null,
    'date_of_birth': null,
    'height_cm': null,
    'weight_kg': null,
    'dietary_preference': null,
    'allergies': '',
    'ethnicity': null,
    'activity_level': null,
    'current_calories_per_day': null,
    'weight_goal': null,
    'target_weight_kg': null,
    'weight_change_rate': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Your Profile')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDropdownField(
                  'gender', 'Gender', ['male', 'female', 'other']),
              _buildDateField('date_of_birth', 'Date of Birth'),
              _buildNumberField('height_cm', 'Height (cm)'),
              _buildNumberField('weight_kg', 'Weight (kg)'),
              _buildDropdownField('dietary_preference', 'Dietary Preference',
                  ['vegetarian', 'non_vegetarian', 'vegan']),
              _buildTextField('allergies', 'Allergies'),
              _buildDropdownField('ethnicity', 'Ethnicity',
                  ['sri_lankan', 'south_asian', 'asian', 'non_asian']),
              _buildDropdownField('activity_level', 'Activity Level',
                  ['light', 'moderate', 'active', 'very_active']),
              _buildNumberField(
                  'current_calories_per_day', 'Current Daily Calories'),
              _buildDropdownField(
                  'weight_goal', 'Weight Goal', ['maintain', 'lose', 'gain']),
              _buildNumberField('target_weight_kg', 'Target Weight (kg)'),
              _buildDropdownField('weight_change_rate', 'Weight Change Rate',
                  ['0', '200', '400', '600', '800']),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String key, String label, List<String> items) {
    return DropdownButtonFormField<String>(
      value: _profileData[key],
      decoration: InputDecoration(labelText: label),
      items: [
        const DropdownMenuItem<String>(
            value: null, child: Text('Please select')),
        ...items.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }),
      ],
      onChanged: (String? newValue) {
        setState(() => _profileData[key] = newValue);
      },
      validator: (value) => value == null ? 'Please select a value' : null,
    );
  }

  Widget _buildDateField(String key, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() => _profileData[key] = picked.toIso8601String());
        }
      },
      controller: TextEditingController(
        text: _profileData[key] != null
            ? DateFormat('yyyy-MM-dd').format(DateTime.parse(_profileData[key]))
            : '',
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select a date' : null,
    );
  }

  Widget _buildNumberField(String key, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      initialValue: _profileData[key]?.toString() ?? '',
      onChanged: (value) {
        setState(() {
          _profileData[key] = value.isEmpty ? null : double.tryParse(value);
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter a value' : null,
    );
  }

  Widget _buildTextField(String key, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: _profileData[key] as String?,
      onChanged: (value) {
        setState(() {
          _profileData[key] = value;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userData = jsonDecode(userJson);
      Provider.of<MyAppState>(context, listen: false)
          .updateProfileFromJson(userData);

      // Update userId in MyAppState
      if (userData['id'] != null) {
        Provider.of<MyAppState>(context, listen: false)
            .updateUserId(userData['id']);
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final response = await http.put(
          Uri.parse('http://10.0.2.2:3000/user-profile/${widget.userId}'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(_profileData),
        );

        if (response.statusCode == 200) {
          final profileData = json.decode(response.body);

          // Update SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          final userJson = prefs.getString('user');
          if (userJson != null) {
            final userData = jsonDecode(userJson);
            userData.addAll(profileData);
            await prefs.setString('user', jsonEncode(userData));

            // Update userId in SharedPreferences
            await prefs.setInt('userId', int.parse(widget.userId));
          }

          var appState = context.read<MyAppState>();
          appState.updateProfileFromJson(profileData);
          appState.updateUserId(int.parse(widget.userId));

          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update profile')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    }
  }
}
