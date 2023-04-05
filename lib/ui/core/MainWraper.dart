import 'package:flutter/material.dart';
import 'package:kv_dev/ui/BottomNav.dart';
import 'package:kv_dev/ui/HomePage.dart';
import 'package:kv_dev/ui/MarketView.dart';
import 'package:kv_dev/ui/Profile.dart';

import '../whatchList.dart';

class MainWraper extends StatefulWidget {
  const MainWraper({Key? key}) : super(key: key);

  @override
  State<MainWraper> createState() => _MainWraperState();
}

class _MainWraperState extends State<MainWraper> {
  @override
  Widget build(BuildContext context) {
    var myPages =PageController(initialPage: 0);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:FloatingActionButton(onPressed: () {  },child:  IconButton( onPressed: (){},icon:  Icon(Icons.swap_horiz_outlined),), ),
      bottomNavigationBar:  BottomNav(controller: myPages),
      body: PageView(
       controller:myPages ,
        children: const [
          HomePage(),
          MarketView(),
          Profile(),
          WhatchList()
        ],

      ),
    );
  }
}
