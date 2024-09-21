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
        scaffoldBackgroundColor: Colors.white,
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
  int selectedIndex = 1;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _fadeIn();
  }

  void _fadeIn() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  List<Widget> items() {
    return [
      Icon(
        Icons.favorite,
        size: selectedIndex == 0 ? 37 : 30,
        color: selectedIndex == 0 ? Colors.white : Colors.white,
      ),
      Icon(
        Icons.home,
        size: selectedIndex == 1 ? 37 : 30,
        color: selectedIndex == 1 ? Colors.white : Colors.white,
      ),
      Icon(
        Icons.fastfood,
        size: selectedIndex == 2 ? 37 : 30,
        color: selectedIndex == 2 ? Colors.white : Colors.white,
      ),
    ];
  }

  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: items(),
        index: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        height: 65,
        color: Color.fromRGBO(255, 47, 8, 1),

        /// เปลี่ยนสี Nav
        backgroundColor: Colors.transparent,
        animationCurve: Curves.fastLinearToSlowEaseIn,

        /// animation การเคลื่อนที่ของ icon
        animationDuration: const Duration(milliseconds: 660),

        /// animation ความไว
      ),

      ///สามารถเลื่อนไปจออื่นได้
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: [
          Favorite(),
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 500),
            child: Home(),
          ),
          Food(),
        ],
      ),

      ///สามารถเลื่อนไปจออื่นได้
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
