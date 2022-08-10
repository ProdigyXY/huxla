import 'package:flutter/material.dart';

class SlideFromBottomAsModal extends PageRouteBuilder {
  SlideFromBottomAsModal({@required this.page, RouteSettings settings})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                        parent: animation, curve: Curves.fastOutSlowIn),
                  ),
                  child: page),
        );

  final Widget page;
}
