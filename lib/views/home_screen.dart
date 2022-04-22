import 'dart:convert';

import 'package:artivatic_assessment/common/common_widgets.dart';
import 'package:artivatic_assessment/models/about_canada_model.dart' as model;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//function to fetch data from the Api
Future<List<model.Row>?> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf'),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 200 OK response, then parse the JSON.
    var decodedJson = model.AboutCanadaModel.fromJson(
      jsonDecode(response.body),
    );
    return decodedJson.rows;
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("About Canada"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchAlbum(),
          builder: (BuildContext context,
                  AsyncSnapshot<List<model.Row>?> snapshot) =>
              snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String url = snapshot.data![index].imageHref.toString();
                        String title = snapshot.data![index].title.toString();
                        String description =
                            snapshot.data![index].description.toString();
                        return contents(context, url, description, title);
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
      ),
    );
  }
}
