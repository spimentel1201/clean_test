import 'dart:convert';

import 'package:clean_architecture/models/Gif.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'package:http/http.dart' as http;

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  //await initializeDI;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //const URL = ;
  Future<List<Gif>> _listGif;
  Future<List<Gif>> _getGifs() async {
    final response = await http.get(
        "https://api.giphy.com/v1/gifs/random?api_key=MfUjyYfEFIrCqpdEB47Rr5HEuyl1mrZZ&tag=20&rating=g");

    List<Gif> gifs = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsondata = json.decode(body);
      for (var item in jsondata["data"]) {
        gifs.add(Gif(item["title"], item["images"]["downsized"]["url"]));
      }

      return gifs;
      //print(jsondata);
    } else {
      throw Exception("Fallo en la conexión al servidor");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listGif = _getGifs as Future<List<Gif>>;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Test App'),
          ),
          body: FutureBuilder(
            future: _listGif,
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 3,
                  children: _listGifs(snapshot.data),
                );
              } else if (snapshot.hasError) {
                return Text("error");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }

  List<Widget> _listGifs(List<Gif> data) {
    List<Widget> gifs = [];

    for (var gif in data) {
      gifs.add(Card(
          child: Column(
        children: [
          Expanded(child: Image.network(gif.url, fit: BoxFit.fill)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(gif.name),
          ),
        ],
      )));
    }
    return gifs;
  }
}
