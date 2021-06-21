import 'package:anime_characters_op/news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var url_news = 'https://api.jikan.moe/v3/anime/40748/news';
  static var news = NewsArticle(articles: []);

  @override
  void initState() {
    super.initState();
    // fetching data from server
    // default -- heros details are fetched
    _fetchNews();
  }

  // fetch related news function
  _fetchNews() async {
    var res_news = await http.get(Uri.parse(url_news));
    var decodedNews = jsonDecode(res_news.body);
    // converting json into news object
    news = NewsArticle.fromJson(decodedNews);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JJk NewsFeed',
          style: GoogleFonts.lato(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: news.articles.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              // scrollDirection: Axis.horizontal,
              itemCount: news.articles.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(16.0),
                elevation: 15,
                child: Column(
                  children: [
                    Text(
                      news.articles[index].title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(news.articles[index].date != null
                        ? '${news.articles[index].date}'
                        : "Empty"),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      news.articles[index].intro,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image(image: NetworkImage(news.articles[index].imageUrl)),
                    SizedBox(
                      height: 20,
                    ),
                    // Text(news.articles[index].comments),
                    Text('Author: '+news.articles[index].authorName),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
