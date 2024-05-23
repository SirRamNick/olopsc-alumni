import 'package:flutter/material.dart';

class OlopscForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final Widget subTitle;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  // final Function(String?) onChanged;
  const OlopscForm({
    super.key,
    required this.subTitle,
    required this.textEditingController,
    required this.suffixIcon,
    // required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          errorMaxLines: 3,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
          label: subTitle,
        ),
        validator: validator,
      ),
    );
  }
}
