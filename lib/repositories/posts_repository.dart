import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostsRepository {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/posts'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
