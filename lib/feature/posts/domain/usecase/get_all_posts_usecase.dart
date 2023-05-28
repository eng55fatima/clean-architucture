import '../repository/post_repo.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entity/post_entity.dart';

class GetAllPostsUsecase {
  final PostRepository postRepository;

  GetAllPostsUsecase({required this.postRepository});
  Future<Either<Failure, List<PostEntity>>> call() async {
    return await postRepository.getAllPosts();
  }
}
