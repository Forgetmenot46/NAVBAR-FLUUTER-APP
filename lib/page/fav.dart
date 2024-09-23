import 'package:flutter/material.dart';
import 'package:jaifulfood_k6/page/data/allfooddata.dart';
import 'package:jaifulfood_k6/page/favoriteProvide.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // เข้าถึง favoriteFoods ผ่าน Provider
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteFoods = favoriteProvider.favoriteFoods;

    return Scaffold(
      body: Column(
        children: [
          // ส่วนบนที่มี SizedBox และ Row
          SizedBox(height: 70), // เพิ่มระยะห่างด้านบน
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // จัดวางให้อยู่ทางซ้าย
            children: [
              SizedBox(width: 15), // ระยะห่างจากขอบซ้ายของหน้าจอ
              Icon(
                Icons.favorite,
                color: Color(0xFFFF2F08),
              ),
              SizedBox(width: 8), // ระยะห่างระหว่างไอคอนและข้อความ
              Text(
                'Favorite',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10), // เพิ่มระยะห่างหลังข้อความ

          // เพิ่มเส้น Divider ใต้คำว่า "Favorite" พร้อม margin ด้านล่าง
          Padding(
            padding: const EdgeInsets.only(bottom: 15), // margin-bottom
            child: Divider(
              thickness: 2, // ความหนาของเส้น
              color: Colors.grey[300], // สีของเส้น
              indent: 15, // ระยะห่างจากซ้าย
              endIndent: 15, // ระยะห่างจากขวา
            ),
          ),

          // ส่วนของรายการอาหารโปรด
          Expanded(
            child: favoriteFoods.isEmpty
                ? Center(
                    child: Text('No favorites yet.'),
                  )
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: List.generate(favoriteFoods.length, (index) {
                          String food = favoriteFoods[index];
                          bool isFavorite = favoriteProvider.isFavorite(food);

                          return InkWell(
                            onTap: () {
                              // เพิ่มฟังก์ชันการทำงานเมื่อกดที่ Card
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 4.5,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10, // เพิ่มระยะห่างแนวนอนและแนวตั้ง
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white, // สีพื้นหลังของ Card
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10), // เพิ่ม Padding เพื่อเว้นระยะห่างภายใน Container
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
                                        width: MediaQuery.of(context).size.width / 1.4,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                food, // ใช้ข้อมูลจากคลาส Food
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                Food.typefood[index], // ใช้ข้อมูลจากคลาส Food
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
                                                    Food.review1[index], // ใช้ข้อมูลจากคลาส Food
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    Food.review2[index], // ใช้ข้อมูลจากคลาส Food
                                                    style: TextStyle(color: Colors.black45),
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
                                                          favoriteProvider.removeFavorite(food);
                                                        } else {
                                                          favoriteProvider.addFavorite(food);
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
                                                      Food.location[index], // ใช้ข้อมูลจากคลาส Food
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
