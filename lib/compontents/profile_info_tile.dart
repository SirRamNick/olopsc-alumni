import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoTile({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value.isNotEmpty ? value : 'Not Provided',
              style: TextStyle(
                fontSize: 16,
                color: value.isNotEmpty ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
