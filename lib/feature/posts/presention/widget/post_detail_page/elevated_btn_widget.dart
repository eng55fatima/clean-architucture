import 'package:flutter/material.dart';

class ElevatedBtnWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final ButtonStyle? style;
  final void Function()? onPressed;
  const ElevatedBtnWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.style,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style:
            style,
        onPressed:onPressed,
        icon: Icon(icon),
        label:Text(text));
  }
}
