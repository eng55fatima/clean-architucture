// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../../../core/string/failure_message.dart';
import '../../../core/string/success_message.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../domain/usecase/addpost_usecase.dart';
import '../../../domain/usecase/delete_post_usecase.dart';
import '../../../domain/usecase/update_post_usecase.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUsecase deletePost;
  AddDeleteUpdatePostBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureAddOrDone = await addPost(event.post);

        emit(_mapFailureOrDoneState(failureAddOrDone, SUCCESS_ADD_POST));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureUpdateOrDone = await updatePost(event.post);

        emit(_mapFailureOrDoneState(failureUpdateOrDone, SUCCESS_UPDATE_POST));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureDeleteOrDone = await deletePost(event.postId);
        emit(_mapFailureOrDoneState(failureDeleteOrDone, SUCCESS_DELETE_POST));
      }
    });
  }
  AddDeleteUpdatePostState _mapFailureOrDoneState(
      Either<Failure, Unit> either, String successMessage) {
    return either.fold(
        (failure) => ErrorAddDeleteUpdatePostState(
              message: _mapFailureToMessage(failure),
            ),
        (_) => SuccessAddDeleteUpdatePostState(message: successMessage));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return DEFAULT_FAILURE_MESSAGE;
    }
  }
}
