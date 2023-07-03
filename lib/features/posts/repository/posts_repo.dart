import 'dart:developer';

import 'package:flutter_bloc_api_call/features/posts/models/post_data_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostDataModel>> getPosts() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      return postDataModelFromJson(response.body);
    } catch (e) {
      client.close();
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPosts() async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": 'foo',
        "body": 'bar',
        "userId": "1",
      });
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      client.close();
      log(e.toString());
      return false;
    }
  }
}
