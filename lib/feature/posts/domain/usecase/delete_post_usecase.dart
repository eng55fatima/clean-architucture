


import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repository/post_repo.dart';

class DeletePostUsecase {
  final PostRepository postRepository;

  DeletePostUsecase({required this.postRepository});
  Future<Either<Failure,Unit>> call(int postId) async {
    return await postRepository.deletePost(postId);
  }
}
