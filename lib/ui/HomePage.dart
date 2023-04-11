import 'package:flutter/material.dart';
import 'package:kv_dev/netWork/ResponseModel.dart';
import 'package:kv_dev/providers/CryptoApiProvider.dart';
import 'package:kv_dev/ui/core/ThemeSwitcher.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'core/HomePageView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controllerHomePageView = PageController(initialPage: 0);

  var defaultChoiceIndex = 0;
  final List<String> _choiceCheep = [
    "top MarketCaps",
    "top Gainers",
    "top Losers"
  ];


  @override
  void initState() {
    super.initState();

   var cryptoApiProvider=Provider.of<CryptoApiProvider>(context,listen: false);
   cryptoApiProvider.getTopMarketDataCap();

  }

  @override
  Widget build(BuildContext context) {


    var textStyle = Theme.of(context).textTheme;
    var appbarColor = Theme.of(context).primaryColor;



    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: appbarColor,
        actions: const [ThemeSwitcher()],
        centerTitle: true,
        title: const Text("Digital Currency"),
        titleTextStyle: textStyle.titleLarge,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 160,
                    child: Stack(
                      children: [
                        HomePageView(controller: _controllerHomePageView),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: SmoothPageIndicator(
                              controller: _controllerHomePageView,
                              count: 4,
                              effect: const ExpandingDotsEffect(
                                  dotHeight: 10, dotWidth: 10),
                              onDotClicked: (index) =>
                                  _controllerHomePageView.animateToPage(index,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Marquee(
                  text: "  (this is place for new news) ",
                  style: textStyle.bodySmall,
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          backgroundColor: Colors.green[700],
                          padding: EdgeInsets.all(20)),
                      child: Text("buy", style: textStyle.bodySmall),
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.all(20)),
                        child: Text("sell", style: textStyle.labelSmall),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    Wrap(
                        spacing: 8,
                        children: List.generate(_choiceCheep.length, (index) {
                          return ChoiceChip(
                            label: Text(
                              _choiceCheep[index],
                              style: textStyle.titleSmall,
                            ),
                            selected: defaultChoiceIndex == index,
                            selectedColor: Colors.blue,
                            onSelected: (bool value) {
                              setState(() {
                                defaultChoiceIndex =
                                    value ? index : defaultChoiceIndex;
                              });
                            },
                          );
                        }))
                  ],
                ),
              ),
              Consumer<CryptoApiProvider>(
                  builder: (context, cryptoData, child) {
                switch (cryptoData.state.status) {
                  case Status.LOADING:
                    return Text(cryptoData.state.massage);
                  case Status.COMPLETED:
                    return Text("done");
                  case Status.ERROR:
                    return Text(cryptoData.state.massage);
                   default:
                    return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
