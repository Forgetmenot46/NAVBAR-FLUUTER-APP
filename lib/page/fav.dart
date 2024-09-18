import 'package:flutter/material.dart';

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
      title: '...',
      home: Favorite(),
    );
  }
}

//Class stateful เรียกใช้การท างานแบบโต้ตอบ (เรียกใช้ State)
class Favorite extends StatefulWidget {
  @override
  State<Favorite> createState() => _FavoriteState();
}

//class state เขียน Code ภาษา dart เพอื่รับค่าจากหนา้จอมาคา นวณและส่งคา่่กลบัไปแสดงผล
class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('FAV HOME'),
      ),
    );
  }
}
