import 'package:flutter/foundation.dart';
import 'package:kv_dev/models/CryptoModel/AllCryptoModel.dart';
import 'package:kv_dev/netWork/ApiProvider.dart';
import 'package:kv_dev/netWork/ResponseModel.dart';

class CryptoApiProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  late AllCryptoModel futureData;
  late ResponseModel state;
  var response;

  getTopMarketDataCap() async {
    state = ResponseModel.loading("is loading...");

    try {
      response = await apiProvider.getTopMarketDataCapt();
      print(response);

      if (response.statusCode == 200) {
        futureData = AllCryptoModel.fromJson(response);
        state = ResponseModel.completed(futureData);
      } else{
        state = ResponseModel.error("try again please");
      }

      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("please check your connection");
      notifyListeners();
    }
  }
}
