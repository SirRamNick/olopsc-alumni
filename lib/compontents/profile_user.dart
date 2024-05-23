import 'package:flutter/material.dart';

class ProfileUser extends StatelessWidget {
  final String userDescribe;
  const ProfileUser({
    super.key,
    required this.userDescribe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              userDescribe,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
