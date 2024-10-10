import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jaifulfood_k6/page/data/allfooddata.dart';
import 'package:jaifulfood_k6/page/food.dart';
import 'package:jaifulfood_k6/page/subpage/testing_subpage.dart';
import 'package:provider/provider.dart';
import 'package:jaifulfood_k6/page/favoriteProvide.dart';

class Home extends StatelessWidget {
  final List<Color> bgColor = [
    Color(0xFFFBDCDA),
    Color(0xFFF4DCD3),
    Color(0xFFFBD6D5),
    Color(0xFFFBDFE7),
    Color(0xFFFBDFE7),
    Color(0xFFFBDFE7),
  ];

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Material(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(height: 50),
              _buildHeader(),
              SizedBox(height: 20),
              _buildDivider(),
              SizedBox(height: 5),
              _buildSectionTitle("โปรโมชั่น"),
              _buildCarousel(),
              SizedBox(height: 30),
              _buildDivider(),
              _buildSectionTitle("ร้านแนะนำสำหรับคุณ", showSeeAll: true,
                  onTapSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodWidget(),
                  ),
                );
              }),
              _buildRecommendedList(),
              SizedBox(height: 30),
              _buildDivider(),
              _buildSectionTitle("ยอดฮิต", showSeeAll: true, onTapSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodWidget(),
                  ),
                );
              }),
              _buildPopularList(favoriteProvider),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ยินดีต้อนรับ",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(0xFFFF2F08),
                  ),
                  Text(
                    'Seyong',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          _buildProfileImage(),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage("assets/cojohn.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              color: Color(0xFFFF2F08),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 2,
      color: Colors.grey[300],
      indent: 15,
      endIndent: 15,
    );
  }

  Widget _buildSectionTitle(String title,
      {bool showSeeAll = false, VoidCallback? onTapSeeAll}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showSeeAll)
            TextButton(
              onPressed: onTapSeeAll,
              child: Text(
                "See All",
                style: TextStyle(
                  color: Color(0xFFFF2F08),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      items: imgList
          .map((item) => Container(
                child: Center(
                  child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: 250.0,
        aspectRatio: 4 / 3,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
      ),
    );
  }

  Widget _buildRecommendedList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Food.foods.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              color: bgColor[index % bgColor.length],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/${Food.foods[index]}.jpg",
                  height: 80,
                  width: 80,
                ),
                Text(
                  Food.foods[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularList(FavoriteProvider favoriteProvider) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Food.foods.length,
        itemBuilder: (context, index) {
          return _buildFoodCard(context, index, favoriteProvider);
        },
      ),
    );
  }

  Widget _buildFoodCard(
      BuildContext context, int index, FavoriteProvider favoriteProvider) {
    // แปลง Map เป็น String
    String addressString =
        "Lat: ${Food.address[index]['lat']}, Lng: ${Food.address[index]['lng']}";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestingSubPage(
              foodName: Food.foods[index],
              typeFood: Food.typefood[index],
              review1: Food.review1[index],
              phoneNum: Food.phoneNum[index],
              review2: Food.review2[index],
              opentime: Food.opentime[index],
              address: addressString, // ส่งค่า addressString ที่แปลงแล้ว
              description: Food.description[index],
              location: Food.location[index],
              displayAddress: Food.displayAddress[index],
              imagePath: restaurantImg[index],
              isFavorite: favoriteProvider.isFavorite(Food.foods[index]),
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        margin: EdgeInsets.all(10),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                restaurantImg[index],
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
                        Food.foods[index],
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
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                    ],
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
