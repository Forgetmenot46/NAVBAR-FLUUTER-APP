import 'package:flutter/material.dart';
import 'package:jaifulfood_k6/page/data/allfooddata.dart';
import 'package:jaifulfood_k6/page/favoriteProvide.dart';
import 'package:provider/provider.dart';
import 'package:jaifulfood_k6/page/subpage/testing_subpage.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteFoods = favoriteProvider.favoriteFoods;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70),
          Row(
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
          Expanded(
            child: favoriteFoods.isEmpty
                ? Center(
                    child: Text('No favorites yet.'),
                  )
                : ListView.builder(
                    itemCount: favoriteFoods.length,
                    itemBuilder: (context, index) {
                      String food = favoriteFoods[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestingSubPage(
                                foodName: food,
                                typeFood: Food.typefood[index], // ใช้ typefood ที่ถูกต้อง
                                review1: Food.review1[index],
                                review2: Food.review2[index],
                                location: Food.location[index],
                                isFavorite: true, // เป็นรายการโปรดแน่นอน
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
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
                                    "assets/${food}.jpg",
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
                                            food,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            Food.typefood[index],
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
                                                Food.review1[index],
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                Food.review2[index],
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
                                                Icon(
                                                  Icons.location_on,
                                                  color: Color(0xFFFF2F08),
                                                  size: 20,
                                                ),
                                                SizedBox(width: 2),
                                                Text(
                                                  Food.location[index],
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
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
