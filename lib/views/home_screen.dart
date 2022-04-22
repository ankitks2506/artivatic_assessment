import 'dart:convert';

import 'package:artivatic_assessment/common/common_widgets.dart';
import 'package:artivatic_assessment/models/about_canada_model.dart' as model;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _controller = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        isLoading = true;
      });
      fetchAlbum();
    }
  }

  void _onRefresh() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      fetchAlbum,
    ).onError((error, stackTrace) {
      throw Exception(error);
    });
    setState(() {});
    _refreshController.refreshCompleted();
  }

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
                  ? SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      enablePullDown: true,
                      enablePullUp: false,
                      header: const MaterialClassicHeader(
                        color: Colors.green,
                      ),
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: isLoading ? snapshot.data!.length : 5,
                        itemBuilder: (context, index) {
                          String url =
                              snapshot.data![index].imageHref.toString();
                          String title = snapshot.data![index].title.toString();
                          String description =
                              snapshot.data![index].description.toString();
                          if (snapshot.data!.length == index) {
                            return const Text(
                              "End of List",
                            );
                          } else {
                            return contents(context, url, description, title);
                          }
                        },
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
      ),
    );
  }
}
