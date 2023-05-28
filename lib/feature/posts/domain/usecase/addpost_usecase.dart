import '../entity/post_entity.dart';
import '../repository/post_repo.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

class AddPostUseCase{
  final PostRepository postRepository;

  AddPostUseCase({required this.postRepository});

 Future<Either<Failure,Unit>> call(PostEntity post) async{

    return await postRepository.addPost(post);
  }
  
}