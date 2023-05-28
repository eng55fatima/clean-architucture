// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:clean_architecture/feature/posts/core/error/exception.dart';
import 'package:clean_architecture/feature/posts/data/model/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel post);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> deletePost(int postId);
}

const String BASE_URL = 'https://jsonplaceholder.typicode.com';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse('$BASE_URL/posts/'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      List decodedJson = jsonDecode(response.body) as List;

      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonData) => PostModel.fromJson(jsonData))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final Map<String, dynamic> body = {'title': post.title, 'body': post.body};
    final response =
        await client.post(Uri.parse('$BASE_URL/posts/'), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(Uri.parse('$BASE_URL/posts/$postId'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final int? postId = post.id;
    final Map<String, dynamic> body = {'title': post.title, 'body': post.body};
    final response =
        await client.patch(Uri.parse('$BASE_URL/posts/$postId'), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
