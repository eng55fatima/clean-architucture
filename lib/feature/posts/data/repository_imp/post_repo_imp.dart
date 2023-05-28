import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../data%20source/local%20data%20source/post_local_data_source.dart';
import '../model/post_model.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/repository/post_repo.dart';
import 'package:dartz/dartz.dart';

import '../data source/remote data source/post_remote_data_source.dart';

class PostRepositoryImp implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImp(
      {required this.networkInfo,
      required this.postRemoteDataSource,
      required this.postLocalDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final postsResult = await postRemoteDataSource.getAllPosts();
        postLocalDataSource.cachedPosts(postsResult);
        return Right(postsResult);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getPostsFromCach();
        return Right(localPosts);
      } on EmptyCachException {
        return Left(EmptyCachFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    final PostModel postModel =
        PostModel( title: post.title, body: post.body);

    if (await networkInfo.isConnected) {
      try {
        await postRemoteDataSource.addPost(postModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    if (await networkInfo.isConnected) {
      try {
        await postRemoteDataSource.deletePost(postId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return postRemoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() addOrDeleteOrUpdatePost) async {
    if (await networkInfo.isConnected) {
      try {
        await addOrDeleteOrUpdatePost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
