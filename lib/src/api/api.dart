  
import 'dart:async';
import 'dart:convert';
import 'package:Mura/src/model/movies_model.dart';
import 'package:Mura/src/model/news_model.dart';
import 'package:Mura/src/utils/environment.dart';
import 'package:http/http.dart' as http;

class Api {
  // get top headlines
  static Future getTopHeadLines() async{
    try {
      var url = urlNewsApi + 'top-headlines?country=id&apiKey=' + tokenNewsApi;
      var response = await http.get(url);
      print(response.body);
      return NewsModel.fromJson(jsonDecode(response.body));
    } catch(e) {
      print(e);
      return e;
    }
  }

  static Future getNewsByKategori(String kategori) async {
    try {
      var url = urlNewsApi + 'top-headlines?country=id&category=$kategori&apiKey=' + tokenNewsApi;
      var response = await http.get(url);
      print(response.body);
      return NewsModel.fromJson(jsonDecode(response.body));
    } catch(e) {
      return e;
    }
  }

  static Future getPopularMovie() async{
    try {
      var url = urlMovie + 'movie/popular?api_key=$tokenMovies&language=en-US&page=1';
      var response = await http.get(url);
      print(response.body);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch(e) {
      print(e);
      return e;
    }
  }
  

}