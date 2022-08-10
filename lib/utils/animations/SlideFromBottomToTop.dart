import 'package:flutter/material.dart';

class SlideFromBottomToTop extends PageRouteBuilder {
  SlideFromBottomToTop(
      {@required this.nextPage,
      @required this.prevPage,
      RouteSettings settings})
      : super(
          transitionDuration: const Duration(milliseconds: 750),
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => nextPage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset.zero,
                    end: const Offset(0.0, -1.0),
                  ).animate(
                    CurvedAnimation(
                        parent: animation, curve: Curves.fastOutSlowIn),
                  ),
                  child: prevPage),
              SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                        parent: animation, curve: Curves.fastOutSlowIn),
                  ),
                  child: nextPage),
            ],
          ),
        );

  final Widget nextPage;
  final Widget prevPage;
}
