import 'package:example/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';

void main() {
  runApp(LitUIKitExample());
}

class LitUIKitExample extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LitUIKitExampleState createState() => _LitUIKitExampleState();
}

class _LitUIKitExampleState extends State<LitUIKitExample> {
  @override
  void initState() {
    super.initState();
    ImageCacheController(
        assetImages: ["assets/images/launcher_placeholder.png"],
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LitUIKit',
      home: LitUIKitHomescreen(),
    );
  }
}
