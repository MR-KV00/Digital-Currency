import 'package:flutter/material.dart';
import 'package:kv_dev/ui/core/ThemeSwitcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'core/HomePageView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _controllerHomePageView=PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {


    var titleTextStyle =Theme.of(context).textTheme;
    var appbarColor =Theme.of(context).primaryColor;

    return  Scaffold(
      drawer: Drawer(),

      appBar: AppBar(
        backgroundColor: appbarColor,
        actions: [ThemeSwitcher()],
        centerTitle: true,
        title: const Text("Digital Currency"),
        titleTextStyle:titleTextStyle.titleLarge ,



      ),

      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10,left: 5,right: 5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 160,
                    child:Stack(

                      children: [
                        HomePageView(controller: _controllerHomePageView),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child:Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: SmoothPageIndicator(
                              controller: _controllerHomePageView,
                              count: 4,
                              effect:const ExpandingDotsEffect(
                                  dotHeight: 10,
                                  dotWidth: 10
                              ),
                              onDotClicked: (index) => _controllerHomePageView.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
                            ),
                          ),
                        )

                      ],

                    ),
                  )


              )
            ],
          ),
        ),
      ),


    );
  }
}
