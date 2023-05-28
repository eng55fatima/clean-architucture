import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLine;
  final String name;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.multiLine,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "$name Can't be empty" : null,
        decoration: InputDecoration(hintText: name),
        minLines: multiLine ? 6 : 1,
        maxLines: multiLine ? 6 : 1,
      ),
    );
  }
}
