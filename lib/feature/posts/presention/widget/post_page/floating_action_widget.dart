import 'package:flutter/material.dart';

import '../../page/post_add_update_page.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostAddUpdatePage(isUpdatePost: false)));
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
