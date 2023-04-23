import 'package:flutter/foundation.dart';
import 'package:kv_dev/models/CryptoModel/AllCryptoModel.dart';
import 'package:kv_dev/models/UserModel.dart';
import 'package:kv_dev/netWork/ApiProvider.dart';
import 'package:kv_dev/netWork/ResponseModel.dart';

class UserApiProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  late dynamic futureData;
  late ResponseModel? registerState;
  var error ;
  var response;

  callRegisterApi(name,email,password) async {
    registerState = ResponseModel.loading("is loading...");
    print("*******$registerState");
    print("*******1$response");
    notifyListeners();


    try{
      response = await apiProvider.callRegisterApi(name, email, password);
      print("*******2$response");

      if (response.statusCode == 201) {
        futureData = ApiStatus.fromJson(response.data);
        registerState = ResponseModel.completed(futureData);
        print("******* 3 $response ");
      } else if(response.statusCode == 200) {
        registerState = ResponseModel.error("try again please");
      }

      notifyListeners();
    }catch (e) {

      registerState =ResponseModel.error("please check your connection");

      notifyListeners();

    }



  }

}

