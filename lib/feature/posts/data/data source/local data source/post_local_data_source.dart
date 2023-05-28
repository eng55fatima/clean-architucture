// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:clean_architecture/feature/posts/core/error/exception.dart';
import 'package:clean_architecture/feature/posts/data/model/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getPostsFromCach();
  Future<Unit> cachedPosts(List<PostModel> postsList);
}

class PostLocalDataSourceImp implements PostLocalDataSource {
  final SharedPreferences sharedPref;
  final String CACHED_POST_KEY = 'CACHED_POST';
  PostLocalDataSourceImp({required this.sharedPref});

  @override
  Future<Unit> cachedPosts(List<PostModel> postsList) {

    final List listPostsToJson = postsList
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();

    sharedPref.setString(CACHED_POST_KEY, jsonEncode(listPostsToJson));

    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getPostsFromCach() {

    final jsonString = sharedPref.getString(CACHED_POST_KEY);

    if (jsonString != null) {
      final List decodeJsonData = jsonDecode(jsonString);

      final List<PostModel> jsonToPostsModelList = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostsModelList);
    }
    else{
      throw EmptyCachException();
    }
  }
}
