import 'package:flutter/material.dart';


class BottomNav extends StatefulWidget {
   PageController controller;
   BottomNav({Key? key,required this.controller}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: primaryColor,
      child: Container(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SizedBox(
              width: MediaQuery.of(context).size.width /2 -20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (){
                        widget.controller.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                      icon: Icon(Icons.home)),


                  IconButton(
                    onPressed: (){
                      widget.controller.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                    icon: Icon(Icons.bar_chart),)
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width /2 -20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (){
                        widget.controller.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);

                      },
                      icon: Icon(Icons.person)),


                  IconButton(
                    onPressed: (){
                      widget.controller.animateToPage(3, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                    icon: Icon(Icons.featured_play_list_sharp),)
                ],
              ),
            ),
          ],
        ),
      ),

    );


  }
}
