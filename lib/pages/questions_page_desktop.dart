import 'package:alumni/compontents/button.dart';
import 'package:alumni/compontents/question_content_small.dart';
import 'package:alumni/compontents/question_form.dart';
import 'package:alumni/pages/navigation_page.dart';
import 'package:alumni/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class QuestionsPage extends StatefulWidget {
  final Map userInformation;
  const QuestionsPage({
    super.key,
    required this.userInformation,
  });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late final TextEditingController question1Controller =
      TextEditingController();
  late final TextEditingController question2Controller =
      TextEditingController();
  late final TextEditingController question3Controller =
      TextEditingController();
  late final TextEditingController question4Controller =
      TextEditingController();
  late final TextEditingController question5Controller =
      TextEditingController();
  late final TextEditingController question6Controller =
      TextEditingController();
  // Question 2
  int? stronglyAgree2 = 0;
  int? agree2 = 0;
  int? neutral2 = 0;
  int? disagree2 = 0;
  int? stronglyDisagree2 = 0;
  // Question 3
  int? stronglyAgree3 = 0;
  int? agree3 = 0;
  int? neutral3 = 0;
  int? disagree3 = 0;
  int? stronglyDisagree3 = 0;
  // Question 5
  int? stronglyAgree5 = 0;
  int? agree5 = 0;
  int? neutral5 = 0;
  int? disagree5 = 0;
  int? stronglyDisagree5 = 0;
  // Question 6
  int? stronglyAgree6 = 0;
  int? agree6 = 0;
  int? neutral6 = 0;
  int? disagree6 = 0;
  int? stronglyDisagree6 = 0;
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final Map information = widget.userInformation;
  late final FirestoreService alumni = FirestoreService();
  bool clickSubmit = false;

  // late final List<String> listOfAnswers1 = [
  //   'Yes',
  //   'No',
  //   'Not Applicable',
  // ];
  // late final List<String> listOfAnswers2 = [
  //   'Not relevant at all',
  //   'Somewhat relevant',
  //   'Very relevant',
  //   'Not Applicable',
  // ];
  // late final List<String> listOfAnswers3 = [
  //   'Not helpful',
  //   'Somewhat helpful',
  //   'Very helpful',
  //   'Not Applicable',
  // ];
  // late final List<String> listOfAnswers4 = [
  //   'No',
  //   'Somehow',
  //   'Yes',
  //   'Not Applicable',
  // ];
  // late final List<String> listOfAnswers5 = [
  //   'Not relevant at all',
  //   'Somewhat relevant',
  //   'Same/very relevant',
  //   'Not Applicable',
  // ];

  final List<String> likertScaleAgree = [
    "Strongly agree",
    "Agree",
    "Neutral",
    "Disagree",
    "Strongly disagree",
  ];
  final List<String> durationBeforeEmployed = [
    "I had a job before my graduation",
    "Within a month",
    "2-3 months",
    "4-5 months",
    "6-7 months",
    "More than 7 months",
  ];

  List<String> setSearchParam(String firstName, String lastName) {
    String name = '$firstName $lastName';
    List<String> caseSearchList = [];
    String temp = '';

    for (int i = 0; i < name.length; i++) {
      temp += name[i];
      caseSearchList.add(temp.toLowerCase());
    }

    name = '$lastName $firstName';
    temp = '';
    for (int i = 0; i < name.length; i++) {
      temp += name[i];
      caseSearchList.add(temp.toLowerCase());
    }

    return caseSearchList;
  }

  Future<String> onSubmitAndValidate() async {
    final DocumentReference document = alumni.alumni.doc();
    final String documentID = document.id;

    document.set({
      'email': information['email'],
      'first_name': information['first_name'],
      'last_name': information['last_name'],
      'degree': information['degree'],
      'year_graduated': information['year_graduated'],
      'sex': information['sex'],
      'employment_status': information['employment_status'],
      'middle_name': information['middle_name'],
      'date_of_birth': information['date_of_birth'],
      'occupation': information['occupation'],
      'searchable_name':
          setSearchParam(information['first_name'], information['last_name']),
      'question_1': question1Controller.text,
      'question_2': question2Controller.text,
      'question_3': question3Controller.text,
      'question_4': question4Controller.text,
      'question_5': question5Controller.text,
      'question_6': question6Controller.text,
    });

    try {
      final DocumentReference documentStats =
          alumni.stats.doc(information['year_graduated']);
      final DocumentSnapshot yearData = await documentStats.get();
      if (yearData.exists) {
        await documentStats.update({'value': yearData.get('value') + 1});
      } else {
        await documentStats.set({
          'value': 1,
          'year': int.parse(information['year_graduated']),
        });
      }
    } catch (e) {
      print('Error: ${e}');
    }

    final DocumentReference documentEmpStats =
        alumni.empStats.doc(information['year_graduated']);
    final DocumentSnapshot empStatsData = await documentEmpStats.get();

    if (information['employment_status'].toLowerCase() ==
        'privately employed') {
      try {
        documentEmpStats.update({
          'year': int.parse(information['year_graduated']),
          'privately_employed': empStatsData.get('privately_employed') + 1,
          'index': int.parse(information['year_graduated']) - 2001,
        });
      } catch (e) {
        await documentEmpStats.set({
          'year': int.parse(information['year_graduated']),
          'privately_employed': 1,
          'index': int.parse(information['year_graduated']) - 2001,
          'government_employed': 0,
          'self_employed': 0,
          'others': 0,
        }, SetOptions(merge: true));
      }
    } else if (information['employment_status'].toLowerCase() ==
        'government employed') {
      try {
        await documentEmpStats.update({
          'year': int.parse(information['year_graduated']),
          'government_employed': empStatsData.get('government_employed') + 1,
          'index': int.parse(information['year_graduated']) - 2001,
        });
      } catch (e) {
        await documentEmpStats.set({
          'year': int.parse(information['year_graduated']),
          'government_employed': 1,
          'index': int.parse(information['year_graduated']) - 2001,
          'privately_employed': 0,
          'self_employed': 0,
          'others': 0,
        }, SetOptions(merge: true));
      }
    } else if (information['employment_status'].toLowerCase() ==
        'self_employed') {
      try {
        await documentEmpStats.update({
          'year': int.parse(information['year_graduated']),
          'self_employed': empStatsData.get('self_employed') + 1,
          'index': int.parse(information['year_graduated']) - 2001,
        });
      } catch (e) {
        await documentEmpStats.set({
          'year': int.parse(information['year_graduated']),
          'self_employed': 1,
          'index': int.parse(information['year_graduated']) - 2001,
          'government_employed': 0,
          'privately_employed': 0,
          'others': 0,
        }, SetOptions(merge: true));
      }
    } else if (information['employment_status'].toLowerCase() == 'others') {
      try {
        await documentEmpStats.update({
          'year': int.parse(information['year_graduated']),
          'others': empStatsData.get('others') + 1,
          'index': int.parse(information['year_graduated']) - 2001,
        });
      } catch (e) {
        await documentEmpStats.set({
          'year': int.parse(information['year_graduated']),
          'others': 1,
          'index': int.parse(information['year_graduated']) - 2001,
          'government_employed': 0,
          'self_employed': 0,
          'privately_employed': 0,
        }, SetOptions(merge: true));
      }
    }
    // ----------------------------------- //
    try {
      final DocumentReference collectionRef1 = FirebaseFirestore.instance
          .collection('question_2')
          .doc(information['degree']);
      final DocumentSnapshot qDoc = await collectionRef1.get();
      collectionRef1.update({
        'strongly_agree': qDoc.get('strongly_agree') + stronglyAgree2,
        'agree': qDoc.get('agree') + agree2,
        'neutral': qDoc.get('neutral') + neutral2,
        'disagree': qDoc.get('disagree') + disagree2,
        'strongly_disagree': qDoc.get('strongly_disagree') + stronglyDisagree2,
      });
    } catch (e) {
      print('Error: ${e}');
    }
    try {
      final DocumentReference collectionRef1 = FirebaseFirestore.instance
          .collection('question_3')
          .doc(information['degree']);
      final DocumentSnapshot qDoc = await collectionRef1.get();
      collectionRef1.update({
        'strongly_agree': qDoc.get('strongly_agree') + stronglyAgree3,
        'agree': qDoc.get('agree') + agree3,
        'neutral': qDoc.get('neutral') + neutral3,
        'disagree': qDoc.get('disagree') + disagree3,
        'strongly_disagree': qDoc.get('strongly_disagree') + stronglyDisagree3,
      });
    } catch (e) {
      print('Error: ${e}');
    }
    try {
      final DocumentReference collectionRef1 = FirebaseFirestore.instance
          .collection('question_5')
          .doc(information['degree']);
      final DocumentSnapshot qDoc = await collectionRef1.get();
      collectionRef1.update({
        'strongly_agree': qDoc.get('strongly_agree') + stronglyAgree5,
        'agree': qDoc.get('agree') + agree5,
        'neutral': qDoc.get('neutral') + neutral5,
        'disagree': qDoc.get('disagree') + disagree5,
        'strongly_disagree': qDoc.get('strongly_disagree') + stronglyDisagree5,
      });
    } catch (e) {
      print('Error: ${e}');
    }
    try {
      final DocumentReference collectionRef1 = FirebaseFirestore.instance
          .collection('question_6')
          .doc(information['degree']);
      final DocumentSnapshot qDoc = await collectionRef1.get();
      collectionRef1.update({
        'strongly_agree': qDoc.get('strongly_agree') + stronglyAgree6,
        'agree': qDoc.get('agree') + agree6,
        'neutral': qDoc.get('neutral') + neutral6,
        'disagree': qDoc.get('disagree') + disagree6,
        'strongly_disagree': qDoc.get('strongly_disagree') + stronglyDisagree6,
      });
    } catch (e) {
      print('Error: ${e}');
    }

    return documentID;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth < 950;
    final bool isEmployed =
        information['employment_status'].toString().toLowerCase() != 'others';
    //width size: 950
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
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //larger screen
                  if (!isLargeScreen)
                    Container(
                      child: Column(
                        children: [
                          //1st Question
                          QuestionForm(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'What are the life skills OLOPSC has taught you?'),
                                ),
                                TextFormField(
                                  controller: question1Controller,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: 2,
                                  validator: (value) =>
                                      value!.isEmpty && value != null
                                          ? 'This field is required'
                                          : null,
                                )
                              ],
                            ),
                          ),
                          //2nd Question
                          QuestionForm(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'The skills you\'ve mentioned helped you in pursuing your career path.'),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 150,
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
                                      hint: const Text('Choose'),
                                      items: likertScaleAgree
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
                                          question2Controller.text = value!;
                                          if (value == 'Strongly agree') {
                                            stronglyAgree2 = 1;
                                          } else if (value == 'Agree') {
                                            agree2 = 1;
                                          } else if (value == 'Neutral') {
                                            neutral2 = 1;
                                          } else if (value == 'Disagree') {
                                            disagree2 = 1;
                                          } else if (value ==
                                              'Strongly disagree') {
                                            stronglyDisagree2 = 1;
                                          }
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
                                ),
                              ],
                            ),
                          ),
                          //3rd Question
                          isEmployed
                              ? QuestionForm(
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'Your first job aligns with your current job.'),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 150,
                                          child: DropdownButtonFormField2(
                                            validator: (value) => value == null
                                                ? 'This field is required'
                                                : null,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            hint: const Text('Choose'),
                                            items: likertScaleAgree
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
                                                question3Controller.text =
                                                    value!;
                                                if (value == 'Strongly agree') {
                                                  stronglyAgree3 = 1;
                                                } else if (value == 'Agree') {
                                                  agree3 = 1;
                                                } else if (value == 'Neutral') {
                                                  neutral3 = 1;
                                                } else if (value ==
                                                    'Disagree') {
                                                  disagree3 = 1;
                                                } else if (value ==
                                                    'Strongly disagree') {
                                                  stronglyDisagree3 = 1;
                                                }
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
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          //4th Question
                          isEmployed
                              ? QuestionForm(
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'How long does it take for you to land your first job after graduation?'),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 250,
                                          child: DropdownButtonFormField2(
                                            validator: (value) => value == null
                                                ? 'This field is required'
                                                : null,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            hint: const Text('Choose'),
                                            items: durationBeforeEmployed
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
                                                question4Controller.text =
                                                    value!;
                                                if (value == 'Strongly agree') {
                                                  stronglyAgree5 = 1;
                                                } else if (value == 'Agree') {
                                                  agree5 = 1;
                                                } else if (value == 'Neutral') {
                                                  neutral5 = 1;
                                                } else if (value ==
                                                    'Disagree') {
                                                  disagree5 = 1;
                                                } else if (value ==
                                                    'Strongly disagree') {
                                                  stronglyDisagree5 = 1;
                                                }
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
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          //5th Question
                          isEmployed
                              ? QuestionForm(
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'The program you took in OLOPSC matches your current job.'),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 150,
                                          child: DropdownButtonFormField2(
                                            validator: (value) => value == null
                                                ? 'This field is required'
                                                : null,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            hint: const Text('Choose'),
                                            items: likertScaleAgree
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
                                                question5Controller.text =
                                                    value!;
                                                if (value == 'Strongly agree') {
                                                  stronglyAgree6 = 1;
                                                } else if (value == 'Agree') {
                                                  agree6 = 1;
                                                } else if (value == 'Neutral') {
                                                  neutral6 = 1;
                                                } else if (value ==
                                                    'Disagree') {
                                                  disagree6 = 1;
                                                } else if (value ==
                                                    'Strongly disagree') {
                                                  stronglyDisagree6 = 1;
                                                }
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
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          //6th Question
                          isEmployed
                              ? QuestionForm(
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'You are satisfied with your current job.'),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 150,
                                          child: DropdownButtonFormField2(
                                            validator: (value) => value == null
                                                ? 'This field is required'
                                                : null,
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            hint: const Text('Choose'),
                                            items: likertScaleAgree
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
                                                question6Controller.text =
                                                    value!;
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
                                            dropdownStyleData:
                                                DropdownStyleData(
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
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),

                          const SizedBox(height: 28),
                          Button(
                            enabled: !clickSubmit,
                            onSubmit: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  clickSubmit = true;
                                });
                                String documentID = await onSubmitAndValidate();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavigationPage(
                                      docID: documentID,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  //smaller screen
                  else
                    Column(
                      children: [
                        //first Question
                        QuestionContentSmall(
                          constructQuestion:
                              'What are the life skills OLOPSC has taught you?',
                          contructFormQuestion: TextFormField(
                            controller: question1Controller,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 2,
                            validator: (value) =>
                                value!.isEmpty && value != null
                                    ? 'This field is required'
                                    : null,
                          ),
                        ),
                        //second Question
                        QuestionContentSmall(
                          constructQuestion:
                              'The skills you\'ve mentioned helped you in pursuing your career path.',
                          contructFormQuestion: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 150,
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
                                hint: const Text('Choose'),
                                items: likertScaleAgree
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
                                    question2Controller.text = value!;
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
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //third Question
                        isEmployed
                            ? QuestionContentSmall(
                                constructQuestion:
                                    'Your first job aligns with your current job.',
                                contructFormQuestion: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 150,
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
                                      hint: const Text('Choose'),
                                      items: likertScaleAgree
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
                                          question3Controller.text = value!;
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
                                ),
                              )
                            : const SizedBox(),
                        //fourth Question
                        isEmployed
                            ? QuestionContentSmall(
                                constructQuestion:
                                    'How long does it take for you to land your first job after graduation?',
                                contructFormQuestion: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 250,
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
                                      hint: const Text('Choose'),
                                      items: durationBeforeEmployed
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
                                          question4Controller.text = value!;
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
                                ),
                              )
                            : const SizedBox(),
                        //fifth Question
                        isEmployed
                            ? QuestionContentSmall(
                                constructQuestion:
                                    'The program you took in OLOPSC matches your current job.',
                                contructFormQuestion: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 150,
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
                                      hint: const Text('Choose'),
                                      items: likertScaleAgree
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
                                          question5Controller.text = value!;
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
                                ),
                              )
                            : const SizedBox(),
                        //Sixth Question
                        isEmployed
                            ? QuestionContentSmall(
                                constructQuestion:
                                    'You are satisfied with your current job.',
                                contructFormQuestion: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 150,
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
                                      hint: const Text('Choose'),
                                      items: likertScaleAgree
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
                                          question6Controller.text = value!;
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
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 15),
                        Button(
                          enabled: !clickSubmit,
                          onSubmit: () async {
                            if (formKey.currentState!.validate()) {
                              String documentID = await onSubmitAndValidate();
                              setState(() {
                                clickSubmit = true;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationPage(
                                    docID: documentID,
                                  ),
                                ),
                              );
                              // alumni.alumni.doc(widget.docID).update({
                              //   'question_1': question1Controller.text,
                              //   'question_2': question2Controller.text,
                              //   'question_3': question3Controller.text,
                              //   'question_4': question4Controller.text,
                              //   'question_5': question5Controller.text,
                              //   'question_6': question6Controller.text,
                              // });
                              // print(question1Controller.text);
                              // question1Controller.clear();
                              // question2Controller.clear();
                              // question3Controller.clear();
                              // question4Controller.clear();
                              // question5Controller.clear();
                              // question6Controller.clear();
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => NavigationPage(
                              //       docID: widget.docID,
                              //     ),
                              //   ),
                              // );
                            }
                          },
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  // Column(
                  //   children: [
                  //     //first Question
                  //     QuestionContentSmall(
                  //       constructQuestion:
                  //           'Are you satisfied with your current status?',
                  //       contructFormQuestion: Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: DropdownMenu(
                  //           width: 150,
                  //           hintText: '-Select-',
                  //           onSelected: (String? value) {
                  //             setState(() {
                  //               question1Controller.text = value!;
                  //             });
                  //             print(question1Controller.text);
                  //           },
                  //           dropdownMenuEntries:
                  //               listOfAnswers1.map((String value) {
                  //             return DropdownMenuEntry<String>(
                  //               value: value,
                  //               label: value,
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ),
                  //     //second Question
                  //     QuestionContentSmall(
                  //       constructQuestion:
                  //           'Were you employed within the year of your graduation?',
                  //       contructFormQuestion: Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: DropdownMenu(
                  //           width: 150,
                  //           hintText: '-Select-',
                  //           onSelected: (String? value) {
                  //             setState(() {
                  //               question2Controller.text = value!;
                  //             });
                  //             print(question2Controller.text);
                  //           },
                  //           dropdownMenuEntries:
                  //               listOfAnswers2.map((String value) {
                  //             return DropdownMenuEntry<String>(
                  //               value: value,
                  //               label: value,
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ),
                  //     //third Question
                  //     QuestionContentSmall(
                  //       constructQuestion:
                  //           'How relevant was the program to your job post-graduation?',
                  //       contructFormQuestion: Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: DropdownMenu(
                  //           width: 150,
                  //           hintText: '-Select-',
                  //           onSelected: (String? value) {
                  //             setState(() {
                  //               question3Controller.text = value!;
                  //             });
                  //             print(question3Controller.text);
                  //           },
                  //           dropdownMenuEntries:
                  //               listOfAnswers3.map((String value) {
                  //             return DropdownMenuEntry<String>(
                  //               value: value,
                  //               label: value,
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ),
                  //     //fourth Question
                  //     QuestionContentSmall(
                  //       constructQuestion:
                  //           'Did the program help in applying for your current occupation?',
                  //       contructFormQuestion: Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: DropdownMenu(
                  //           width: 150,
                  //           hintText: '-Select-',
                  //           onSelected: (String? value) {
                  //             setState(() {
                  //               question4Controller.text = value!;
                  //             });
                  //             print(question4Controller.text);
                  //           },
                  //           dropdownMenuEntries:
                  //               listOfAnswers4.map((String value) {
                  //             return DropdownMenuEntry<String>(
                  //               value: value,
                  //               label: value,
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ),
                  //     //fifth Question
                  //     QuestionContentSmall(
                  //       constructQuestion:
                  //           'Did the program provide the necessary skills needed for your current job?',
                  //       contructFormQuestion: Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: DropdownMenu(
                  //           width: 150,
                  //           hintText: '-Select-',
                  //           onSelected: (String? value) {
                  //             setState(() {
                  //               question5Controller.text = value!;
                  //             });
                  //             print(question5Controller.text);
                  //           },
                  //           dropdownMenuEntries:
                  //               listOfAnswers5.map((String value) {
                  //             return DropdownMenuEntry<String>(
                  //               value: value,
                  //               label: value,
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ),
                  //     //Sixth Question
                  //     QuestionContentSmall(
                  //       constructQuestion:
                  //           'What were the necessary skills you acquired from the program needed for your current job?',
                  //       contructFormQuestion: TextFormField(
                  //         controller: question6Controller,
                  //         keyboardType: TextInputType.multiline,
                  //         textInputAction: TextInputAction.newline,
                  //         maxLines: 2,
                  //         validator: (value) =>
                  //             value!.isEmpty && value != null
                  //                 ? 'This field is required'
                  //                 : null,
                  //       ),
                  //     ),
                  //     const SizedBox(height: 15),
                  //     Button(
                  //       onSubmit: () {
                  //         if (formKey.currentState!.validate()) {
                  //           // alumni.alumni.doc(widget.docID).update({
                  //           //   'question_1': question1Controller.text,
                  //           //   'question_2': question2Controller.text,
                  //           //   'question_3': question3Controller.text,
                  //           //   'question_4': question4Controller.text,
                  //           //   'question_5': question5Controller.text,
                  //           //   'question_6': question6Controller.text,
                  //           // });
                  //           // print(question1Controller.text);
                  //           // question1Controller.clear();
                  //           // question2Controller.clear();
                  //           // question3Controller.clear();
                  //           // question4Controller.clear();
                  //           // question5Controller.clear();
                  //           // question6Controller.clear();
                  //           // Navigator.pushReplacement(
                  //           //   context,
                  //           //   MaterialPageRoute(
                  //           //     builder: (context) => NavigationPage(
                  //           //       docID: widget.docID,
                  //           //     ),
                  //           //   ),
                  //           // );
                  //         }
                  //       },
                  //     ),
                  //     const SizedBox(height: 28),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          // child: StreamBuilder(
          //     stream: alumni.alumni.doc(widget.docID).snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         var value = snapshot.data;
          //         return SingleChildScrollView(
          //           child: Center(
          //             child: Column(
          //               children: [
          //                 //olopsc logo // olopsc name
          //                 Image.asset('images/olopsc_logo.png', scale: 1.5),
          //                 const SizedBox(
          //                   height: 15,
          //                 ),
          //                 const Text('Our Lady of Perpetual Succor College'),
          //                 const Text('Alumni Tracking System'),
          //                 const SizedBox(
          //                   height: 12,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     //OCS Logo // Recognition & Credit
          //                     const Text('Made By: '),
          //                     Opacity(
          //                       opacity: 0.9,
          //                       child: Image.asset(
          //                           'images/ocs_insignia_logo.png',
          //                           scale: 39.5),
          //                     ),
          //                   ],
          //                 ),
          //                 const SizedBox(
          //                   height: 10,
          //                 ),
          //                 //larger screen
          //                 if (!isLargeScreen)
          //                   Container(
          //                     child: Column(
          //                       children: [
          //                         //1st Question
          //                         QuestionForm(
          //                           content: Column(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.center,
          //                             children: [
          //                               const Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: Text(
          //                                     'Are you satisfied with your current status?'),
          //                               ),
          //                               Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: DropdownMenu(

          //                                   width: 150,
          //                                   hintText: '-Select-',
          //                                   onSelected: (String? value) {
          //                                     setState(() {
          //                                       question1Controller.text =
          //                                           value!;
          //                                     });
          //                                     print(question1Controller.text);
          //                                   },
          //                                   dropdownMenuEntries: listOfAnswers1
          //                                       .map((String value) {
          //                                     return DropdownMenuEntry<String>(
          //                                       value: value,
          //                                       label: value,
          //                                     );
          //                                   }).toList(),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         //2nd Question
          //                         QuestionForm(
          //                           content: Column(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.center,
          //                             children: [
          //                               const Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: Text(
          //                                     'Were you employed within the year of your graduation?'),
          //                               ),
          //                               Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: DropdownMenu(
          //                                   width: 150,
          //                                   hintText: '-Select-',
          //                                   onSelected: (String? value) {
          //                                     setState(() {
          //                                       question2Controller.text =
          //                                           value!;
          //                                     });
          //                                   },
          //                                   dropdownMenuEntries: listOfAnswers2
          //                                       .map((String value) {
          //                                     return DropdownMenuEntry<String>(
          //                                       value: value,
          //                                       label: value,
          //                                     );
          //                                   }).toList(),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         //3rd Question
          //                         QuestionForm(
          //                           content: Column(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.center,
          //                             children: [
          //                               const Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: Text(
          //                                     'How relevant was the program to your job post-graduation?'),
          //                               ),
          //                               Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: DropdownMenu(
          //                                   width: 150,
          //                                   hintText: '-Select-',
          //                                   onSelected: (String? value) {
          //                                     setState(() {
          //                                       question3Controller.text =
          //                                           value!;
          //                                     });
          //                                   },
          //                                   dropdownMenuEntries: listOfAnswers3
          //                                       .map((String value) {
          //                                     return DropdownMenuEntry<String>(
          //                                       value: value,
          //                                       label: value,
          //                                     );
          //                                   }).toList(),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         //4th Question
          //                         QuestionForm(
          //                           content: Column(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.center,
          //                             children: [
          //                               const Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: Text(
          //                                     'Did the program help in applying for your current occupation?'),
          //                               ),
          //                               Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: DropdownMenu(
          //                                   width: 150,
          //                                   hintText: '-Select-',
          //                                   onSelected: (String? value) {
          //                                     setState(() {
          //                                       question4Controller.text =
          //                                           value!;
          //                                     });
          //                                   },
          //                                   dropdownMenuEntries: listOfAnswers4
          //                                       .map((String value) {
          //                                     return DropdownMenuEntry<String>(
          //                                       value: value,
          //                                       label: value,
          //                                     );
          //                                   }).toList(),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         //5th Question
          //                         QuestionForm(
          //                           content: Column(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.center,
          //                             children: [
          //                               const Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: Text(
          //                                     'Did the program provide the necessary skills needed for your current job?'),
          //                               ),
          //                               Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: DropdownMenu(
          //                                   width: 150,
          //                                   hintText: '-Select-',
          //                                   onSelected: (String? value) {
          //                                     setState(() {
          //                                       question5Controller.text =
          //                                           value!;
          //                                     });
          //                                   },
          //                                   dropdownMenuEntries: listOfAnswers5
          //                                       .map((String value) {
          //                                     return DropdownMenuEntry<String>(
          //                                       value: value,
          //                                       label: value,
          //                                     );
          //                                   }).toList(),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         //6th Question
          //                         QuestionForm(
          //                           content: Column(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.center,
          //                             children: [
          //                               const Align(
          //                                 alignment: Alignment.centerLeft,
          //                                 child: Text(
          //                                     'What were the necessary skills you acquired from the program needed for your current job?'),
          //                               ),
          //                               TextFormField(
          //                                 controller: question6Controller,
          //                                 keyboardType: TextInputType.multiline,
          //                                 textInputAction:
          //                                     TextInputAction.newline,
          //                                 maxLines: 2,
          //                                 validator: (value) =>
          //                                     value!.isEmpty && value != null
          //                                         ? 'This field is required'
          //                                         : null,
          //                               )
          //                             ],
          //                           ),
          //                         ),
          //                         const SizedBox(height: 28),
          //                         Button(
          //                           onSubmit: () {
          //                             if (formKey.currentState!.validate()) {
          //                               alumni.alumni.doc(widget.docID).update({
          //                                 'question_1':
          //                                     question1Controller.text,
          //                                 'question_2':
          //                                     question2Controller.text,
          //                                 'question_3':
          //                                     question3Controller.text,
          //                                 'question_4':
          //                                     question4Controller.text,
          //                                 'question_5':
          //                                     question5Controller.text,
          //                                 'question_6':
          //                                     question6Controller.text,
          //                               });
          //                               print(question1Controller.text);
          //                               question1Controller.clear();
          //                               question2Controller.clear();
          //                               question3Controller.clear();
          //                               question4Controller.clear();
          //                               question5Controller.clear();
          //                               question6Controller.clear();
          //                               Navigator.pushReplacement(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                   builder: (context) =>
          //                                       NavigationPage(
          //                                     docID: widget.docID,
          //                                   ),
          //                                 ),
          //                               );
          //                             }
          //                           },
          //                         ),
          //                         SizedBox(
          //                           height: 20,
          //                         ),
          //                       ],
          //                     ),
          //                   )
          //                 //smaller screen
          //                 else
          //                   Column(
          //                     children: [
          //                       //first Question
          //                       QuestionContentSmall(
          //                         constructQuestion:
          //                             'Are you satisfied with your current status?',
          //                         contructFormQuestion: Align(
          //                           alignment: Alignment.centerLeft,
          //                           child: DropdownMenu(
          //                             width: 150,
          //                             hintText: '-Select-',
          //                             onSelected: (String? value) {
          //                               setState(() {
          //                                 question1Controller.text = value!;
          //                               });
          //                               print(question1Controller.text);
          //                             },
          //                             dropdownMenuEntries:
          //                                 listOfAnswers1.map((String value) {
          //                               return DropdownMenuEntry<String>(
          //                                 value: value,
          //                                 label: value,
          //                               );
          //                             }).toList(),
          //                           ),
          //                         ),
          //                       ),
          //                       //second Question
          //                       QuestionContentSmall(
          //                         constructQuestion:
          //                             'Were you employed within the year of your graduation?',
          //                         contructFormQuestion: Align(
          //                           alignment: Alignment.centerLeft,
          //                           child: DropdownMenu(
          //                             width: 150,
          //                             hintText: '-Select-',
          //                             onSelected: (String? value) {
          //                               setState(() {
          //                                 question2Controller.text = value!;
          //                               });
          //                               print(question2Controller.text);
          //                             },
          //                             dropdownMenuEntries:
          //                                 listOfAnswers2.map((String value) {
          //                               return DropdownMenuEntry<String>(
          //                                 value: value,
          //                                 label: value,
          //                               );
          //                             }).toList(),
          //                           ),
          //                         ),
          //                       ),
          //                       //third Question
          //                       QuestionContentSmall(
          //                         constructQuestion:
          //                             'How relevant was the program to your job post-graduation?',
          //                         contructFormQuestion: Align(
          //                           alignment: Alignment.centerLeft,
          //                           child: DropdownMenu(
          //                             width: 150,
          //                             hintText: '-Select-',
          //                             onSelected: (String? value) {
          //                               setState(() {
          //                                 question3Controller.text = value!;
          //                               });
          //                               print(question3Controller.text);
          //                             },
          //                             dropdownMenuEntries:
          //                                 listOfAnswers3.map((String value) {
          //                               return DropdownMenuEntry<String>(
          //                                 value: value,
          //                                 label: value,
          //                               );
          //                             }).toList(),
          //                           ),
          //                         ),
          //                       ),
          //                       //fourth Question
          //                       QuestionContentSmall(
          //                         constructQuestion:
          //                             'Did the program help in applying for your current occupation?',
          //                         contructFormQuestion: Align(
          //                           alignment: Alignment.centerLeft,
          //                           child: DropdownMenu(
          //                             width: 150,
          //                             hintText: '-Select-',
          //                             onSelected: (String? value) {
          //                               setState(() {
          //                                 question4Controller.text = value!;
          //                               });
          //                               print(question4Controller.text);
          //                             },
          //                             dropdownMenuEntries:
          //                                 listOfAnswers4.map((String value) {
          //                               return DropdownMenuEntry<String>(
          //                                 value: value,
          //                                 label: value,
          //                               );
          //                             }).toList(),
          //                           ),
          //                         ),
          //                       ),
          //                       //fifth Question
          //                       QuestionContentSmall(
          //                         constructQuestion:
          //                             'Did the program provide the necessary skills needed for your current job?',
          //                         contructFormQuestion: Align(
          //                           alignment: Alignment.centerLeft,
          //                           child: DropdownMenu(
          //                             width: 150,
          //                             hintText: '-Select-',
          //                             onSelected: (String? value) {
          //                               setState(() {
          //                                 question5Controller.text = value!;
          //                               });
          //                               print(question5Controller.text);
          //                             },
          //                             dropdownMenuEntries:
          //                                 listOfAnswers5.map((String value) {
          //                               return DropdownMenuEntry<String>(
          //                                 value: value,
          //                                 label: value,
          //                               );
          //                             }).toList(),
          //                           ),
          //                         ),
          //                       ),
          //                       //Sixth Question
          //                       QuestionContentSmall(
          //                         constructQuestion:
          //                             'What were the necessary skills you acquired from the program needed for your current job?',
          //                         contructFormQuestion: TextFormField(
          //                           controller: question6Controller,
          //                           keyboardType: TextInputType.multiline,
          //                           textInputAction: TextInputAction.newline,
          //                           maxLines: 2,
          //                           validator: (value) =>
          //                               value!.isEmpty && value != null
          //                                   ? 'This field is required'
          //                                   : null,
          //                         ),
          //                       ),
          //                       const SizedBox(height: 15),
          //                       Button(
          //                         onSubmit: () {
          //                           if (formKey.currentState!.validate()) {
          //                             alumni.alumni.doc(widget.docID).update({
          //                               'question_1': question1Controller.text,
          //                               'question_2': question2Controller.text,
          //                               'question_3': question3Controller.text,
          //                               'question_4': question4Controller.text,
          //                               'question_5': question5Controller.text,
          //                               'question_6': question6Controller.text,
          //                             });
          //                             print(question1Controller.text);
          //                             question1Controller.clear();
          //                             question2Controller.clear();
          //                             question3Controller.clear();
          //                             question4Controller.clear();
          //                             question5Controller.clear();
          //                             question6Controller.clear();
          //                             Navigator.pushReplacement(
          //                               context,
          //                               MaterialPageRoute(
          //                                 builder: (context) => NavigationPage(
          //                                   docID: widget.docID,
          //                                 ),
          //                               ),
          //                             );
          //                           }
          //                         },
          //                       ),
          //                       const SizedBox(height: 28),
          //                     ],
          //                   ),
          //               ],
          //             ),
          //           ),
          //         );
          //       } else {
          //         return Center(child: Text('LOADING FORM...'));
          //       }
          //     }),
        ),
      ),
    );
  }
}





// Actual nightmare
//nightmare

                                  // Column(
                                  //     children: List.generate(
                                  //   _fifthQuestion.length,
                                  //   (index) => CheckboxListTile(
                                  //     contentPadding: const EdgeInsets.all(4),
                                  //     checkboxShape: const CircleBorder(),
                                  //     controlAffinity:
                                  //         ListTileControlAffinity.leading,
                                  //     dense: true,
                                  //     title: Text(
                                  //       _fifthQuestion[index]['answer'],
                                  //       style: const TextStyle(),
                                  //     ),
                                  //     value: _fifthQuestion[index]['value'],
                                  //     onChanged: (value) {
                                  //       setState(() {
                                  //         for (var element in _fifthQuestion) {
                                  //           element['value'] = false;
                                  //         }
                                  //         _fifthQuestion[index]['value'] =
                                  //             value;
                                  //       });
                                  //     },
                                  //   ),
                                  // )),


// final List _firstQuestion = [
//     {'value': false, 'answer': 'yes'},
//     {'value': false, 'answer': 'no'},
//   ];

//   // final List _secondQuestion = [
//   //   {'value': false, 'answer': 'Not relevant at all'},
//   //   {'value': false, 'answer': 'Somewhat relevant'},
//   //   {'value': false, 'answer': 'Very relevant'},
//   // ];

//   final List _thirdQuestion = [
//     {'value': false, 'answer': 'Not helpful at all'},
//     {'value': false, 'answer': 'Somewhat helpful'},
//     {'value': false, 'answer': 'Very helpful'},
//   ];

//   final List _fourthQuestion = [
//     {'value': false, 'answer': 'No'},
//     {'value': false, 'answer': 'Somehow'},
//     {'value': false, 'answer': 'Yes'},
//   ];

//   final List _fifthQuestion = [
//     {'value': false, 'answer': 'Not relevant at all'},
//     {'value': false, 'answer': 'Somewhat relevant'},
//     {'value': false, 'answer': 'Same/very relevant'},
//   ];
