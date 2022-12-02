import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:new_imag_post/models/models.dart';
import 'package:new_imag_post/pages/photos.dart';
import 'package:new_imag_post/pages/posts1.dart';
import 'package:new_imag_post/pages/users.dart';
import 'package:new_imag_post/servis/db_servise.dart';
import 'package:new_imag_post/servis/network.dart';

class MyUserName extends StatefulWidget {
  String name;
  int userId;
  // List<Todo> todo;
  MyUserName({super.key, required this.name, required this.userId});

  @override
  State<MyUserName> createState() => _MyUserNameState(name, userId);
}

class _MyUserNameState extends State<MyUserName> {
  String name;
  int userId;

  List<Todo> todo = [];
  List<Album> album = [];
  List<Posts> post = [];

  _MyUserNameState(this.name, this.userId);

  bool iconSet = true;

  @override
  void initState() {
    DBService.downloadAndTodoUserId({"userId": "$userId"}, userId)
        .then((value) {
      setState(() {
        todo = value;
      });
    });
    DBService.downloadAndAlbomus({"userId": "$userId"}, userId).then((value) {
      setState(() {
        album = value;
      });
    });
    DBService.downloadAndPosts({"userId": "$userId"}, userId).then((value) {
      setState(() {
        post = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          title: Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text("Todo"),
              ),
              Tab(
                child: Text("Alboms"),
              ),
              Tab(
                child: Text("Post"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _Container1(),
            _Container2(),
            _Container3(),
          ],
        ),
      ),
    );
  }

  Widget _circprogres() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  _Container1() {
    return Container(
      color: Colors.grey.shade800,
      child: todo.isNotEmpty == false
          ? LottieBuilder.asset("assets/Lottie_Animation.json")
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  todo.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(
                            left: 12, top: 8, bottom: 6, right: 10),
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "userId: $userId",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "id: ${todo[index].id}",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "title: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 240,
                                      child: Text(
                                        todo[index].title ?? "no title",
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    // DBService.updateTodo(
                                    //   userId,
                                    //   index,
                                    //   todo[index].completed == true
                                    //       ? false
                                    //       : true,
                                    // );

                                  },
                                  splashRadius: 16,
                                  splashColor: Colors.black,
                                  icon: Icon(
                                    todo[index].completed ?? false
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                  ),
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  _Container2() {
    return Container(
      color: Colors.blueGrey,
      child: album.isNotEmpty == false
          ? LottieBuilder.asset("assets/Lottie_Animation.json")
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  album.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => MyPhotos(
                                albumId: album[index].id ?? -1, name: name),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, top: 12, bottom: 16, right: 10),
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "userId: $userId",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "id: ${album[index].id}",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Name:  ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 240,
                                    child: Text(
                                      album[index].title ?? "no title",
                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  _Container3() {
    return Container(
      color: Colors.green,
      child: post.isNotEmpty == false
          ? LottieBuilder.asset("assets/Lottie_Animation.json")
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                  post.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => MyPosts1(
                              id1: post[index].id ?? -1,
                              userId: userId,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, top: 6, bottom: 4, right: 10),
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "userId: $userId",
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "id: ${post[index].id}",
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "title:  ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 240,
                                    child: Text(
                                      post[index].title ?? "no title",
                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "body:  ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 240,
                                    child: Text(
                                      post[index].body ?? "no title",
                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
