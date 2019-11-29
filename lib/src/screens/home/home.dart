import 'package:Mura/src/api/api.dart';
import 'package:Mura/src/model/movie_model.dart';
import 'package:Mura/src/model/movies_model.dart';
import 'package:Mura/src/model/news_model.dart';
import 'package:Mura/src/screens/news/news_detail.dart';
import 'package:Mura/src/utils/content_scroll.dart';
import 'package:Mura/src/utils/headline_shimer.dart';
import 'package:Mura/src/utils/oval_right.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  final Color primary = Color(0xFFFFFFFF);
  final Color active = Color(0xff6C48AB);

  NewsModel newsModel;
  MovieModel movieModel;

  @override
  void initState() {
    Api.getTopHeadLines().then((value) {
      setState(() {
        newsModel = value;
        print(newsModel.articles.length);
      });
    });
    // Api.getPopularMovie().then((value){
    //   setState(() {
    //     movieModel = value;
    //   });
    // });
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }
  _newsSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        // onTap: () => Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => MovieScreen(movie: movies[index]),
        //   ),
        // ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => NewsDetail(title: newsModel.articles[index].title, url: newsModel.articles[index].url,)
          ));
        },
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                    tag: newsModel.articles[index].urlToImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: NetworkImage(newsModel.articles[index].urlToImage),
                        height: 220.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              bottom: 40.0,
              child: Container(
                width: 250.0,
                child: Text(
                  newsModel.articles[index].title.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.getInstance()..init(context);
    return Scaffold(
      
      backgroundColor: Colors.white,
      drawer: _buildDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue[100]),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
        // leading: IconButton(
        //   padding: EdgeInsets.only(left: 30.0),
        //   onPressed: () {
        //     // _buildDrawer();
        //   },
        //   icon: Icon(Icons.menu),
        //   iconSize: 30.0,
        //   color: Colors.black,
        // ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text('Top Headlines Indonesia',
              style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
            ),),
          ),
          Container(
            height: 280.0,
            width: double.infinity,
            child: newsModel != null ? newsModel.articles.length >0 ? PageView.builder(
              controller: _pageController,
              itemCount: newsModel.articles.length,
              itemBuilder: (BuildContext context, int index) {
                return _newsSelector(index);
              },
            ): Center(child: Text('artikel kosong'),) : CardShimmer(),
          ),
          Container(
            height: 90.0,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              scrollDirection: Axis.horizontal,
              itemCount: labels.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  width: 160.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF39CFB1),
                        Color(0xFFc4e8e1),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF9E1F28),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      labels[index].toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          ContentScroll(
            images: myList,
            title: 'My List',
            imageHeight: 250.0,
            imageWidth: 150.0,
          ),
          SizedBox(height: 10.0),
          ContentScroll(
            images: popular,
            title: 'Popular',
            imageHeight: 250.0,
            imageWidth: 150.0,
          ),
        ],
      ),
    );
  }

  _buildDrawer() {
    // final String image = images[0];
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: Colors.white, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.deepPurple])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: CachedNetworkImageProvider('https://www.pngarts.com/files/3/Cool-Avatar-Transparent-Images.png'),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "erika costell",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    "@erika07",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, "Home"),
                  _buildDivider(),
                  _buildRow(Icons.person_pin, "Your profile"),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings"),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "Help"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
  Divider _buildDivider() {
    return Divider(
      color: active,
    );
  }

  Widget _buildRow(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }
}

