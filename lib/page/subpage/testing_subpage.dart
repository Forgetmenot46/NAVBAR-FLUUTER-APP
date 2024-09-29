import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jaifulfood_k6/page/favoriteProvide.dart'; // ตรวจสอบ path ให้ถูกต้อง

class TestingSubPage extends StatefulWidget {
  final String foodName; // ชื่อร้านอาหาร
  final String typeFood; // ประเภทอาหาร
  final String review1; // คะแนนรีวิว
  final String review2; // จำนวนรีวิว
  final String location; // ที่ตั้งร้าน
  final bool isFavorite; // สถานะการเป็นรายการโปรด
  final String imagePath; // พาธของรูปภาพ

  TestingSubPage({
    required this.foodName,
    required this.typeFood,
    required this.review1,
    required this.review2,
    required this.location,
    required this.isFavorite, // รับสถานะการเป็นรายการโปรด
    required this.imagePath, // รับพาธของรูปภาพ
  });

  @override
  _TestingSubPageState createState() => _TestingSubPageState();
}

class _TestingSubPageState extends State<TestingSubPage> {
  late bool isFav;

  @override
  void initState() {
    super.initState();
    // ใช้ค่าเริ่มต้นจากหน้าที่เรียกใช้
    isFav = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // พื้นหลังรูปภาพ
          Image.asset(
            widget.imagePath,
            width: media.width,
            height: media.width,
            fit: BoxFit.cover,
          ),
          Container(
            width: media.width,
            height: media.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: media.width - 300),
                      Container(
                        width: media.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 35),
                              Text(
                                widget.foodName,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // ข้อมูลคำอธิบายร้านอาหาร
                              Text(
                                "Description",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                                "Ornare leo non mollis id cursus. Eu euismod faucibus in leo malesuada",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Divider(color: Colors.grey[400]),
                              const SizedBox(height: 1000),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // ปุ่ม Favorite ที่ต้องการจัดให้อยู่ภายใน Stack
                Positioned(
                  top: media.width - 250,
                  right: 25,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isFav = !isFav;
                        if (isFav) {
                          favoriteProvider.addFavorite(widget.foodName);
                        } else {
                          favoriteProvider.removeFavorite(widget.foodName);
                        }
                      });
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ปุ่ม Back
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
