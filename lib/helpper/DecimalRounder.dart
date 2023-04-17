import 'package:flutter/material.dart';

class DecimalRounder {
  static String removePriceDecimal(price) {
    String finalPrice;

    if (price! < 1) {
      finalPrice = price.toStringAsFixed(6);
    } else if (price < 10) {
      finalPrice = price.toStringAsFixed(5);
    } else if (price < 100) {
      finalPrice = price.toStringAsFixed(4);
    } else {
      finalPrice = price.toStringAsFixed(2);
    }

    return finalPrice;
  }

  static String removeChartPriceDecimal(price) {
    String finalPrice;

    if (price! < 1) {
      finalPrice = price.toStringAsFixed(4);
    } else if (price < 10) {
      finalPrice = price.toStringAsFixed(4);
    } else if (price < 100) {
      finalPrice = price.toStringAsFixed(2);
    } else {
      finalPrice = price.toStringAsFixed(0);
    }

    return finalPrice;
  }

  static String removePercentDecimal(percentChange24) {
    String finalPercentChange;

    if (percentChange24! > 10000) {
      finalPercentChange = percentChange24.toStringAsFixed(0);
    } else {
      finalPercentChange = percentChange24.toStringAsFixed(2);
    }

    return finalPercentChange;
  }

  static String removePercentPriceDecimal(percentChange24) {
    String finalPercentChange;

    if (percentChange24! < 1) {
      finalPercentChange = percentChange24.toStringAsFixed(4);
    } else if (percentChange24 < 10) {
      finalPercentChange = percentChange24.toStringAsFixed(4);
    } else if (percentChange24 < 100) {
      finalPercentChange = percentChange24.toStringAsFixed(2);
    } else {
      finalPercentChange = percentChange24.toStringAsFixed(0);
    }

    return finalPercentChange;
  }

  static MaterialColor setColorFilter(percent24) {
    MaterialColor finalColor;

    if (percent24 >0) {
      finalColor = Colors.green;
    } else {
      finalColor = Colors.red;
    }
    return finalColor;
  }
  static Color setPercentColorFilter(percent24) {
    Color percentColor;

    if (percent24 < 0) {
      percentColor = Colors.red;
    } else if (percent24 > 0) {
      percentColor = Colors.green;
    } else {
      percentColor =Colors.white12 ;
    }
    return percentColor;
  }

  static Icon setPercentIconChange(percent24){
    Icon percentIcon;
    if (percent24 < 0) {
      percentIcon = Icon(Icons.arrow_drop_down,color: Colors.red);
    } else if (percent24 > 0) {
      percentIcon = Icon(Icons.arrow_drop_up,color: Colors.green);
    } else {
      percentIcon =Icon(Icons.minimize,color: Colors.grey,) ;
    }
    return percentIcon;
    
  }
}
