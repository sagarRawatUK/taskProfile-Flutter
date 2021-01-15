import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  List<String> imgs;
  Page2(this.imgs);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(imgs.length, (index) {
        return Card(
          color: Colors.black,
          child: Image(
            image: AssetImage(imgs[index]),
            fit: BoxFit.cover,
          ),
        );
      }),
    );
  }
}
