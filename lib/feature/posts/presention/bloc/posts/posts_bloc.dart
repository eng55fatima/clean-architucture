// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import '../../../core/error/failure.dart';
import '../../../core/string/failure_message.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../domain/usecase/get_all_posts_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final postsOrfailuer = await getAllPosts();
        emit(_mapFailureOrPostState(postsOrfailuer));
        // postsOrfailuer.fold((failure) {
        //   emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
        // }, (posts) {
        //   emit(LoadedPostsState(posts: posts));
        // });
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final postsOrfailuer = await getAllPosts();
        emit(_mapFailureOrPostState(postsOrfailuer));
        // postsOrfailuer.fold((failure) {
        //   emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
        // }, (posts) {
        //   emit(LoadedPostsState(posts: posts));
        // });
      }
    });
  }

  PostsState _mapFailureOrPostState(Either<Failure, List<PostEntity>> either) {
    return either.fold(
        (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCachFailure:
        return EMPTY_CACH_FAILURE_MESSAGE;

      default:
        return DEFAULT_FAILURE_MESSAGE;
    }
  }
}
