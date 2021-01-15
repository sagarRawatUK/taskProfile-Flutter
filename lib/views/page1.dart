import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  List<String> imgs;
  Page1(this.imgs);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(imgs.length, (index) {
        return Card(
          semanticContainer: true,
          color: Colors.black,
          child: Image(
            image: AssetImage(imgs[index]),
            fit: BoxFit.fill,
          ),
        );
      }),
    );
  }
}
