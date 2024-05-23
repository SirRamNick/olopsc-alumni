import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  final String contentprofile;
  const ProfileContent({super.key, required this.contentprofile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Text(contentprofile),
          ],
        ),
      ),
    );
  }
}
