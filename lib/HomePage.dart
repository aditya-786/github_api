import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://api.github.com/users";
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url));

    setState(() {
      var arr = json.decode(response.body);
      data = arr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github API Data'),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(data[index]["avatar_url"]),
                    ),
                    title: Text(data[index]["login"]),
                    subtitle: Text(data[index]["url"]),
                  )
                ],
              ),
            );
          }),
    );
  }
}
