
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../helpper/DecimalRounder.dart';
import '../models/CryptoModel/CryptoData.dart';
import '../netWork/ResponseModel.dart';
import '../providers/MarketViewProvider.dart';
import 'HomePage.dart';

class MarketView extends StatefulWidget {
  const MarketView({Key? key}) : super(key: key);

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    var marketViewProvider =Provider.of<MarketViewProvider>(context,listen: false);
    marketViewProvider.getMarketViewData();
    
     timer =Timer.periodic(Duration(seconds: 20), (t) => marketViewProvider.getMarketViewData());
  }
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
///*///////////////////////////
  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: Theme.of(context).iconTheme,
        title: Text("MarketView"),
        titleTextStyle: textStyle.titleLarge,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,

        child: Column(

          children: [
            Expanded(
                child: Consumer<MarketViewProvider>(
                  builder: (context, marketViewProvider, child) {
                    switch (marketViewProvider.state.status) {
                      case Status.LOADING:
                        return loadingApiMarketView();
                      case Status.COMPLETED:
                        return completedApiMarketView(context, marketViewProvider);
                      case Status.ERROR:
                        return Text(marketViewProvider.state.massage);
                      default:
                        return Container();
                    }

                  },

                )

            )




          ],
        ),
      ),
    );

  }
///*//////////////////////////
  Widget completedApiMarketView(BuildContext context,MarketViewProvider marketViewProvider) {

    var borderColor = Theme.of(context).secondaryHeaderColor;
    var height = MediaQuery.of(context).size.width;
    var textStyle = Theme.of(context).textTheme;
    ///
    List<CryptoData>? modal = marketViewProvider.futureData.data?.cryptoCurrencyList!;



    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),

          child: TextField(

            onChanged: (value){},

            decoration: InputDecoration(
                hintStyle:textStyle.bodySmall,
                prefixIcon: Icon(Icons.search,color: borderColor,),


                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                    borderRadius: BorderRadius.all(Radius.circular(15))


                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))


                )



            ),



          ),

        ),
        Expanded(
          child: ListView.separated(
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

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){},
                    child: SizedBox(
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
                                      name!.substring(0,3),
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
                                    crossAxisAlignment: CrossAxisAlignment.end,

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
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: modal!.length),
        ),
      ],
    );

  }
  Widget loadingApiMarketView() {

    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor:Colors.white,
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: Colors.white
                  ),
              ),
               ),
          ),
        ),
        Expanded(child: loadingApiHomePage())

      ],


    );


  }
}


