import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class BlogsPage extends StatefulWidget {
  @override
  _BlogsPageState createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [Text('hello')],
        ),
      ),
    );
  }
}
