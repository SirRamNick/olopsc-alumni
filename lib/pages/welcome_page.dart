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
      backgroundColor: const Color(0xFFFFD231),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildAnimatedMessage(),
            _buildGetStartedButton(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFFD231),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OLOPSC Alumni Form',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 4),
          Text(
            'OLOPSC Alumni Tracking System (OATS)',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Image.network(
            'https://lh3.googleusercontent.com/d/1DlDDvI0eIDivjwvCrngmyKp_Yr6d8oqH',
            scale: 1.5,
          ),
          const SizedBox(height: 12),
          const Text(
            'Our Lady of Perpetual Succor College',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Alumni Tracking System',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Made By: '),
              Opacity(
                opacity: 0.9,
                child: Image.network(
                  'https://lh3.googleusercontent.com/d/1VDWlFOEyS-rftjzmy1DtWYNf5HvDSDq3',
                  scale: 39.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'Welcome, Alumni!',
            textAlign: TextAlign.center,
            textStyle:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          TyperAnimatedText(
            'By answering this Alumni Form, you agree to share your information with the OLOPSC Alumni Tracking System.'
            '\nThe data will be used to evaluate the effectiveness of OLOPSC programs since 2002.'
            '\nAll information will be treated with strict confidentiality.'
            '\nTo proceed, click the button below.',
            textAlign: TextAlign.center,
            textStyle: const TextStyle(fontSize: 16),
            speed: const Duration(milliseconds: 30),
          ),
        ],
        pause: const Duration(milliseconds: 2000),
        isRepeatingAnimation: false,
        displayFullTextOnTap: true,
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B0A5F),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        child: const Text(
          'Get Started',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
