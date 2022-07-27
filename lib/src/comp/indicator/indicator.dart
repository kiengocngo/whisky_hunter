import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        microseconds: 150,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      width: isActive ? 20.0 : 6.0,
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromARGB(255, 133, 177, 213)
            : const Color.fromARGB(255, 228, 196, 196),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
