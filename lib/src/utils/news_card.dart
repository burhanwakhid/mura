import 'package:Mura/src/model/news_model.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final double imageHeight;
  final double imageWidth;
  final NewsModel newsModel;

  NewsCard({
    this.title,
    this.imageHeight,
    this.imageWidth,
    this.newsModel
  });

  @override
  Widget build(BuildContext context) {
    return 
        ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            scrollDirection: Axis.vertical,
            itemCount: newsModel.articles.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 4.0,
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: NetworkImage(newsModel.articles[index].urlToImage),
                        height: 150.0,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(newsModel.articles[index].title, style: TextStyle(color: Colors.grey),),
                      )
                    ],
                  ),
                
              );
            },
          
        
      
    );
  }
}
