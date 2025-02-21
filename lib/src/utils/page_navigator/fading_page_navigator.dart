import 'package:flutter/material.dart';

void fadingPageNavigator(
  BuildContext context,
  Widget screen,
  bool replace,
) {
  (replace)
      ? Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => screen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return fadingTransition(animation, child);
            },
            transitionDuration: Duration(milliseconds: 700),
          ),
        )
      : Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => screen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return fadingTransition(animation, child);
            },
            transitionDuration: Duration(milliseconds: 700),
          ),
        );
}

Widget fadingTransition(Animation<double> animation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}
