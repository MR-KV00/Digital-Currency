import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kv_dev/helpper/DecimalRounder.dart';
import 'package:kv_dev/models/CryptoModel/CryptoData.dart';
import 'package:kv_dev/netWork/ResponseModel.dart';
import 'package:kv_dev/providers/CryptoApiProvider.dart';
import 'package:kv_dev/providers/FilterApiProvider.dart';
import 'package:kv_dev/ui/core/ThemeSwitcher.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'core/HomePageView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controllerHomePageView = PageController(initialPage: 0);

  int defaultChoiceIndex = 0;
  final List<String> _choiceCheep = [
    "top MarketCaps",
    "top Gainers",
    "top Losers"
  ];


  @override
  void initState() {
    super.initState();

    var cryptoApiProvider = Provider.of<CryptoApiProvider>(context, listen: false);
    cryptoApiProvider.getTopMarketDataCap();
  }

  @override
  Widget build(BuildContext context) {


    var cryptoApiProvider = Provider.of<CryptoApiProvider>(context);
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
                        child: Text("sell", style: textStyle.bodySmall),
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
                                defaultChoiceIndex = value ? index : defaultChoiceIndex;
                                switch(index){
                                  case 0 :
                                    cryptoApiProvider.getTopMarketDataCap();
                                    break;
                                  case 1:
                                    cryptoApiProvider.getTopGainerDataCap();
                                    break;
                                  case 2:
                                    cryptoApiProvider.getTopLosersDataCap();
                                }
                              });
                            },
                          );
                        }
                        )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: Consumer<CryptoApiProvider>(
                    builder: (context, cryptoData, child) {
                  switch (cryptoData.state.status) {
                    case Status.LOADING:
                      return loadingApiHomePage();
                    case Status.COMPLETED:
                      return completedApiHomePage(context, cryptoData);
                    case Status.ERROR:
                      return Text(cryptoData.state.massage);
                    default:
                      return Container();
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget completedApiHomePage(BuildContext context,CryptoApiProvider cryptoApiProvider) {

    var height = MediaQuery.of(context).size.width;
    var textStyle = Theme.of(context).textTheme;
    ///
    List<CryptoData>? modal = cryptoApiProvider.futureData.data?.cryptoCurrencyList!;



    return ListView.separated(
        itemBuilder: (context, index) {
          var number = index + 1;
          var name = modal![index].name;

          var idPic = modal![index].id;
          var symbol = modal![index].symbol;
          ///
          var finalPrice = DecimalRounder.removePriceDecimal(modal[index].quotes![0].price);
          var percentChange = DecimalRounder.removePercentDecimal(modal[index].quotes![0].percentChange24h);
          MaterialColor filterColor = DecimalRounder.setColorFilter(modal[index].quotes![0].percentChange24h);
          var percentColor = DecimalRounder.setPercentColorFilter(modal[index].quotes![0].percentChange24h);
          Icon percentIcon = DecimalRounder.setPercentIconChange(modal[index].quotes![0].percentChange24h);
          ///

          return SizedBox(
            height: height * 0.095,

            child: Row(
              children: [

                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    number.toString(),
                    style: textStyle.bodySmall,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 8,right: 15),
                  child: CachedNetworkImage(
                    fadeInDuration: Duration(milliseconds: 500),
                    imageUrl:
                    "https://s2.coinmarketcap.com/static/img/coins/32x32/$idPic.png",
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                ),

                Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name!,
                            style: textStyle.bodySmall,
                          ),
                          Text(
                            symbol!,
                            style: textStyle.labelSmall,
                          )
                        ],
                      ),
                    )),

                Flexible(

                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(filterColor, BlendMode.srcATop),

                    child:SvgPicture.network("https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$idPic.svg"),

                  ),

                ),

                Expanded(

                  child: Padding(
                    padding: EdgeInsets.only(right: 10),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [

                        Text("\$$finalPrice",style: textStyle.bodySmall,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [

                            percentIcon,

                            Text("$percentChange %",style: GoogleFonts.ubuntu(color: percentColor,fontSize: 13)),



                          ],
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: modal!.length);

  }


}
  Widget loadingApiHomePage() {
   return SizedBox (
    height: 80,
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.white,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 8, right: 8),
                child: CircleAvatar(
                  child: Icon(Icons.add),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                          width: 50,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: SizedBox(
                            height: 15,
                            width: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 170,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
              Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 15,
                          width: 50,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: SizedBox(
                            height: 15,
                            width: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        },
      ),
    ),
  );
}


