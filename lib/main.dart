import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List pokemonData;
  getPokemon() async {
    http.Response response = await http
        .get('https://pokeapi.co/api/v2/pokemon?limit=100&offset=200');
    data = json.decode(response.body);
    setState(() {
      pokemonData = data['results'];
    });
  }

  @override
  initState() {
    super.initState();
    getPokemon();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solumart'),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView.builder(
        itemCount: pokemonData == null ? 0 : pokemonData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '$index',
                      style: GoogleFonts.oswald(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.kindpng.com/picc/m/107-1075263_transparent-pokeball-png-pokemon-ball-2d-png-download.png'),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "${pokemonData[index]['name']}",
                        style: GoogleFonts.oswald(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            fontSize: 30.0),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
