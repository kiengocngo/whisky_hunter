import 'package:flutter/material.dart';
import 'package:whisky_hunter/src/ui/search/search_slug_screen.dart';

Route createRoutToPage() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SearchSlugScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}
