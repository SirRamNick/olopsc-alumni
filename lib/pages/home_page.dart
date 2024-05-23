import 'package:alumni/compontents/olopsc_form.dart';
import 'package:alumni/pages/questions_page_desktop.dart';
import 'package:alumni/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController emailController;
  late final TextEditingController firstNameController;
  late final TextEditingController middleNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController programController;
  late final TextEditingController batchController;
  late final TextEditingController sexController;
  late final TextEditingController statusController;
  late final TextEditingController yearGraduatedController;
  late final TextEditingController dateOfBirthController;
  late final TextEditingController occupationController;
  late final GlobalKey<FormState> formKey;
  late final FirestoreService alumni;
  late final List<String> programs;
  late final List<String> sexDropdownItems;
  late final List<String> status;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    programController = TextEditingController();
    batchController = TextEditingController();
    sexController = TextEditingController();
    statusController = TextEditingController();
    yearGraduatedController = TextEditingController();
    dateOfBirthController = TextEditingController();
    occupationController = TextEditingController();
    formKey = GlobalKey<FormState>();
    alumni = FirestoreService();
    programs = [
      'Bachelor in Elementary Education Major in General Education',
      'Bachelor Secondary Education Major in English ',
      'Bachelor Secondary Education Major in Mathematics ',
      'Bachelor of Arts in English ',
      'BS in Business Administration Major in Marketing Management ',
      'BS in Business Administration Major in Human Resource Management',
      'BS in Entrepreneurship',
      'BS in Hospitality Management / Hotel and Restaurant Management',
      'BS in Tourism Management',
      'BS in Computer Science',
      'Associate in Computer Technology',
      'Teacher Certificate Program',
    ];
    sexDropdownItems = [
      'Male',
      'Female',
    ];
    status = [
      'Government Employed',
      'Privately Employed',
      'Self-employed',
      'Others',
    ];
  }

  void onNextPageAndValidate() {
    Map userInfo = {
      'email': emailController.text,
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'degree': programController.text,
      'year_graduated': yearGraduatedController.text,
      'sex': sexController.text,
      'employment_status': statusController.text,
      'middle_name': middleNameController.text,
      'date_of_birth': dateOfBirthController.text,
      'occupation': occupationController.text,
      'time_stamp': Timestamp.now(),
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionsPage(
          userInformation: userInfo,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    programController.dispose();
    batchController.dispose();
    sexController.dispose();
    statusController.dispose();
    yearGraduatedController.dispose();
    dateOfBirthController.dispose();
    occupationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth < 1100;
    // width size: 1100
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 210, 49, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 210, 49, 1),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: Text('OLOPSC Alumni Form'),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topRight,
                child: Text('OLOPSC Alumni Tracking System (OATS)'),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://lh3.googleusercontent.com/d/1A9nZdV4Y4kXErJlBOkahkpODE7EVhp1x'),
            alignment: Alignment.bottomLeft,
            scale: 2.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  //olopsc logo // olopsc name
                  Image.network(
                      'https://lh3.googleusercontent.com/d/1DlDDvI0eIDivjwvCrngmyKp_Yr6d8oqH',
                      scale: 1.5),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Our Lady of Perpetual Succor College'),
                  const Text('Alumni Tracking System'),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //OCS Logo // Recognition & Credit
                      const Text('Made By: '),

                      Opacity(
                        opacity: 0.9,
                        child: Image.network(
                            // 'https://lh3.googleusercontent.com/d/19U4DW6KMNsVOqT6ZzX_ikpezY2N24Vyi',
                            'https://lh3.googleusercontent.com/d/1VDWlFOEyS-rftjzmy1DtWYNf5HvDSDq3',
                            scale: 39.5),
                      ),
                      // Text('$screenWidth')
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  // larger screen
                  if (!isLargeScreen)
                    Container(
                      width: screenWidth * .5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: OlopscForm(
                                  textEditingController: firstNameController,
                                  subTitle: const Text('First Name'),
                                  suffixIcon: null,
                                  validator: (value) => value!.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                              ),
                              Expanded(
                                child: OlopscForm(
                                  textEditingController: lastNameController,
                                  subTitle: const Text('Last Name'),
                                  suffixIcon: null,
                                  validator: (value) =>
                                      value!.isEmpty && value != null
                                          ? 'This field is required'
                                          : null,
                                ),
                              ),
                              Expanded(
                                child: OlopscForm(
                                  textEditingController: middleNameController,
                                  subTitle: const Text('Middle Name'),
                                  suffixIcon: null,
                                ),
                              ),
                              //gender
                              SizedBox(
                                width: 160,
                                child: DropdownButtonFormField2(
                                  validator: (value) => value == null
                                      ? 'This field is required'
                                      : null,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  hint: const Text('Sex'),
                                  items: sexDropdownItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      sexController.text = value!;
                                      value = null;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 160,
                                    padding: const EdgeInsets.only(
                                      left: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      color: Colors.white,
                                    ),
                                    elevation: 2,
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              //gender
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: OlopscForm(
                                subTitle: const Text('Email'),
                                textEditingController: emailController,
                                suffixIcon: null,
                                validator: (value) => value!.isEmpty
                                    ? 'This field is required'
                                    : null,
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: OlopscForm(
                                textEditingController: dateOfBirthController,
                                subTitle: const Text(
                                  'Date of Birth',
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 15),
                                ),
                                suffixIcon: null,
                                validator: (value) => value!.isEmpty
                                    ? 'This field is required'
                                    : null,
                              )),
                              Expanded(
                                child: OlopscForm(
                                  textEditingController:
                                      yearGraduatedController,
                                  subTitle: const Text(
                                    'Year \nGraduated',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  suffixIcon: null,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required';
                                    } else if (int.parse(value) < 2002) {
                                      return 'Invalid year graduated';
                                    }
                                  },
                                ),
                              ),
                              //Degree
                              SizedBox(
                                width: 270,
                                child: DropdownButtonFormField2(
                                  validator: (value) => value == null
                                      ? 'This field is required'
                                      : null,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  hint: const Text('Degree'),
                                  items: programs
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      programController.text = value!;
                                      value = null;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 160,
                                    padding: const EdgeInsets.only(
                                      left: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      color: Colors.white,
                                    ),
                                    elevation: 2,
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 180,
                                child: DropdownButtonFormField2(
                                  isExpanded: true,
                                  validator: (value) => value == null
                                      ? 'This field is required'
                                      : null,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  hint: const Text('Current Employment Status'),
                                  items: status
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      statusController.text = value!;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 160,
                                    padding: const EdgeInsets.only(
                                      left: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      color: Colors.white,
                                    ),
                                    elevation: 2,
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: statusController.text.toLowerCase() ==
                                        'privately employed' ||
                                    statusController.text.toLowerCase() ==
                                        'government employed' ||
                                    statusController.text.toLowerCase() ==
                                        'self-employed'
                                ? OlopscForm(
                                    textEditingController: occupationController,
                                    subTitle: const Text('--Please Specify--'),
                                    suffixIcon: null,
                                    validator: (value) => value!.isEmpty
                                        ? 'This field is required'
                                        : null,
                                  )
                                : null,
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        Color.fromRGBO(11, 10, 95, 1),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        onNextPageAndValidate();
                                        //   final DocumentReference document =
                                        //       alumni.alumni
                                        //           .doc(firstNameController.text);
                                        //   document.set({
                                        //     'email': emailController.text,
                                        //     'first_name':
                                        //         firstNameController.text,
                                        //     'last_name': lastNameController.text,
                                        //     'program': programController.text,
                                        //     'year_graduated': int.parse(
                                        //         yearGraduatedController.text),
                                        //     'sex': sexController.text,
                                        //     'employment_status':
                                        //         statusController.text,
                                        //     'middle_name':
                                        //         middleNameController.text,
                                        //     'date_of_birth':
                                        //         dateOfBirthController.text,
                                        //     'occupation':
                                        //         occupationController.text,
                                        //     'time_stamp': Timestamp.now(),
                                        //   });
                                        //   final DocumentReference documentStats =
                                        //       alumni.stats.doc(
                                        //           yearGraduatedController.text);
                                        //   final DocumentSnapshot yearData =
                                        //       await documentStats.get();
                                        //   if (yearData.exists) {
                                        //     await documentStats.update({
                                        //       'value': yearData.get('value') + 1
                                        //     });
                                        //   } else {
                                        //     await documentStats.set({
                                        //       'value': 1,
                                        //       'index': int.parse(
                                        //               yearGraduatedController
                                        //                   .text) -
                                        //           2001,
                                        //       'year': int.parse(
                                        //           yearGraduatedController.text),
                                        //     });
                                        //   }
                                        //   final DocumentReference
                                        //       documentEmpStats =
                                        //       alumni.empStats.doc(
                                        //           yearGraduatedController.text);
                                        //   final DocumentSnapshot empStatsData =
                                        //       await documentEmpStats.get();
                                        //   if (statusController.text
                                        //           .toLowerCase() ==
                                        //       'privately employed') {
                                        //     try {
                                        //       await documentEmpStats.update({
                                        //         'year': int.parse(
                                        //             yearGraduatedController.text),
                                        //         'privately_employed':
                                        //             empStatsData.get(
                                        //                     'privately_employed') +
                                        //                 1,
                                        //       });
                                        //     } catch (e) {
                                        //       await documentEmpStats.set({
                                        //         'year': int.parse(
                                        //             yearGraduatedController.text),
                                        //         'privately_employed': 1,
                                        //       }, SetOptions(merge: true));
                                        //     }
                                        //   }
                                        //   if (statusController.text
                                        //           .toLowerCase() ==
                                        //       'government employee') {
                                        //     try {
                                        //       await documentEmpStats.update({
                                        //         'year': int.parse(
                                        //             yearGraduatedController.text),
                                        //         'government_employee':
                                        //             empStatsData.get(
                                        //                     'government_employee') +
                                        //                 1,
                                        //       });
                                        //     } catch (e) {
                                        //       await documentEmpStats.set({
                                        //         'year': int.parse(
                                        //             yearGraduatedController.text),
                                        //         'government_employee': 1,
                                        //       }, SetOptions(merge: true));
                                        //     }
                                        //   }
                                        //   if (statusController.text
                                        //           .toLowerCase() ==
                                        //       'entrepreneur') {
                                        //     try {
                                        //       await documentEmpStats.update({
                                        //         'year': int.parse(
                                        //             yearGraduatedController.text),
                                        //         'entrepreneur': empStatsData
                                        //                 .get('entrepreneur') +
                                        //             1,
                                        //       });
                                        //     } catch (e) {
                                        //       await documentEmpStats.set({
                                        //         'year': int.parse(
                                        //             yearGraduatedController.text),
                                        //         'entrepreneur': 1,
                                        //       }, SetOptions(merge: true));
                                        //     }
                                        //   }
                                        //   if (statusController.text
                                        //           .toLowerCase() ==
                                        //       'others') {
                                        //     try {
                                        //       await documentEmpStats.update({
                                        //         'year': int.parse(
                                        //             yearGraduatedController.text),
                                        //         'others':
                                        //             empStatsData.get('others') +
                                        //                 1,
                                        //       });
                                        //     } catch (e) {
                                        //       await documentEmpStats.set({
                                        //         'year': int.parse(
                                        //             yearGraduatedController.text),
                                        //         'others': 1,
                                        //       }, SetOptions(merge: true));
                                        //     }
                                        //   }
                                        //   emailController.clear();
                                        //   firstNameController.clear();
                                        //   middleNameController.clear();
                                        //   lastNameController.clear();
                                        //   programController.clear();
                                        //   batchController.clear();
                                        //   sexController.clear();
                                        //   statusController.clear();
                                        //   yearGraduatedController.clear();
                                        //   dateOfBirthController.clear();
                                        //   occupationController.clear();
                                        //   Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => QuestionsPage(
                                        //         docID: document.id,
                                        //       ),
                                        //     ),
                                        //   );
                                      }
                                    },
                                    child: const Text(
                                      'Next',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 210, 49, 1),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  // Smaller Screen
                  else
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                //first name
                                OlopscForm(
                                  textEditingController: firstNameController,
                                  subTitle: const Text('First Name'),
                                  suffixIcon: null,
                                  validator: (value) => value!.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                //last name
                                OlopscForm(
                                  textEditingController: lastNameController,
                                  subTitle: const Text('Last Name'),
                                  suffixIcon: null,
                                  validator: (value) => value!.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                // middle name
                                OlopscForm(
                                  textEditingController: middleNameController,
                                  subTitle: const Text('Middle Name'),
                                  suffixIcon: null,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                // Email
                                OlopscForm(
                                  subTitle: const Text('Email'),
                                  textEditingController: emailController,
                                  suffixIcon: null,
                                  validator: (value) => value!.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                //date of birth
                                OlopscForm(
                                  textEditingController: dateOfBirthController,
                                  subTitle: const Text('Date of Birth'),
                                  suffixIcon: null,
                                  validator: (value) => value!.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                //year graduated
                                OlopscForm(
                                  textEditingController:
                                      yearGraduatedController,
                                  subTitle: const Text('Year Graduated'),
                                  suffixIcon: null,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required';
                                    } else if (int.parse(value) < 2002) {
                                      return 'Invalid year graduated';
                                    }
                                  },
                                ),
                                //date of birth
                                const SizedBox(
                                  height: 25,
                                ),
                                Wrap(
                                  spacing: 20.0,
                                  runSpacing: 20.0,
                                  children: <Widget>[
                                    //gender
                                    SizedBox(
                                      width: 200,
                                      child: DropdownButtonFormField2(
                                        validator: (value) => value == null
                                            ? 'This field is required'
                                            : null,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        hint: const Text('Sex'),
                                        items: sexDropdownItems
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            sexController.text = value!;
                                            value = null;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 50,
                                          width: 160,
                                          padding: const EdgeInsets.only(
                                            left: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            color: Colors.white,
                                          ),
                                          elevation: 2,
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      ),
                                    ),
                                    //gender
                                    //Degree
                                    SizedBox(
                                      width: 350,
                                      child: DropdownButtonFormField2(
                                        validator: (value) => value == null
                                            ? 'This field is required'
                                            : null,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        hint: const Text('Degree'),
                                        items: programs
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            programController.text = value!;
                                            value = null;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 50,
                                          width: 160,
                                          padding: const EdgeInsets.only(
                                            left: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            color: Colors.white,
                                          ),
                                          elevation: 2,
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      ),
                                    ),
                                    //Degree
                                    //Employment Status
                                    SizedBox(
                                      width: 350,
                                      child: DropdownButtonFormField2(
                                        validator: (value) => value == null
                                            ? 'This field is required'
                                            : null,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        hint: const Text(
                                            'Current Employment Status'),
                                        items: status
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            statusController.text = value!;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 50,
                                          width: 160,
                                          padding: const EdgeInsets.only(
                                            left: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            color: Colors.white,
                                          ),
                                          elevation: 2,
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 24,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                      ),
                                    ),
                                    //employment status
                                  ],
                                ),

                                const SizedBox(
                                  height: 25,
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: statusController.text.toLowerCase() ==
                                              'privately employed' ||
                                          statusController.text.toLowerCase() ==
                                              'government employed' ||
                                          statusController.text.toLowerCase() ==
                                              'self-employed'
                                      ? OlopscForm(
                                          textEditingController:
                                              occupationController,
                                          subTitle:
                                              const Text('--Please Specify--'),
                                          suffixIcon: null,
                                          validator: (value) => value!.isEmpty
                                              ? 'This field is required'
                                              : null,
                                        )
                                      : null,
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: ElevatedButton(
                                          style: const ButtonStyle(
                                            shadowColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                              Color.fromRGBO(11, 10, 95, 1),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              onNextPageAndValidate();
                                              // final DocumentReference document =
                                              //     alumni.alumni.doc(
                                              //         firstNameController.text);
                                              // setState(() {
                                              //   document.set({
                                              //     'email': emailController.text,
                                              //     'first_name':
                                              //         firstNameController.text,
                                              //     'last_name':
                                              //         lastNameController.text,
                                              //     'program':
                                              //         programController.text,
                                              //     'year_graduated': int.parse(
                                              //         yearGraduatedController
                                              //             .text),
                                              //     'sex': sexController.text,
                                              //     'employment_status':
                                              //         statusController.text,
                                              //     'middle_name':
                                              //         middleNameController.text,
                                              //     'date_of_birth':
                                              //         dateOfBirthController
                                              //             .text,
                                              //     'occupation':
                                              //         occupationController.text,
                                              //     'time_stamp': Timestamp.now(),
                                              //   });
                                              // });
                                              // DocumentSnapshot yearData =
                                              //     await alumni.stats
                                              //         .doc(
                                              //             yearGraduatedController
                                              //                 .text)
                                              //         .get();
                                              // alumni.stats
                                              //     .doc(yearGraduatedController
                                              //         .text)
                                              //     .set({
                                              //   'value':
                                              //       yearData.get('value') + 1,
                                              //   'index': int.parse(
                                              //           yearGraduatedController
                                              //               .text) -
                                              //       2001,
                                              //   'year': int.parse(
                                              //       yearGraduatedController
                                              //           .text),
                                              // });
                                              // emailController.clear();
                                              // firstNameController.clear();
                                              // middleNameController.clear();
                                              // lastNameController.clear();
                                              // programController.clear();
                                              // batchController.clear();
                                              // sexController.clear();
                                              // statusController.clear();
                                              // yearGraduatedController.clear();
                                              // dateOfBirthController.clear();
                                              // occupationController.clear();
                                              // Navigator.pushReplacement(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         QuestionsPage(
                                              //       docID: document.id,
                                              //     ),
                                              //   ),
                                              // );
                                            }
                                          },
                                          child: const Text(
                                            'Next',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 210, 49, 1),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
