import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
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
            alignment: Alignment.bottomRight,
            scale: 2.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.all(30),
                            margin: const EdgeInsets.all(50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(218, 255, 255, 255),
                            ),
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: <Widget>[
                                Column(
                                  children: [
                                    const Text(
                                      textAlign: TextAlign.center,
                                      "About OLOPSC Alumni Tracking System",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color.fromRGBO(11, 10, 95, 1)),
                                    ),
                                    const SizedBox(height: 13),
                                    const Text(
                                      textAlign: TextAlign.center,
                                      "The purpose of developing the  OLOPSC Alumni Tracking System(OATS) is to provide a platform that allows the College to keep track of the progress of the alumni upon graduating. ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 13),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              textAlign: TextAlign.center,
                                              "Creators of Olopsc Alumni Tracking System",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(
                                                      11, 10, 95, 1))),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    const Text(
                                      "Team Adviser/Developer",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Text(
                                      "Rame Nicholas Tiongson",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "System Analyst/Developer",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Text(
                                      "Angelica Kristianne G. Pre",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "System Designer",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Text(
                                      "Maria Christina C. Salvador",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "System Developer",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Text(
                                      "Christian S. Gadiano",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "Documentation Specialist",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Text(
                                      "Aiza C. Caballero",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 15),
                                    const Text(
                                      "(c) OLOPSC Computer Society 2024",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const Text(
                                      "All rights reserved",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Image.network(
                                        height: 30,
                                        width: 30,
                                        'https://lh3.googleusercontent.com/d/1sq-wq-6VWSD6zMVU5QC6Uv1aT9mVbm-E',
                                      ),
                                    ),
                                    const Text(
                                      "OLOPSC Computer Society",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
