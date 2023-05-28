import 'package:flutter/material.dart';

import '../widget/post_page/build_body_widget.dart';
import '../widget/post_page/floating_action_widget.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts App'),
      ),
      body: const BuildBodyWidget(),
      floatingActionButton: const FloatingActionButtonWidget(),
    );
  }
}
