import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_imag_post/models/models.dart';
import 'package:new_imag_post/pages/user_name.dart';
import 'package:new_imag_post/servis/db_servise.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool setDownload = true;
  int x = 0;
  List<User> users = [];

  void onAdd(User user) {
    setState(() {
      users.add(user);
      print("initstate: onAdd: =======> ${users[0].email}");
    });
  }

  // @override
  // void initState() {
  //   DBService.getUser(onAdd);
  //   super.initState();
  // }
  
  Future refref()async{
   await DBService.getUser(onAdd);
   await Future.delayed(Duration(milliseconds: 1500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "No Users",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: users.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 180),
              child: LottieBuilder.asset(
                "assets/LottieFiles1.json",
              ),
            )
          : RefreshIndicator(
            onRefresh: refref,
            child: ListView.separated(
                itemBuilder: (context, index) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.orange,
                    splashColor: Colors.orange,
                    onDoubleTap: () {},
                    onTap: () {
                      Navigator.of(context).push(
                        // CupertinoModalPopupRoute
                        CupertinoPageRoute(
                          builder: (context) => MyUserName(
                              name: users[index].name ?? "",
                              userId: users[index].id ?? -1),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 33,
                        backgroundColor: Colors.yellow,
                        child: CircleAvatar(
                          radius: 26,
                          backgroundImage:
                              AssetImage("assets/images/photo$index.jpg"),
                        ),
                      ),
                      title: Text(users[index].name ?? ""),
                      trailing: const Icon(
                        Icons.more_vert_outlined,
                        color: Colors.red,
                      ),
                      // trailing: const Icon(
                      //   CupertinoIcons.delete,
                      //   color: Colors.red,
                      // ),
                      subtitle: Text(
                        users[index].email ?? "",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      textColor: Colors.white,
                      contentPadding: index == users.length - 1
                          ? const EdgeInsets.only(bottom: 50, left: 16, right: 16)
                          : null,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  color: Colors.grey,
                  endIndent: 18,
                  indent: 24,
                ),
                itemCount: users.length,
              ),
          ),
      bottomSheet: _buildBottomSheet(),
    );
  }

  _buildBottomSheet() {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            setDownload = false;
          });
          DBService.downloadAndUpload().then(
            (value) {
              print(value);
              setState(() {
                setDownload = true;
                DBService.getUser(onAdd);
              });
            },
          );
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: const Color.fromARGB(255, 228, 144, 19)),
        child: setDownload
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Download users",
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 28,
                  )
                ],
              )
            // : LinearPercentIndicator(
            //     barRadius: const Radius.circular(10),
            //     animation: true,
            //     center: Text("${x}%"),
            //     percent: 1,
            //     lineHeight: 20,
            //     animationDuration: 6000,
            //     linearStrokeCap: LinearStrokeCap.roundAll,
            //     // animationDuration: 2000,
            //   )
            : const LinearProgressIndicator(
                color: Colors.green,
                backgroundColor: Colors.white,
                minHeight: 3),
      ),
    );
  }
}
