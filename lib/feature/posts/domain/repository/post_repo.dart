import '../../core/error/failure.dart';
import '../entity/post_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {

  Future<Either<Failure,List<PostEntity>>> getAllPosts();
  Future<Either<Failure,Unit>> addPost(PostEntity post);
  Future<Either<Failure,Unit>> updatePost(PostEntity post);
  Future<Either<Failure,Unit>> deletePost(int postId);
}
