import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:new_imag_post/models/models.dart';
import 'package:new_imag_post/servis/db_servise.dart';
import 'package:new_imag_post/servis/network.dart';

class MyPosts1 extends StatefulWidget {
  int id1;
  int userId;
  int index;
  MyPosts1({
    super.key,
    required this.id1,
    required this.userId,
    required this.index,
  });

  @override
  State<MyPosts1> createState() => _MyPosts1State( id1,userId,index);
}

class _MyPosts1State extends State<MyPosts1> {
  int id1;
  int userId;
  int index;
  _MyPosts1State( this.id1,this.userId,this.index);

  List<Comment> coment = [];
  List<Posts> posts = [];

  bool comentIcon = true;

  @override
  void initState() {
    DBService.downloadAndPosts({"userId": "$userId"}, userId).then((value) {
      setState(() {
        posts = value;
      });
    });
    DBService.downloadAndComments({"postId": "$id1"},id1).then((value) {
      setState(() {
        coment = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.orange,
       foregroundColor: Colors.black,
        title: posts.isNotEmpty == false
            ? const Text(
                "No Posts",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              )
            : const Text(
                "Posts: 1",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
        centerTitle: true,
      ),
      body: posts.isNotEmpty == true
          ? Column(
              children: [
                Container(
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _columnBody(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            comentIcon = !comentIcon;
                          });
                        },
                        child: Row(
                          children: [
                            Text("  comments: ${coment.length}"),
                            Text(""),
                            Icon(
                              comentIcon
                                  ? Icons.more_horiz
                                  : Icons.arrow_downward,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        comentIcon
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  coment.length,
                                  (index) => _rowComments(index),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(child: LottieBuilder.asset("assets/Lottie_Animation.json")),
    );
  }

  _rowComments(int index) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                "assets/images/photo${index}.jpg",
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " name:",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          "  ${coment[index].name}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " email:",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          "  ${coment[index].email}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " body:",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          "  ${coment[index].body}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        index == 4
            ? const SizedBox()
            : const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
      ],
    );
  }

  _columnBody() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            const Text(
              " title:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: Text(
                "  ${posts[index].title}",
                style: TextStyle(
                  color: Colors.grey.shade600,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              " body:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: Text(
                "  ${posts[index].body}",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
