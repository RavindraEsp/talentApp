import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonMethod {

  CommonMethod._();
  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }



  static String getDate(String inputDateString){

    //String inputDateString = "2023-12-01T08:27:39.000Z";

    // Parse the input date string
    DateTime dateTime = DateTime.parse(inputDateString);

    // Format the date according to the desired format
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;

  }


}
