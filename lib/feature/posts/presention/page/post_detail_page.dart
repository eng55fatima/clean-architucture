import 'package:flutter/material.dart';

import '../../domain/entity/post_entity.dart';

import '../widget/post_detail_page/buidl_body_detail_page.dart';

class PostDetailPage extends StatelessWidget {
  final PostEntity post;
  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),

      body: BuildBodyDetailPage(post:post),
    );
  }

  AppBar _buildAppBar() => AppBar(title:const Text('Post Detail'),);
}
