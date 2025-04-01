import 'package:flutter/cupertino.dart';

enum PageRouteDirection {
  inFromRight,
  inFromBottom,
}

extension CommonPageRouteAnination on Object {
  static const transitionDuration = 300;

  Future pushPage(BuildContext context, StatefulWidget nextPage,
      [PageRouteDirection direction = PageRouteDirection.inFromRight]) {
    return Navigator.of(context).push(pageRouteBuilder(context, nextPage, direction));
  }

  Future pushReplacement(BuildContext context, StatefulWidget nextPage,
      [PageRouteDirection direction = PageRouteDirection.inFromRight]) {
    return Navigator.of(context).pushReplacement(pageRouteBuilder(context, nextPage, direction));
  }

  Future pushAndRemoveUntilPage(BuildContext context, StatefulWidget nextPage,
      [RoutePredicate? predicate,PageRouteDirection direction = PageRouteDirection.inFromRight]) {
    return Navigator.of(context)
        .pushAndRemoveUntil(pageRouteBuilder(context, nextPage), predicate ?? (Route<dynamic> route) => false);
  }

  PageRouteBuilder pageRouteBuilder(BuildContext context, StatefulWidget nextPage,
      [PageRouteDirection direction = PageRouteDirection.inFromRight]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => (nextPage),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;
        switch (direction) {
          case PageRouteDirection.inFromRight:
            begin = const Offset(1.0, 0.0);
            break;
          case PageRouteDirection.inFromBottom:
            begin = const Offset(0.0, 1.0);
        }
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: transitionDuration),
    );
  }
}
