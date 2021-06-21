import 'package:anime_characters_op/heros.dart' as hero;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacterDetails extends StatelessWidget {
  final hero.Characters character;

  CharacterDetails({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        color: Colors.teal,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 5.0,
                margin: const EdgeInsets.fromLTRB(30.0, 75.0, 30.0, 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 100.0,
                    ),
                    Text(character.name,
                        style: GoogleFonts.nunito(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text('Character ID: ${character.malId}',
                        style: GoogleFonts.nunito(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text('Character Role: ${character.role}',
                        style: GoogleFonts.nunito(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: character.imageUrl,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(character.imageUrl),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
