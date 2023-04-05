import 'package:flutter/material.dart';

class MarketView extends StatefulWidget {

  const MarketView({Key? key}) : super(key: key);

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("market view"),
      ),

    );
  }
}
