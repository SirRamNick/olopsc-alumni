import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget desktopBody;
  final Widget mobileBody;

  const ResponsiveLayout(
      {Key? key, required this.desktopBody, required this.mobileBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1100) {
          return desktopBody;
        } else {
          return mobileBody;
        }
      },
    );
  }
}
