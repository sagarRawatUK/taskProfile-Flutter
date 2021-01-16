import 'dart:convert';
import 'package:app/constants/widgets.dart';
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
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _initImages();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          setState(() {
            isScrollingDown = true;
          });
          print(isScrollingDown);
        }
      }

      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          setState(() {
            isScrollingDown = false;
          });
          print(isScrollingDown);
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
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            AnimatedContainer(
              height: isScrollingDown ? 0 : height * 0.25,
              duration: Duration(milliseconds: 400),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Samantha Smith",
                    style: profileText(),
                  ),
                  Text(
                    "@imsamanthasmith",
                    style: profileValues(),
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
                            style: profileStats(),
                          ),
                          Text(
                            "Liked",
                            style: profileValues(),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "12.8k",
                            style: profileStats(),
                          ),
                          Text(
                            "Followers",
                            style: profileValues(),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "1.9k",
                            style: profileStats(),
                          ),
                          Text(
                            "Following",
                            style: profileValues(),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
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
            )
          ],
        ),
      ),
    );
  }
}
