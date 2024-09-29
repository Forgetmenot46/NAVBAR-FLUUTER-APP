import 'package:flutter/material.dart';
import 'package:jaifulfood_k6/page/data/allfooddata.dart';
import 'package:jaifulfood_k6/page/favoriteProvide.dart';
import 'package:provider/provider.dart';
// นำเข้าไฟล์ testing_subpage.dart
import 'package:jaifulfood_k6/page/subpage/testing_subpage.dart'; // ตรวจสอบให้แน่ใจว่า path ถูกต้อง

class FoodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70), // เพิ่มระยะห่างด้านบน
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 15), // ระยะห่างจากขอบซ้ายของหน้าจอ
              Icon(
                Icons.restaurant,
                color: Color(0xFFFF2F08),
              ),
              SizedBox(width: 8), // ระยะห่างระหว่างไอคอนและข้อความ
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Divider(
              thickness: 2,
              color: Colors.grey[300],
              indent: 15,
              endIndent: 15,
            ),
          ),

          // ส่วนของรายการอาหารที่สามารถเลื่อนได้
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: List.generate(Food.foods.length, (index) {
                    String food = Food.foods[index];
                    String typeFood = Food.typefood[index];
                    String review1 = Food.review1[index];
                    String review2 = Food.review2[index];
                    String location = Food.location[index];
                    bool isFavorite = favoriteProvider.isFavorite(food);

                    return InkWell(
                      // เมื่อกดรายการ จะส่งข้อมูลไปยัง testing_subpage.dart
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TestingSubPage(
                              foodName: food, // ส่งชื่อร้านอาหาร
                              typeFood: typeFood, // ส่งประเภทอาหาร
                              review1: review1, // ส่งคะแนนรีวิว
                              review2: review2, // ส่งจำนวนรีวิว
                              location: location, // ส่งที่ตั้งร้าน
                              isFavorite: isFavorite, // ส่งสถานะรายการโปรด
                            ),
                          ),
                        );
                      },

                      child: Container(
                        width: MediaQuery.of(context).size.width /
                            1.0, // ปรับให้เหมาะสม
                        height: MediaQuery.of(context).size.height / 4.5,
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              10), // เพิ่ม Padding เพื่อเว้นระยะห่างภายใน Container
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.asset(
                                  "assets/${food}.jpg", // ใช้ข้อมูลจากคลาส Food
                                  height: 120,
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          food,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          typeFood,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Color(0xFFFF2F08),
                                              size: 20,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              review1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              review2,
                                              style: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  isFavorite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  if (isFavorite) {
                                                    favoriteProvider
                                                        .removeFavorite(food);
                                                  } else {
                                                    favoriteProvider
                                                        .addFavorite(food);
                                                  }
                                                },
                                              ),
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xFFFF2F08),
                                                size: 20,
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                location,
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
