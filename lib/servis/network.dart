import 'dart:convert';
import 'package:http/http.dart';
import 'package:new_imag_post/models/models.dart';

class Network {
  static String baseUrl = "jsonplaceholder.typicode.com";
  static Map<String, String> headers = {
    "Content-Type": "applicaton/json; charset=UTF-8"
  };

  // Http endpoint

  static String appiList = "/posts";
  static String apiComment = "/comments";
  static String apiUsers = "/users";
  static String apiCreate = "/posts";
  static String apiUpdate = "/posts/"; //{id}
  static String apiDelete = "/posts/"; //{id}

  static String apiPost = "posts";
  static String apiAlbum = "/albums";
  static String apiPhoto = "photos";
  static String apiTodo = "todos";
  static String apiUser = "users";

  // HTTP requests

  static Future<String?> getData(String api, Map<String, String> params) async {
    final uri = Uri.https(baseUrl, api, params);
    // print("dd:$uri");
    final response = await get(uri, headers: headers);
    // print(response);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<List<Comment>?> getUsers(
      String api, Map<String, String> params) async {
    final uri = Uri.https(baseUrl, api, params);
    // print(uri);
    final response = await get(uri, headers: headers);
    // print(response);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.map<Comment>((element) {
        return Comment.fromJson(element);
      }).toList();
    }
    return null;
  }

  static Future<List<User>?> getUser(
      String api, Map<String, String>? params) async {
    final uri = Uri.https(baseUrl, api, params);
    final response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.map<User>((element) {
        return User.fromJson(element);
      }).toList();
    }
    return null;
  }

  static Future<List<Todo>?> getTodo(
      String api, Map<String, String>? params) async {
    final uri = Uri.https(baseUrl, api, params);
    final response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.map<Todo>((element) {
        return Todo.fromJson(element);
      }).toList();
    }
    return null;
  }

  static Future<List<Comment>?> getComment(
      String api, Map<String, String>? params) async {
    final uri = Uri.https(baseUrl, api, params);
    final response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.map<Comment>((element) {
        return Comment.fromJson(element);
      }).toList();
    }
    return null;
  }

  static Future<List<Album>?> getAlbums(
      String api, Map<String, String>? params) async {
    final uri = Uri.https(baseUrl, api, params);
    final response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.map<Album>((element) {
        return Album.fromJson(element);
      }).toList();
    }
    return null;
  }

  static Future<List<Photos>?> getPhoto(
      String api, Map<String, String>? params) async {
    final uri = Uri.https(baseUrl, api, params);
    final response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.map<Photos>((element) {
        return Photos.fromJson(element);
      }).toList();
    }
    return null;
  }

  static Future<List<Posts>?> getPosts(
      String api, Map<String, String>? params) async {
    final uri = Uri.https(baseUrl, api, params);
    final response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.map<Posts>((element) {
        return Posts.fromJson(element);
      }).toList();
    }
    return null;
  }

  static Future<String?> postData(
      String api, Map<String, dynamic> params) async {
    final uri = Uri.https(baseUrl, api);
    final response =
        await post(uri, body: json.encode(params), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> putData(
      String api, Map<String, dynamic> params) async {
    final uri = Uri.https(baseUrl, api);
    final response =
        await put(uri, body: json.encode(params), headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> patchData(
      String api, Map<String, dynamic> params, int id) async {
    final uri = Uri.https(baseUrl, "$api/$id");
    final response =
        await patch(uri, body: json.encode(params), headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
}
