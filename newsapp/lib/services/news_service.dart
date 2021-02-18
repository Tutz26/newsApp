import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '49910b5aa4b24a9b8dfcfca7d684d028';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),


  ];

  Map<String, List<Article>> categoryArticles = {};


  NewsService() {

    this.getTopHeadlines();

    categories.forEach((item){
      this.categoryArticles[item.name] = new List();
    });

  }

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor){
    this._selectedCategory = valor;

    this.getArticlesByCategory( valor );
    notifyListeners();
  }

  List <Article>get getArticulosCategoriasSeleccionada => this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async{

    final url = '$_URL_NEWS/top-headlines?country=us&apiKey=$_APIKEY';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll( newsResponse.articles );
    notifyListeners();

  }

  getArticlesByCategory(String category) async{

    if (this.categoryArticles[category].length > 0){
      return this.categoryArticles[category];
    }


    final url = '$_URL_NEWS/top-headlines?country=us&category=${category}&apiKey=$_APIKEY';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newsResponse.articles);

    notifyListeners();

  }


}