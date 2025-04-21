import 'dart:convert';

import 'package:http/http.dart';
import 'package:info/config/network/network_config.dart';
import 'package:info/models/user.dart';

class UserHttpService {
  // Private constructor
  UserHttpService._();

  // Singleton instance
  static final UserHttpService shared = UserHttpService._();

  Future<List<User>> getUsers() async {
    final String url = NetworkConfig.shared.getUserPostUrl();
    Response res = await get(Uri.parse(url));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> posts = body
        .map(
          (dynamic item) => User.fromJson(item),
        )
        .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<User>> getUserById(String id) async {
    final String url = "${NetworkConfig.shared.getUserPostUrl()}?id=$id";
    // Response res = await post(Uri.parse(url), headers: NetworkConfig.shared.getHeaders(), body: jsonEncode({"id":id}));// Add id as a query parameter
    Response res = await get(Uri.parse(url)); // Use GET instead of POST
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> posts = body
        .map(
          (dynamic item) => User.fromJson(item),
        )
        .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}