import 'package:flutter/material.dart';

class ElevatedFormSubmitWidget extends StatelessWidget {
  final bool isUpdatePost;
  final void Function() onPressed;

  const ElevatedFormSubmitWidget({
    Key? key,
    required this.isUpdatePost,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(isUpdatePost ? Icons.edit : Icons.add),
        label: Text(isUpdatePost ? "Update" : "Add"));
  }
}
