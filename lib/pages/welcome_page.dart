import 'dart:html';
import 'package:alumni/pages/home_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

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
            alignment: Alignment.bottomLeft,
            scale: 2.5,
            opacity: 0.8,
          ),
        ),
        child: Column(
          children: <Widget>[
            //start
            Expanded(
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              //end
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.only(top: 25, left: 20.0, right: 20.0),
                  alignment: Alignment.topCenter,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Welcome, Alumni!',
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      TyperAnimatedText(
                          'By answering this Alumni Form, you have agreed to share your information to the OLOPSC ALUMNI TRACKING SYSTEM.'
                          '\nThe data will be used to determine the effectiveness of the programs offered by OLOPSC starting from the year 2002.'
                          '\nThe data received will be treated with the utmost confidentiality.\nTo answer the form, click the button below.',
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 30,
                          ),
                          speed: Duration(milliseconds: 30)),
                    ],
                    pause: Duration(milliseconds: 3000),
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 385),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    const Color.fromRGBO(11, 10, 95, 1),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
