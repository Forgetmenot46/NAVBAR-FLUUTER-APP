import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jaifulfood_k6/page/favoriteProvide.dart'; // ตรวจสอบ path ให้ถูกต้อง
import 'package:url_launcher/url_launcher.dart';

class TestingSubPage extends StatefulWidget {
  final String foodName; // ชื่อร้านอาหาร
  final String typeFood; // ประเภทอาหาร
  final String description; // ประเภทอาหาร
  final String review1; // คะแนนรีวิว
  final String review2; // จำนวนรีวิว
  final String location; // ที่ตั้งร้าน
  final String displayAddress; // ที่ตั้งร้าน
  final String opentime;
  final String phoneNum;
  final String address; // พิกัดที่อยู่จริงในรูปแบบ "Lat: xx, Lng: yy"
  final bool isFavorite; // สถานะการเป็นรายการโปรด
  final String imagePath; // พาธของรูปภาพ

  TestingSubPage({
    required this.foodName,
    required this.typeFood,
    required this.description,
    required this.review1,
    required this.review2,
    required this.location,
    required this.opentime,
    required this.phoneNum,
    required this.displayAddress,
    required this.address,
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

  void _launchMap(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "ประเภท : ",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    widget.typeFood,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    if (index <
                                        double.parse(widget.review1).floor()) {
                                      return Icon(
                                        Icons.star,
                                        color: Color(0xFFFF2F08),
                                        size: 20,
                                      );
                                    } else if (index <
                                        double.parse(widget.review1)) {
                                      return Icon(
                                        Icons.star_half,
                                        color: Color(0xFFFF2F08),
                                        size: 20,
                                      );
                                    } else {
                                      return Icon(
                                        Icons.star_border,
                                        color: Color(0xFFFF2F08),
                                        size: 20,
                                      );
                                    }
                                  }),
                                  SizedBox(width: 5),
                                  Text(
                                    "${widget.review1}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    widget.review2,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              // ข้อมูลคำอธิบายร้านอาหาร
                              Text(
                                "Description : ",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.description,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Divider(color: Colors.grey[400]),
                              Text(
                                  "ใส่รูปทำเป็น Array carousel ที่กดไปดูรูปได้"),

                              Divider(color: Colors.grey[400]),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Color(0xFFFF2F08),
                                    size: 25,
                                  ),
                                  Text(
                                    " ที่อยู่",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  // แสดง Popup ยืนยันก่อนเปิดลิงก์
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("ยืนยันการเปิดแผนที่"),
                                        content: Text(
                                            "แน่ใจหรือไม่ว่าต้องการเปิดลิงก์ไปยัง Google Maps?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // ปิด Popup
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("ยกเลิก"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // แยก lat และ lng จาก widget.address
                                              final RegExp regExp = RegExp(
                                                  r'Lat:\s*([\d.-]+),\s*Lng:\s*([\d.-]+)');
                                              final match = regExp
                                                  .firstMatch(widget.address);
                                              if (match != null &&
                                                  match.groupCount == 2) {
                                                final double lat = double.parse(
                                                    match.group(1)!);
                                                final double lng = double.parse(
                                                    match.group(2)!);
                                                _launchMap(lat, lng);
                                              }
                                              // ปิด Popup หลังจากทำการเปิดแผนที่
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("ยืนยัน"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  widget.displayAddress,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: Color(0xFFFF2F08),
                                    size: 25,
                                  ),
                                  Text(
                                    " เบอร์โทรศัพท์ร้าน",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  // แสดง Popup ยืนยันก่อนโทรออก
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("ยืนยันการโทร"),
                                        content: Text(
                                            "แน่ใจหรือไม่ว่าต้องการโทรไปที่ '${widget.phoneNum}' ?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // ปิด Popup
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("ยกเลิก"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // เปิดแอปโทรศัพท์
                                              _launchPhone(widget.phoneNum);
                                              // ปิด Popup หลังจากทำการโทร
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("ยืนยัน"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  widget.phoneNum,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timelapse_rounded,
                                    color: Color(0xFFFF2F08),
                                    size: 25,
                                  ),
                                  Text(
                                    " เวลาทำการ",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                widget.opentime,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 20),

                              const SizedBox(height: 500),
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
