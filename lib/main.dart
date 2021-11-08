import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stack_app/earthquake.model.dart';

createAlbum(String events) async {
  final response = await http.get(Uri.parse(
      'https://cdn.knmi.nl/knmi/map/page/seismologie/all_induced.json')); // url api

  if (response.statusCode == 200) {
    // status code moet 200 zijn om uit te printen.

    print(response.body); // in de console word alle data geprint
    final json = jsonDecode(response.body);
    print("JSON $json");
    return List<Earthquake>.from(json['events']
        .map((x) => Earthquake.fromJson(x))); // maakt een list van alle data
  } else {
    throw Exception(response.statusCode
        .toString()); // status code word geprint als het niet gelijk is aan 200
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Test', // class om een titel aan te maken in de appbar
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<FirstRoute> {
  final TextEditingController _controller = TextEditingController();
  Future? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Honden Feiten',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Honden Feiten'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(9.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
            'https://e7.pngegg.com/pngimages/496/352/png-clipart-osaka-earthquake-computer-icons-earthquake-engineering-earthquakes-text-logo-thumbnail.png'),
        ElevatedButton(
          // knop met de future album word geprint
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller
                  .text); // de class wordt geprint waar de variable van de API in staan.
            });
          },
          child:
              const Text('Klik hier voor een honden feitje! (in het engels)'),
        ),
      ],
    );
  }

// error code of niet
  FutureBuilder buildFutureBuilder() {
    return FutureBuilder(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return Text(snapshot.data.toString());
          return ListView.builder(
              controller: ScrollController(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Earthquake earthquake = snapshot.data[index];
                return ListTile(
                  title: Text(earthquake.depth.toString() +
                      " " +
                      " " +
                      earthquake.type.toString()),
                  subtitle: Text(earthquake.place.toString()),
                  trailing: Text(earthquake.mag.toString()),
                );
              },
              itemCount: snapshot.data.length);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
