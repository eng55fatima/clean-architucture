import 'feature/posts/core/app_theme.dart';
import 'feature/posts/presention/page/post_page.dart';
import 'package:flutter/material.dart';
import 'feature/posts/di/get_it.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/posts/presention/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'feature/posts/presention/bloc/posts/posts_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.getIt<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.getIt<AddDeleteUpdatePostBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Posts App',
        theme: appTheme,
        home: const PostPage(),
      ),
    );
  }
}
