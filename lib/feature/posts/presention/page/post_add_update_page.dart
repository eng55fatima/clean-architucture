import '../../domain/entity/post_entity.dart';
import '../widget/post_add_update_page/post_add_update_body_widget.dart';
import 'package:flutter/material.dart';

class PostAddUpdatePage extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
  body: PostAddUpdateBodyWidget(isUpdatePost:isUpdatePost,post:isUpdatePost?post:null),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      title: Text(isUpdatePost ? "Edit Page" : "Add Page"),
      centerTitle: true,
    );
  }
}
