import 'package:flutter/material.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class TMButton extends StatefulWidget {
  final String content;
  final VoidCallback onTap;
  const TMButton({Key? key, required this.content, required this.onTap})
      : super(key: key);

  @override
  State<TMButton> createState() => _TMButtonState();
}

class _TMButtonState extends State<TMButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            widget.content,
            style: TMThemeData.fromContext(context).text_16_500,
          ),
        ),
      ),
    );
  }
}
