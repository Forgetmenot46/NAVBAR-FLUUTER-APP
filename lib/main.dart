import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:jaifulfood_k6/page/fav.dart';
import 'package:jaifulfood_k6/page/food.dart';
import 'package:jaifulfood_k6/page/home.dart';

//Method หลักทีRun
void main() {
  runApp(MyApp());
}

//Class state less สงั่ แสดงผลหนา้จอ
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Curved Navigation Bar Example',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(239, 245, 188, 2)),
        scaffoldBackgroundColor: Colors.lightGreen,
        useMaterial3: true,
      ),
      home: Main(),
    );
  }
}

//Class stateful เรียกใช้การท างานแบบโต้ตอบ (เรียกใช้ State)
class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MainState();
}

//class state เขียน Code ภาษา dart เพอื่รับค่าจากหนา้จอมาคา นวณและส่งคา่่กลบัไปแสดงผล
class _MainState extends State<Main> {
  final items = const [
    Icon(
      Icons.favorite,

      ///ประเภท icon
      size: 30,

      ///ขนาด icon
      color: Colors.red,

      ///เปลี่ยนสี icon
    ),
    Icon(
      Icons.home,
      size: 30,
      color: Colors.red,
    ),
    Icon(
      Icons.fastfood,
      size: 30,
      color: Colors.red,
    ),
  ];

  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        height: 70,
        color: Colors.green,

        /// เปลี่ยนสี Nav
        backgroundColor: Colors.transparent,
        animationCurve: Curves.fastLinearToSlowEaseIn,

        /// animation การเคลื่อนที่ของ icon
        animationDuration: const Duration(milliseconds: 660),

        /// animation ความไว
      ),
      body: Container(
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = Favorite();
        break;
      case 1:
        widget = Home();
        break;
      default:
        widget = Food();
        break;
    }
    return widget;
  }
}
