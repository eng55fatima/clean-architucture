import '../../../domain/entity/post_entity.dart';
import '../../page/post_detail_page.dart';
import 'package:flutter/material.dart';

class PostsListWidget extends StatelessWidget {
  final List<PostEntity> posts;
  const PostsListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              posts[index].id.toString(),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            title: Text(
              posts[index].title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            contentPadding:const EdgeInsets.symmetric(horizontal: 10),
            subtitle: Text(
              posts[index].body,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>PostDetailPage(post: posts[index])));
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
          );
        },
        itemCount: posts.length);
  }
}
