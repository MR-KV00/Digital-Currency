import 'package:flutter/material.dart';

class WhatchList extends StatefulWidget {
  const WhatchList({Key? key}) : super(key: key);

  @override
  State<WhatchList> createState() => _WhatchListState();
}

class _WhatchListState extends State<WhatchList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("whatchList"),
      ),

    );
  }
}
