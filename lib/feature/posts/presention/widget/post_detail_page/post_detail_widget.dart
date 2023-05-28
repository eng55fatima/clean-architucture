import '../../../core/util/loading_widget.dart';
import '../../../core/util/show_snack_bar.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../page/post_page.dart';
import 'delete_dialog_widget.dart';
import 'elevated_btn_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/post_entity.dart';
import '../../page/post_add_update_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailWidget extends StatelessWidget {
  final PostEntity post;
  const PostDetailWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedBtnWidget(
                icon: Icons.edit,
                text: "Edit",
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PostAddUpdatePage(
                              isUpdatePost: true,
                              post: post,
                            ))),
              ),
              ElevatedBtnWidget(
                  icon: Icons.delete_outline,
                  text: "Delete",
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () => deleteDialog(context)),
            ],
          )
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is SuccessAddDeleteUpdatePostState) {
                ShowSnackBar().showSuccessOrErrorMessageSnackBar(
                    context, state.message, Colors.green);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const PostPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop();
                ShowSnackBar().showSuccessOrErrorMessageSnackBar(
                    context, state.message, Colors.red);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const AlertDialog(
                  title:  LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: post.id!);
            },
          );
        });
  }
}
