import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_imag_post/models/models.dart';
import 'package:new_imag_post/servis/db_servise.dart';
import 'package:new_imag_post/servis/network.dart';

class MyPhotos extends StatefulWidget {
  String name;
  int albumId;
  MyPhotos({super.key, required this.albumId, required this.name});

  @override
  State<MyPhotos> createState() => _MyPhotosState(albumId, name);
}

class _MyPhotosState extends State<MyPhotos> {
  String name;
  int albumId;
  _MyPhotosState(this.albumId, this.name);

  List<Photos> photos = [];

  @override
  void initState() {
    DBService.downloadAndPhotos({"albumId": "$albumId"}, albumId).then((value) {
      setState(() {
        photos = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          elevation: 8,
          shadowColor: Colors.red,
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          title: photos.isNotEmpty == false
              ? const Text(
                  "No Photos",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )
              : Text(
                  "Photos: ${photos.length}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 28, right: 12),
              child: Text(
                "albumId:$albumId",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: photos.isNotEmpty == false
            ? Center(child: LottieBuilder.asset("assets/Lottie_Animation.json"))
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 16 / 20,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.only(
                    right: 16, left: 16, top: 16, bottom: 16),
                children: List.generate(
                  photos.length,
                  (index) => Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.network(
                          (photos[index].thumbnailUrl ?? ""),
                          height: 164,
                          fit: BoxFit.cover,
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.red,
                          height: 4,
                        ),
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
                                "  ${photos[index].title}",
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              " id:  ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${photos[index].id}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  _circlProgres() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }
}
