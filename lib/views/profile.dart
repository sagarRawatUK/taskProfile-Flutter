import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app/views/page1.dart';
import 'package:app/views/page2.dart';
import 'package:app/views/page3.dart';
import 'package:flutter/rendering.dart';

List<String> foodImages = [];
List<String> danceImages = [];
List<String> lolImages = [];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  bool isScrollingDown = false;
  PageController _controller = PageController(
    initialPage: 0,
  );
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initImages();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          setState(() {});
        }
      }

      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future _initImages() async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths1 = manifestMap.keys
        .where((String key) => key.contains('assets/thumbnails/food'))
        .where((String key) => key.contains('.png'))
        .toList();

    final imagePaths2 = manifestMap.keys
        .where((String key) => key.contains('assets/thumbnails/dance'))
        .where((String key) => key.contains('.png'))
        .toList();

    final imagePaths3 = manifestMap.keys
        .where((String key) => key.contains('assets/thumbnails/lol'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      foodImages = imagePaths1;
      lolImages = imagePaths3;
      danceImages = imagePaths2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            isScrollingDown
                ? Container()
                : Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/profile.jpg"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Samantha Smith",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "@imsamanthasmith",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "1.2m",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Liked",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "12.8k",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "1.9k",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Following",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: currentPage == 0
                            ? Icon(Icons.grid_on_rounded)
                            : Icon(Icons.grid_view),
                        onPressed: () {
                          _controller.animateToPage(0,
                              duration: Duration(milliseconds: 50),
                              curve: Curves.bounceOut);
                        },
                      ),
                      IconButton(
                        icon: currentPage == 1
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        onPressed: () {
                          _controller.animateToPage(1,
                              duration: Duration(milliseconds: 50),
                              curve: Curves.bounceOut);
                        },
                      ),
                      IconButton(
                        icon: currentPage == 2
                            ? Icon(Icons.bookmark)
                            : Icon(Icons.bookmark_outline),
                        onPressed: () {
                          _controller.animateToPage(2,
                              duration: Duration(milliseconds: 50),
                              curve: Curves.bounceOut);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  children: [
                    Page1(foodImages),
                    Page2(danceImages),
                    Page3(lolImages),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
