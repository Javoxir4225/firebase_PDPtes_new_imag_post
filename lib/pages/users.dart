// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_imag_post/models/models.dart';
import 'package:new_imag_post/pages/user_name.dart';
import 'package:new_imag_post/servis/network.dart';

class MyUsers extends StatefulWidget {
  const MyUsers({super.key});

  @override
  State<MyUsers> createState() => _MyUsersState();
}

class _MyUsersState extends State<MyUsers> {
  bool action = false;
  List<User> user = [];

  @override
  void initState() {
    Network.getUser(Network.apiUser, null).then((value) {
      if (value != null) {
        setState(() {
          action = true;
          user = value;
        });
      } else {
        setState(() {
          user;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Users",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          action
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "users${user.length}",
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : Text(""),
        ],
      ),
      body: user.isNotEmpty == true ? _card() : _loading(),
    );
  }

  _card() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: List.generate(
            10,
            (index) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyUserName(
                        name: user[index].name ?? "no named",
                        userId: index + 1),
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
                    color: Colors.grey,
                  ),
                  padding: const EdgeInsets.only(left: 10, top: 16, bottom: 16),
                  height: 100,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          "assets/images/photo$index.jpg",
                        ),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Name:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                user[index].name ?? "no name",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Email:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                user[index].email ?? "no email",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
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

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.red,
      ),
    );
  }
}
