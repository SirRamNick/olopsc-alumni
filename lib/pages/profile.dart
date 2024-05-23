import 'package:alumni/compontents/profile_content.dart';
import 'package:alumni/services/firebase.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String docID;
  const Profile({
    super.key,
    required this.docID,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirestoreService alumni = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 210, 49, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 226, 226, 226),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Olopsc Alumni Tracking System (OATS)',
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://lh3.googleusercontent.com/d/1A9nZdV4Y4kXErJlBOkahkpODE7EVhp1x'),
            alignment: Alignment.bottomRight,
            scale: 2.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: StreamBuilder(
                  stream: alumni.alumni.doc(widget.docID).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var value = snapshot.data;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Wrap(
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  'Welcome ${value!['last_name']}, ${value!['first_name']}!',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(230, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: <Widget>[
                                  const Divider(),
                                  const SizedBox(height: 5),
                                  //Profile Information
                                  const Row(
                                    children: [
                                      Text(
                                          textAlign: TextAlign.left,
                                          'Profile information',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Column(
                                    children: [
                                      Wrap(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0))),
                                                child: Text(
                                                  ' ${value['first_name']} ',
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: 0))),
                                                  child: const Text(
                                                    '   First Name   ',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 102, 102, 102),
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0))),
                                                child: Text(
                                                  ' ${value['last_name']}, ',
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: 0))),
                                                  child: const Text(
                                                    '   Last Name   ',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 102, 102, 102),
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0))),
                                                child: Text(
                                                  ' ${value['middle_name']} ',
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: 0))),
                                                  child: const Text(
                                                    '   Middle Name   ',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 102, 102, 102),
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Wrap(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0))),
                                                child: Text(
                                                  ' ${value['degree']} ',
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: 0))),
                                                  child: const Text(
                                                    '   Degree   ',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 102, 102, 102),
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Wrap(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0))),
                                                child: Text(
                                                  ' ${value['email']} ',
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: 0))),
                                                  child: const Text(
                                                    '   Email   ',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 102, 102, 102),
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Wrap(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0))),
                                                child: Text(
                                                  ' ${value['date_of_birth']} ',
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: 0))),
                                                  child: const Text(
                                                    '   Date of birth   ',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 102, 102, 102),
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0))),
                                                child: Text(
                                                  ' ${value['year_graduated']} ',
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: 0))),
                                                  child: const Text(
                                                    '   Year Graduated   ',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 102, 102, 102),
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Wrap(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0))),
                                                child: Text(
                                                  '${value!['employment_status']}',
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: 0))),
                                                  child: const Text(
                                                    '   Employment Status   ',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 102, 102, 102),
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Wrap(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0))),
                                                child: Text(
                                                    ' ${value['occupation']} '),
                                              ),
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  width: 0))),
                                                  child: const Text(
                                                    '   Occupation   ',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 102, 102, 102),
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                          textAlign: TextAlign.left,
                                          'Questions Information',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          'What are the life skills OLOPSC has taught you?',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 102, 102),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ProfileContent(
                                      contentprofile:
                                          '${value!['question_1']}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Column(
                                  //       children: [
                                  //         Row(
                                  //           children: [
                                  //             Expanded(
                                  //               child: Container(
                                  //                 padding: const EdgeInsets.only(
                                  //                     left: 10,
                                  //                     right: 10,
                                  //                     top: 2,
                                  //                     bottom: 2),
                                  //                 decoration: BoxDecoration(
                                  //                     border: Border.all(width: 1)),
                                  //                 child: Expanded(
                                  //                   child: Text(
                                  //                       textAlign: TextAlign.left,
                                  //                       maxLines: 2,
                                  //                       '${value!['question_1']}'),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          'The skills you\'ve mentioned helped you in pursuing your career path.',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 102, 102),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 2,
                                              bottom: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)),
                                          child: Text(
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              '${value!['question_2']}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          'Your first job aligns with your current job.',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 102, 102),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 2,
                                              bottom: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)),
                                          child: Text(
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              '${value!['question_3']}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          'How long does it take for you to land your first job after graduation?',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 102, 102),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 2,
                                              bottom: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)),
                                          child: Text(
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              '${value!['question_4']}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          'The program you took in OLOPSC matches your current job.',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 102, 102),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 2,
                                              bottom: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)),
                                          child: Text(
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              '${value!['question_5']}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          'You are satisfied with your current job.',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 102, 102),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 2,
                                              bottom: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)),
                                          child: Text(
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              '${value!['question_6']}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                      // return SingleChildScrollView(
                      //   child: Row(children: [
                      //     Expanded(
                      //       child: Container(
                      //         padding: EdgeInsets.all(20),
                      //         margin: EdgeInsets.all(20),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(15),
                      //           color: Color.fromRGBO(15, 10, 95, 1),
                      //         ),
                      //         child: Wrap(
                      //           spacing: 8.0,
                      //           runSpacing: 4.0,
                      //           children: [
                      //             Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 //Welcoming Message
                      //                 Wrap(
                      //                   spacing: 8.0,
                      //                   runSpacing: 4.0,
                      //                   children: <Widget>[
                      //                     Align(
                      //                       child: Align(
                      //                         alignment: Alignment.center,
                      //                         child: Text(
                      //                             'Welcome ${value!['last_name']}, ${value!['first_name']}!',
                      //                             style: TextStyle(
                      //                                 color: const Color.fromRGBO(
                      //                                     255, 210, 49, 1),
                      //                                 fontWeight: FontWeight.bold,
                      //                                 fontSize: 30)),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 const SizedBox(
                      //                   height: 30,
                      //                 ),
                      //                 Row(
                      //                   children: [
                      //                     //name
                      //                     Column(
                      //                       children: [
                      //                         Align(
                      //                           alignment: Alignment.centerLeft,
                      //                           child: Text('Name',
                      //                               maxLines: 2,
                      //                               style: TextStyle(
                      //                                   color:
                      //                                       const Color.fromRGBO(
                      //                                           255, 210, 49, 1),
                      //                                   fontWeight:
                      //                                       FontWeight.bold,
                      //                                   fontSize: 16)),
                      //                         ),
                      //                         Align(
                      //                           alignment: Alignment.centerLeft,
                      //                           child: ProfileUser(
                      //                               userDescribe:
                      //                                   '${value!['first_name']} ${value!['middle_name']} ${value!['last_name']}'),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                     //sex
                      //                     Column(
                      //                       children: [
                      //                         Align(
                      //                           alignment: Alignment.centerLeft,
                      //                           child: Text('Sex',
                      //                               maxLines: 2,
                      //                               style: TextStyle(
                      //                                   color:
                      //                                       const Color.fromRGBO(
                      //                                           255, 210, 49, 1),
                      //                                   fontWeight:
                      //                                       FontWeight.bold,
                      //                                   fontSize: 16)),
                      //                         ),
                      //                         Align(
                      //                           alignment: Alignment.centerLeft,
                      //                           child: ProfileUser(
                      //                               userDescribe:
                      //                                   '${value!['sex']}'),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                     //year graduated
                      //                     Column(
                      //                       children: [
                      //                         Align(
                      //                           alignment: Alignment.centerLeft,
                      //                           child: Text('Year Graduated',
                      //                               maxLines: 2,
                      //                               style: TextStyle(
                      //                                   color:
                      //                                       const Color.fromRGBO(
                      //                                           255, 210, 49, 1),
                      //                                   fontWeight:
                      //                                       FontWeight.bold,
                      //                                   fontSize: 16)),
                      //                         ),
                      //                         Align(
                      //                           alignment: Alignment.centerLeft,
                      //                           child: ProfileUser(
                      //                               userDescribe:
                      //                                   '${value!['year_graduated']}'),
                      //                         ),
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //                 //name of alumni

                      //                 //sex

                      //                 // program

                      //                 // year graduated

                      //                 //employment status

                      //                 // email adress
                      //                 Align(
                      //                   child: Align(
                      //                     alignment: Alignment.centerLeft,
                      //                     child: Text(
                      //                         'Are you satisfied with your current status?',
                      //                         maxLines: 2,
                      //                         style: TextStyle(
                      //                             color: const Color.fromRGBO(
                      //                                 255, 210, 49, 1),
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 16)),
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: ProfileContent(
                      //                       contentprofile: value!['email']),
                      //                 ),
                      //                 //question 1
                      //                 Align(
                      //                   child: Align(
                      //                     alignment: Alignment.centerLeft,
                      //                     child: Text(
                      //                         'Are you satisfied with your current status?',
                      //                         maxLines: 2,
                      //                         style: TextStyle(
                      //                             color: const Color.fromRGBO(
                      //                                 255, 210, 49, 1),
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 16)),
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: ProfileContent(
                      //                       contentprofile: value!['question_1']),
                      //                 ),
                      //                 //question 2
                      //                 Align(
                      //                   child: Align(
                      //                     alignment: Alignment.centerLeft,
                      //                     child: Text(
                      //                         'Were you employed within the year of your graduation?',
                      //                         maxLines: 2,
                      //                         style: TextStyle(
                      //                             color: const Color.fromRGBO(
                      //                                 255, 210, 49, 1),
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 16)),
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: ProfileContent(
                      //                       contentprofile: value!['question_2']),
                      //                 ),
                      //                 //question 3
                      //                 Align(
                      //                   child: Align(
                      //                     alignment: Alignment.centerLeft,
                      //                     child: Text(
                      //                         'How relevant was the program to your job post-graduation?',
                      //                         maxLines: 2,
                      //                         style: TextStyle(
                      //                             color: const Color.fromRGBO(
                      //                                 255, 210, 49, 1),
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 16)),
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: ProfileContent(
                      //                       contentprofile: value!['question_3']),
                      //                 ),
                      //                 //question 4
                      //                 Align(
                      //                   child: Align(
                      //                     alignment: Alignment.centerLeft,
                      //                     child: Text(
                      //                         'Did the program help in applying for your current occupation?',
                      //                         maxLines: 2,
                      //                         style: TextStyle(
                      //                             color: const Color.fromRGBO(
                      //                                 255, 210, 49, 1),
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 16)),
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: ProfileContent(
                      //                       contentprofile: value!['question_4']),
                      //                 ),
                      //                 //question 5
                      //                 Align(
                      //                   child: Align(
                      //                     alignment: Alignment.centerLeft,
                      //                     child: Text(
                      //                         'Did the program provide the necessary skills needed for your current job?',
                      //                         maxLines: 2,
                      //                         style: TextStyle(
                      //                             color: const Color.fromRGBO(
                      //                                 255, 210, 49, 1),
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 16)),
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: ProfileContent(
                      //                       contentprofile: value!['question_5']),
                      //                 ),
                      //                 //question 6
                      //                 Align(
                      //                   child: Align(
                      //                     alignment: Alignment.centerLeft,
                      //                     child: Text(
                      //                         'What were the necessary skills you acquired from the program needed for your current job?',
                      //                         maxLines: 2,
                      //                         style: TextStyle(
                      //                             color: const Color.fromRGBO(
                      //                                 255, 210, 49, 1),
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 16)),
                      //                   ),
                      //                 ),
                      //                 Align(
                      //                   alignment: Alignment.centerLeft,
                      //                   child: ProfileContent(
                      //                       contentprofile: value!['question_6']),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ]),
                      // );
                    } else {
                      return const Text('Loading Data');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
