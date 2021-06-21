import 'package:anime_characters_op/characterDetails.dart';
import 'package:anime_characters_op/episodeListPage.dart';
import 'package:anime_characters_op/newsPage.dart';
import 'package:anime_characters_op/picturesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anime_characters_op/heros.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var drawerItems = <String>['Protagonists', 'Pictures', 'Episodes', 'News'];
  var url_heros = 'https://api.jikan.moe/v3/anime/40748/characters_staff';
  Protagonist protagonist = Protagonist(characters: []);

  @override
  void initState() {
    super.initState();
    // fetching data from server
    // default -- heros details are fetched
    _fetchHeros();
  }

  // Fetch Heros details function
  _fetchHeros() async {
    // getting the response
    var res_heros = await http.get(Uri.parse(url_heros));
    // converting response into readable json
    var decodedHeros = jsonDecode(res_heros.body);
    // converting json to protagonist object
    protagonist = Protagonist.fromJson(decodedHeros);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // HomePage Appbar Goes here
      appBar: AppBar(
        title: Text(
          'JJK World',
          style: GoogleFonts.lato(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // HomePage Drawer goes here
      drawer: Drawer(
        elevation: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.amber),
              height: 100,
              width: 200,
              child: TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  'Characters',
                  style: GoogleFonts.nunito(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.red),
              height: 100,
              width: 200,
              child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PicturesPage()));
                  },
                  child: Text(
                    'Pictures',
                    style: GoogleFonts.nunito(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  )),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.blue),
              height: 100,
              width: 200,
              child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EpisodeListPage()));
                  },
                  child: Text(
                    'Episodes',
                    style: GoogleFonts.nunito(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  )),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.green),
              height: 100,
              width: 200,
              child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsPage()));
                  },
                  child: Text(
                    'News',
                    style: GoogleFonts.nunito(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),

      // HomePage Body Starts here
      body: protagonist.characters.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: protagonist.characters
                  .map(
                    (hero) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CharacterDetails(
                                character: hero,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: hero.imageUrl,
                          child: Card(
                            elevation: 5.0,
                            borderOnForeground: true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(hero.imageUrl),
                                    ),
                                  ),
                                ),
                                Text(
                                  hero.name,
                                  style: GoogleFonts.nunito(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
