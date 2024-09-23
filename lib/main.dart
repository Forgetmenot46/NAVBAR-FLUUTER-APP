import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jaifulfood_k6/page/fav.dart';
import 'package:jaifulfood_k6/page/favoriteProvide.dart';
import 'package:jaifulfood_k6/page/food.dart';
import 'package:jaifulfood_k6/page/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MainState();
}

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
        color: Colors.white,
      ),
      Icon(
        Icons.home,
        size: selectedIndex == 1 ? 37 : 30,
        color: Colors.white,
      ),
      Icon(
        Icons.fastfood,
        size: selectedIndex == 2 ? 37 : 30,
        color: Colors.white,
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
        backgroundColor: Colors.transparent,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: const Duration(milliseconds: 660),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: [
          // ส่ง favoriteFoods ไปที่ Favorite โดยใช้ Provider
          Favorite(),
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 500),
            child: Home(),
          ),
          // ส่ง onFavoriteUpdated ไปยัง FoodWidget โดยใช้ Provider
          FoodWidget(),
        ],
      ),
    );
  }
}
