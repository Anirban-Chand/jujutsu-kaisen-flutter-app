import 'package:anime_characters_op/pictures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PicturesPage extends StatefulWidget {
  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
  var url_pictures = 'https://api.jikan.moe/v3/anime/40748/pictures';
  static var pic = Picture(pictures: []);

  @override
  void initState() {
    super.initState();
    // fetching data from server
    // default -- heros details are fetched
    _fetchPics();
  }

  // Fetch heros' images function
  _fetchPics() async {
    var res_pics = await http.get(Uri.parse(url_pictures));
    var decodedPics = jsonDecode(res_pics.body);
    // converting json into picture object
    pic = Picture.fromJson(decodedPics);
    setState(() {});
  }

  // var picRev = pic.pictures.reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JJk Images',
          style: GoogleFonts.lato(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: pic.pictures.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pic.pictures.length,
                    itemBuilder: (context, index) => Card(
                      margin: EdgeInsets.all(8.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(pic.pictures[index].small),
                      ),
                    ),
                  ),
                ),
                // Flexible(
                //   child: ListView.builder(
                //     // Reversing the list
                //     reverse: true,
                //     itemCount: pic.pictures.length,
                //     itemBuilder: (context, index) => Container(
                //       margin: EdgeInsets.all(8.0),
                //       child: Image(
                //         image: NetworkImage(pic.pictures[index].small),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
    );
  }
}
