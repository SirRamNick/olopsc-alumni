import 'package:alumni/pages/custom_form_field.dart';
import 'package:alumni/pages/questions_page_desktop.dart';
import 'package:alumni/pages/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Form Controllers
  final _formKey = GlobalKey<FormState>();
  final _controllers = <String, TextEditingController>{};

  // Dropdown Lists
  final _dropdownData = {
    'programs': [
      'Bachelor in Elementary Education Major in General Education',
      'Bachelor Secondary Education Major in English',
      'Bachelor Secondary Education Major in Mathematics',
      'Bachelor of Arts in English',
      'BS in Business Administration Major in Marketing Management',
      'BS in Business Administration Major in Human Resource Management',
      'BS in Entrepreneurship',
      'BS in Hospitality Management / Hotel and Restaurant Management',
      'BS in Tourism Management',
      'BS in Computer Science',
      'Associate in Computer Technology',
      'Teacher Certificate Program',
    ],
    'sex': ['Male', 'Female'],
    'employmentStatus': [
      'Government Employed',
      'Privately Employed',
      'Self-employed',
      'Others',
    ]
  };

  @override
  void initState() {
    super.initState();
    // Initialize all controllers
    final controllerKeys = [
      'firstName',
      'lastName',
      'middleName',
      'email',
      'dateOfBirth',
      'yearGraduated',
      'sex',
      'program',
      'employmentStatus',
      'occupation'
    ];

    for (var key in controllerKeys) {
      _controllers[key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Prepare user information map
      final userInfo = {
        'first_name': _controllers['firstName']!.text,
        'last_name': _controllers['lastName']!.text,
        'middle_name': _controllers['middleName']!.text,
        'email': _controllers['email']!.text,
        'date_of_birth': _controllers['dateOfBirth']!.text,
        'year_graduated': _controllers['yearGraduated']!.text,
        'sex': _controllers['sex']!.text,
        'degree': _controllers['program']!.text,
        'employment_status': _controllers['employmentStatus']!.text,
        'occupation': _controllers['occupation']?.text ?? '',
        'time_stamp': Timestamp.now(),
      };

      // Navigate to next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionsPage(userInformation: userInfo),
        ),
      );
    }
  }

  // Date Picker Method
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Header Widget
  Widget _buildHeader() {
    return Column(
      children: [
        Image.network(
          'https://lh3.googleusercontent.com/d/1DlDDvI0eIDivjwvCrngmyKp_Yr6d8oqH',
          scale: 1.5,
        ),
        const SizedBox(height: 15),
        const Text(
          'Our Lady of Perpetual Succor College',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Alumni Tracking System',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Common form fields method
  Widget _buildFormFields(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Name Fields
          if (!isMobile)
            Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    controller: _controllers['firstName']!,
                    label: 'First Name',
                    validator: (value) =>
                        value!.isEmpty ? 'First name is required' : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomFormField(
                    controller: _controllers['lastName']!,
                    label: 'Last Name',
                    validator: (value) =>
                        value!.isEmpty ? 'Last name is required' : null,
                  ),
                ),
              ],
            )
          else ...[
            CustomFormField(
              controller: _controllers['firstName']!,
              label: 'First Name',
              validator: (value) =>
                  value!.isEmpty ? 'First name is required' : null,
            ),
            const SizedBox(height: 15),
            CustomFormField(
              controller: _controllers['lastName']!,
              label: 'Last Name',
              validator: (value) =>
                  value!.isEmpty ? 'Last name is required' : null,
            ),
          ],
          const SizedBox(height: 15),

          // Middle Name
          CustomFormField(
            controller: _controllers['middleName']!,
            label: 'Middle Name',
          ),
          const SizedBox(height: 15),

          // Email
          CustomFormField(
            controller: _controllers['email']!,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) return 'Email is required';
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
              return !emailRegex.hasMatch(value) ? 'Enter a valid email' : null;
            },
          ),
          const SizedBox(height: 15),

          // Date of Birth
          GestureDetector(
            onTap: () => _selectDate(context, _controllers['dateOfBirth']!),
            child: AbsorbPointer(
              child: CustomFormField(
                controller: _controllers['dateOfBirth']!,
                label: 'Date of Birth',
                validator: (value) =>
                    value!.isEmpty ? 'Date of Birth is required' : null,
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Year Graduated
          CustomFormField(
            controller: _controllers['yearGraduated']!,
            label: 'Year Graduated',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) return 'Year Graduated is required';
              final year = int.tryParse(value);
              if (year == null) return 'Enter a valid year';
              if (year < 2002) return 'Invalid year graduated';
              return null;
            },
          ),
          const SizedBox(height: 15),

          // Sex Dropdown
          DropdownButtonFormField2(
            decoration: _dropdownDecoration('Sex'),
            items: _dropdownData['sex']!
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: (value) => _controllers['sex']!.text = value.toString(),
            validator: (value) => value == null ? 'Sex is required' : null,
          ),
          const SizedBox(height: 15),

          // Program Dropdown
          DropdownButtonFormField2(
            decoration: _dropdownDecoration('Degree Program'),
            items: _dropdownData['programs']!
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item, overflow: TextOverflow.ellipsis),
                    ))
                .toList(),
            onChanged: (value) =>
                _controllers['program']!.text = value.toString(),
            validator: (value) => value == null ? 'Degree is required' : null,
          ),
          const SizedBox(height: 15),

          // Employment Status Dropdown
          DropdownButtonFormField2(
            decoration: _dropdownDecoration('Employment Status'),
            items: _dropdownData['employmentStatus']!
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _controllers['employmentStatus']!.text = value.toString();
              });
            },
            validator: (value) =>
                value == null ? 'Employment Status is required' : null,
          ),
          const SizedBox(height: 15),

          // Conditional Occupation Field
          if (_controllers['employmentStatus']!.text.toLowerCase() != 'others')
            CustomFormField(
              controller: _controllers['occupation']!,
              label: 'Occupation',
              validator: (value) =>
                  value!.isEmpty ? 'Occupation is required' : null,
            ),
          const SizedBox(height: 20),

          // Submit Button
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(11, 10, 95, 1),
              foregroundColor: const Color.fromRGBO(255, 210, 49, 1),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  // Dropdown Decoration
  InputDecoration _dropdownDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 210, 49, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 210, 49, 1),
        title: const Text('OLOPSC Alumni Tracking System (OATS)'),
      ),
      body: ResponsiveLayout(
        desktopBody: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildFormFields(false),
                ],
              ),
            ),
          ),
        ),
        mobileBody: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildFormFields(true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
