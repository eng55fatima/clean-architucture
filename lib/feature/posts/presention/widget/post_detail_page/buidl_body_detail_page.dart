import 'package:flutter/material.dart';

import '../../../domain/entity/post_entity.dart';
import 'post_detail_widget.dart';

class BuildBodyDetailPage extends StatelessWidget {
  final PostEntity post;
  const BuildBodyDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: PostDetailWidget(post:post),
      ),
    );
  }
}
