import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:new_imag_post/models/models.dart';
import 'package:new_imag_post/models/post_model.dart';

class DBService {
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final String baseUrl = "jsonplaceholder.typicode.com";
 
 
  static Future<List<PostModel>> getPosts() async {
    final ref = _db.ref("posts");

    final data = await ref.get();
    print("DBService: getPosts: data => ${data.value}");
    final result = <PostModel>[];
    for (var post in data.children) {
      final postModel = PostModel.fromJson(
        Map<String, dynamic>.from(
          post.value as Map,
        ),
      );
      result.add(postModel);
    }
    return result;
  }

  static Future<bool> createPost(PostModel post) async {
    final ref = _db.ref("posts/${post.id}");
  print("DBGService:createPost: createPost => ");
    try {
  print("DBGService:createPost: createPost => ");
      await ref.set(post.toJson());
    } catch (e) {
      print("DBGService:createPost: error => $e");
      return false;
    }
    return true;
  }

static Future<bool> downloadAndUpload()async{
    final userUri = Uri.https(baseUrl,"users");
    try {
      final res = await get(userUri);
      final userMap = json.decode(res.body);
      // print("DBServise: res =============== ${res.body}");
      final userRef = _db.ref("users");
      await userRef.set(userMap);
      // await userRef.push();
      return true;
    } catch (e) {
      print("DBServise: downloadAndUplad===============> $e");
      return false;
    }
  }

  // static Future<bool> updateTodo(int userId, int index,bool completed) async{
  //   try {
  //     final ref = _db.ref("todos/userId $userId/$index");
  //     await ref.update({"completed":completed});
  //     ref.get();
  //     return true;
     
  //   } catch (e) {
  //     print("DBService:updateTodo: error => $e");
  //     return false;
  //   }
  // }

static Future<bool> downloadAndTodos()async{
    final userUri = Uri.https(baseUrl,"todos");
    try {
      final res = await get(userUri);
      final userMap = json.decode(res.body);
      // print("DBServise: res =============== ${res.body}");
      final userRef = _db.ref("todos");
      await userRef.set(userMap);
      // await userRef.push();
      return true;
    } catch (e) {
      print("DBServise: downloadAndUplad===============> $e");
      return false;
    }
  }
static Future<List<Posts>> downloadAndPosts(Map<String,String>params,int id)async{
    final userUri = Uri.https(baseUrl,"posts",params);
    try {
      final res = await get(userUri);
      final userMap = json.decode(res.body);
      // print("DBServise: res =============== ${res.body}");
      final userRef = _db.ref("posts/userId $id");
      await userRef.set(userMap);
      // await userRef.push();
   
      /// GET ///
        final data = await userRef.get();
    final result = <Posts>[];
    for (var post in data.children) {
      final albumModel = Posts.fromJson(
        Map<String, dynamic>.from(
          post.value as Map,
        ),
      );
      result.add(albumModel);
    }
      return result;
    } catch (e) {
      print("DBServise: downloadAndUplad===============> $e");
      return [];
    }
  }
static Future<List<Album>> downloadAndAlbomus(Map<String,String>params,int id)async{
    final userUri = Uri.https(baseUrl,"albums",params);
    try {
      final res = await get(userUri);
      final userMap = json.decode(res.body);
      // print("DBServise: res =============== ${res.body}");
      final userRef = _db.ref("albums/userId $id");
      await userRef.set(userMap);
      // await userRef.push();

      /// GET ///
       final data = await userRef.get();
    final result = <Album>[];
    for (var album in data.children) {
      final albumModel = Album.fromJson(
        Map<String, dynamic>.from(
          album.value as Map,
        ),
      );
      result.add(albumModel);
    }
      return result;
    } catch (e) {
      print("DBServise: downloadAndUplad===============> $e");
      return [];
    }
  }

static Future<List<Todo>> downloadAndTodoUserId(Map<String,String>params,int id)async{
    final userUri = Uri.https(baseUrl,"todos",params);
    try {
      final res = await get(userUri);
      final userMap = json.decode(res.body);
      // print("DBServise: TodoId =============== ${res.body}");
      final userRef = _db.ref("todos/userId $id");
      await userRef.set(userMap);
      ///  GET  ///
      final data = await userRef.get();
    final result = <Todo>[];
    for (var todo in data.children) {
      final todoModel = Todo.fromJson(
        Map<String, dynamic>.from(
          todo.value as Map,
        ),
      );
      result.add(todoModel);
    }
      // await userRef.push();
      return result;
    } catch (e) {
      print("DBServise: downloadAndUplad===============> $e");
      return [];
    }
  }


  static Future<List<Photos>> downloadAndPhotos(Map<String,String>params,int id)async{
    final userUri = Uri.https(baseUrl,"photos",params);
    try {
      final res = await get(userUri);
      final userMap = json.decode(res.body);
      // print("DBServise: res =============== ${res.body}");
      final userRef = _db.ref("photos/albumId $id");
      await userRef.set(userMap);
      // await userRef.push();

      /// GET ///
       final data = await userRef.get();
    final result = <Photos>[];
    for (var photo in data.children) {
      final albumModel = Photos.fromJson(
        Map<String, dynamic>.from(
          photo.value as Map,
        ),
      );
      result.add(albumModel);
    }
      return result;
    } catch (e) {
      print("DBServise: downloadAndUplad===============> $e");
      return [];
    }
  }
  static Future<List<Comment>> downloadAndComments(Map<String,String>params,int id)async{
    final userUri = Uri.https(baseUrl,"comments",params);
    try {
      final res = await get(userUri);
      final userMap = json.decode(res.body);
      // print("DBServise: res =============== ${res.body}");
      final userRef = _db.ref("comments/postId $id");
      await userRef.set(userMap);
      // await userRef.push();
    
      /// GET ///
       final data = await userRef.get();
    final result = <Comment>[];
    for (var coment in data.children) {
      final albumModel = Comment.fromJson(
        Map<String, dynamic>.from(
          coment.value as Map,
        ),
      );
      result.add(albumModel);
    }
      return result;
    } catch (e) {
      print("DBServise: downloadAndUplad===============> $e");
      return [];
    }
  }

  // static Future<List<User>> getUsers() async {
  //   final ref = _db.ref("users");
  //   // final userRef = _db.ref("users");
  //   print("getuser *************************");
  //   // final info = await userRef.orderByChild("id").equalTo("5",key: "id").get();
  //   // print("getuser ---------------------- ${info.value}");
  //   final data = await ref.get();
  //   print("DBService: getUsers: data => ${data.value}");
  //   final user = <User>[]; 
  //   for (var post in data.children) {
  //     final da = User.fromJson(
  //       Map<String, dynamic>.from(
  //         post.value as Map,
  //       ),
  //     );
  //   print("getUsers =====> ${data.children}");
  //     user.add(da);
  //   }
  //   return user;
  // }

   static Future<void> getUser(Function(User) onAdded) async {
    final ref = _db.ref('users');

    ref.onChildAdded.listen((event) {
      print(
          "DBService:getUser: data => ${event.snapshot.value}, eventType => ${event.type}");
      print('----------------------- ${event.snapshot.runtimeType}');
      if (event.snapshot.exists) {
        final user = User.fromJson(
          Map.from(
            event.snapshot.value as Map,
          ),
        );
        onAdded(user);
      }
    });
  }

  static Future<List<Todo>> getTodos() async {
    final ref = _db.ref("todos");

    final data = await ref.get();
    final result = <Todo>[];
    for (var post in data.children) {
      final todoModel = Todo.fromJson(
        Map<String, dynamic>.from(
          post.value as Map,
        ),
      );
      result.add(todoModel);
    }
    return result;
  }
}
