import 'package:flutter/material.dart';


class HomePageView extends StatefulWidget {
   PageController controller;
   HomePageView({Key? key,required this.controller}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

  var images =[
    "https://www.ineteconomics.org/uploads/featured/bitcoin-fiat.jpg",
    "https://images.news18.com/ibnlive/uploads/2021/09/cryptocurrency-16326473653x2.jpg",
    "https://assets-global.website-files.com/606f63778ec431ec1b930f1f/6075b905a29c6e2431a56ffa_60746b4cd45ce809f522ad10_CBDC.jpeg",
    "https://blog.ipleaders.in/wp-content/uploads/2020/08/june-18-crypto-header-pic.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return PageView(

      controller: widget.controller,
      children: [
        showPageView(images[0]),
        showPageView(images[1]),
        showPageView(images[2]),
        showPageView(images[3]),
      ],
    );
  }

  Widget showPageView(String image){

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(18)),
      child:Image.network(image,fit: BoxFit.cover,) ,
    );
  }
}
