import '../../../core/util/loading_widget.dart';
import '../../../core/util/message_display_widget.dart';
import '../../bloc/posts/posts_bloc.dart';
import 'posts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/get_it.dart' as di;
import 'package:logger/logger.dart';

class BuildBodyWidget extends StatelessWidget {
  const BuildBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostsListWidget(posts: state.posts));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }

          return const LoadingWidget();
        }));
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
    di.getIt<Logger>().wtf('add refresh  posts done......');
  }
}
