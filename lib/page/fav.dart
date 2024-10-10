import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jaifulfood_k6/page/favoriteProvide.dart';
import 'package:jaifulfood_k6/page/subpage/testing_subpage.dart';
import 'package:jaifulfood_k6/page/data/allfooddata.dart'; // ตรวจสอบให้แน่ใจว่า path ถูกต้อง

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteFoods = favoriteProvider.favoriteFoods;

    // ฟิลเตอร์รายการอาหารตามคำค้นหา
    List<String> filteredFoods = favoriteFoods
        .where((food) => food.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70),
          _buildHeader(),
          SizedBox(height: 20),
          _buildSearchBar(),
          SizedBox(height: 10),
          _buildDivider(),
          Expanded(
            child: filteredFoods.isEmpty
                ? Center(
                    child: Text('ยังไม่มีร้านที่ถูกใจ'),
                  )
                : ListView.builder(
                    itemCount: filteredFoods.length,
                    itemBuilder: (context, index) {
                      String food = filteredFoods[index];
                      int originalIndex = favoriteFoods.indexOf(food);
                      return _buildFoodItem(
                        context,
                        food,
                        favoriteProvider,
                        originalIndex,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้าง header
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 15),
        Icon(
          Icons.favorite,
          color: Color(0xFFFF2F08),
        ),
        SizedBox(width: 8),
        Text(
          'Favorite',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ฟังก์ชันสำหรับสร้าง search bar
  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.09,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'ค้นหาร้านที่คุณอยากไป',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ฟังก์ชันสำหรับสร้าง divider
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Divider(
        thickness: 2,
        color: Colors.grey[300],
        indent: 15,
        endIndent: 15,
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้างรายการอาหาร
  Widget _buildFoodItem(BuildContext context, String food,
      FavoriteProvider favoriteProvider, int originalIndex) {
    // แปลง Map เป็น String ที่อ่านง่าย
    String addressString =
        "Lat: ${Food.address[originalIndex]['lat']}, Lng: ${Food.address[originalIndex]['lng']}";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestingSubPage(
              foodName: food,
              typeFood: Food.typefood[originalIndex],
              review1: Food.review1[originalIndex],
              review2: Food.review2[originalIndex],
              location: Food.location[originalIndex],
              opentime: Food.opentime[originalIndex],
              phoneNum: Food.phoneNum[originalIndex],

              address: addressString, // ส่งค่า addressString ที่แปลงแล้ว
              displayAddress: Food.displayAddress[originalIndex],
              isFavorite: true,
              description: Food.description[originalIndex],
              imagePath: restaurantImg[originalIndex],
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.5,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  restaurantImg[originalIndex],
                  height: 120,
                  width: MediaQuery.of(context).size.width,
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
                          food,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          Food.typefood[originalIndex],
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
                              Food.review1[originalIndex],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Food.review2[originalIndex],
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
                                  favoriteProvider.isFavorite(food)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  if (favoriteProvider.isFavorite(food)) {
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
                                Food.location[originalIndex],
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
  }
}
