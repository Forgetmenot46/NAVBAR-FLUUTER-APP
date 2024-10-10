import 'package:flutter/material.dart';
import 'package:jaifulfood_k6/page/data/allfooddata.dart';
import 'package:jaifulfood_k6/page/favoriteProvide.dart';
import 'package:provider/provider.dart';
import 'package:jaifulfood_k6/page/subpage/testing_subpage.dart';

class FoodWidget extends StatefulWidget {
  @override
  _FoodWidgetState createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    // ฟิลเตอร์รายการอาหารตามคำค้นหา
    List<String> filteredFoods = Food.foods
        .where((food) => food.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.restaurant,
                color: Color(0xFFFF2F08),
              ),
              SizedBox(width: 8),
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
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
                        searchQuery =
                            value; // อัปเดตคำค้นหาเมื่อมีการเปลี่ยนแปลง
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
                  children: List.generate(filteredFoods.length, (index) {
                    String food = filteredFoods[index];
                    int originalIndex = Food.foods.indexOf(food);
                    String typeFood = Food.typefood[originalIndex];
                    String review1 = Food.review1[originalIndex];
                    String review2 = Food.review2[originalIndex];
                    String location = Food.location[originalIndex];
                    bool isFavorite = favoriteProvider.isFavorite(food);
                    String addressString =
                        "Lat: ${Food.address[originalIndex]['lat']}, Lng: ${Food.address[originalIndex]['lng']}";

                    return InkWell(
                      // เมื่อกดรายการ จะส่งข้อมูลไปยัง testing_subpage.dart
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TestingSubPage(
                              foodName: food,
                              typeFood: typeFood,
                              review1: review1,
                              review2: review2,
                              location: location,
                              opentime: Food.opentime[originalIndex],
                              phoneNum: Food.phoneNum[originalIndex],
                              address: addressString,
                              displayAddress:
                                  Food.displayAddress[originalIndex],
                              isFavorite: isFavorite,
                              description: Food.description[originalIndex],
                              imagePath: restaurantImg[originalIndex],
                            ),
                          ),
                        );
                      },

                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.0,
                        height: MediaQuery.of(context).size.height / 3.5,
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.0,
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
                                                  setState(() {
                                                    // Update the favorite state
                                                  });
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
