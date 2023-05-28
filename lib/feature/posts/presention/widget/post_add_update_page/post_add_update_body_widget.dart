import '../../../core/util/loading_widget.dart';
import '../../../core/util/show_snack_bar.dart';
import '../../../domain/entity/post_entity.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../page/post_page.dart';
import 'form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAddUpdateBodyWidget extends StatelessWidget {
  final PostEntity? post;
  final bool isUpdatePost;
  const PostAddUpdateBodyWidget(
      {super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if(state is SuccessAddDeleteUpdatePostState)
            {
              ShowSnackBar().showSuccessOrErrorMessageSnackBar(context, state.message, Colors.green);
             
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
                builder: (_)=>const PostPage()), (route) => false);
            }
           else if(state is ErrorAddDeleteUpdatePostState)
            {
            ShowSnackBar().showSuccessOrErrorMessageSnackBar(context, state.message, Colors.redAccent);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState)
            {
              return const LoadingWidget();
            }
            return FormWidget(isUpdatePost: isUpdatePost,post: post,);
          },
        ),
      ),
    );
  }
}
