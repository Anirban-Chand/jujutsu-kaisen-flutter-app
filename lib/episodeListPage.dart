import 'package:anime_characters_op/episodes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EpisodeListPage extends StatefulWidget {
  @override
  _EpisodeListPageState createState() => _EpisodeListPageState();
}

class _EpisodeListPageState extends State<EpisodeListPage> {
  var url_episodes = 'https://api.jikan.moe/v3/anime/40748/episodes';
  Episode epis = Episode(episodes: []);

  @override
  void initState() {
    super.initState();
    // fetching data from server
    // default -- heros details are fetched
    _fetchEpisodes();
  }

  // fetch the episodes function
  _fetchEpisodes() async {
    var res_epis = await http.get(Uri.parse(url_episodes));
    var decodedEpis = jsonDecode(res_epis.body);
    // converting json into episode object
    epis = Episode.fromJson(decodedEpis);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watch JJk Episodes',
          style: GoogleFonts.lato(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: epis.episodes.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: epis.episodes.length,
              itemBuilder: (context, index) {
                final episode = epis.episodes[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Episode ${index + 1}:',
                          style: GoogleFonts.nunitoSans(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          episode.title,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          episode.titleJapanese == null
                              ? 'Japanese Title Not Available'
                              : episode.titleJapanese,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
