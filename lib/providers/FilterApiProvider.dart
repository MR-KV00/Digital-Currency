import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'CryptoApiProvider.dart';

class FilterApiProvider extends ChangeNotifier{

  int defaultChoiceIndex = 0;


   changeCheep (int index,bool value,BuildContext context) async{

     var cryptoApiProvider = Provider.of<CryptoApiProvider>(context);
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
     notifyListeners();




   }





}