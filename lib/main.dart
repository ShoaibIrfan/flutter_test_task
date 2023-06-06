import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

///Root widget of the application
class MyApp extends StatelessWidget {
  ///constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Test Task'),
    );
  }
}

///Home page of the app, this is the first UI screen displayed to user
class MyHomePage extends StatefulWidget {
  ///constructor
  const MyHomePage({super.key, required this.title});

  ///Text to display on app bar
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String simpleText = 'Hello There..!!';
  bool showSimpleText = false;
  Color backgroundColor = Colors.white;
  Color simpleTextColor = Colors.black;

  @override
  void initState() {
    initializeData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // used to detect tap on whole body
        onTap: () {
          generateRandomColor();
        },
        child: Center(
          child: KTextWidget(
            showSimpleText: showSimpleText,
            simpleText: simpleText,
            textColor: simpleTextColor,
            onAnimationFinish: showSimpleTextValue,
          ),
        ),
      ),
    );
  }

  // used to initialize widget's data
  void initializeData() {
    showSimpleText = false;
    backgroundColor = Colors.white;
    simpleTextColor = Colors.black;
  }

  // show hello there text when the animation of animated text is finished
  void showSimpleTextValue() {
    setState(() {
      showSimpleText = true;
    });
  }

  // used to generate random color on tap of the screen
  void generateRandomColor() {
    final Color randomColor = Colors.primaries[Random().nextInt(Colors.primaries
        .length)]; // pick a random color from list of colors from Colors class
    if (randomColor != Colors.black) {
      simpleTextColor = Colors.black;
    } else if (randomColor != Colors.white) {
      simpleTextColor = Colors.white;
    }
    setState(() {
      backgroundColor = randomColor; // update background of scaffold
    });
  }
}

///Text widget containing texts with and without animation depending on flag
class KTextWidget extends StatelessWidget {
  ///constructor
  const KTextWidget({
    Key? key,
    required this.showSimpleText,
    required this.simpleText,
    required this.onAnimationFinish,
    this.textColor = Colors.black,
  }) : super(key: key);

  ///This flag is used to show the text without animation
  final bool showSimpleText;

  ///Value of text widget with no animation
  final String simpleText;

  ///Called when animation is complete of animated texts
  final Function() onAnimationFinish;

  ///color of text widget without animation
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return showSimpleText
        ? Text(
            simpleText,
            style: TextStyle(fontSize: 20, color: textColor),
          )
        : AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText(
                'Welcome',
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.deepOrange,
                ),
              ),
              RotateAnimatedText(
                'Solid Software',
                duration: const Duration(seconds: 3),
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
            ],
            isRepeatingAnimation: false,
            onFinished: () {
              onAnimationFinish.call();
            },
          );
  }
}
