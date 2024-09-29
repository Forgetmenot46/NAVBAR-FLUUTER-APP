import 'package:flutter/material.dart';

class TestingSubPage extends StatelessWidget {
  final String foodName; // ชื่อร้านอาหาร
  final String typeFood; // ประเภทอาหาร
  final String review1; // คะแนนรีวิว
  final String review2; // จำนวนรีวิว
  final String location; // ที่ตั้งร้าน
  final bool isFavorite; // สถานะการเป็นรายการโปรด

  // Constructor รับค่าจากหน้า FoodWidget
  TestingSubPage({
    required this.foodName,
    required this.typeFood,
    required this.review1,
    required this.review2,
    required this.location,
    required this.isFavorite, // รับสถานะการเป็นรายการโปรด
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodName), // แสดงชื่อร้านอาหาร
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              // ฟังก์ชันเพิ่มเติมเมื่อกดหัวใจ (สามารถเพิ่มการจัดการการ favorite ได้)
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ร้าน: $foodName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'ประเภทอาหาร: $typeFood',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'รีวิว: $review1 $review2',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'ที่ตั้ง: $location',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
