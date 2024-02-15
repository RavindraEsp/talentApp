import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonMethod {
  CommonMethod._();

  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static String getDate(String inputDateString) {
    try {
      DateTime dateTime = DateTime.parse(inputDateString).toLocal();
      String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedDate;
    } catch (e) {
      return "";
    }
  }

  static String getDateTime(String inputDateString) {
    try {
      DateTime dateTime = DateTime.parse(inputDateString).toLocal();
      String formattedDate = DateFormat('dd/MM/yyyy, hh:mm a').format(dateTime);
      return formattedDate;
    } catch (e) {
      return "";
    }
  }

  static String getTime(String inputDateString) {
    //String inputDateString = "2023-12-01T08:27:39.000Z";
    // Parse the input date string
    try {
      DateTime dateTime = DateTime.parse(inputDateString).toLocal();

      // Format the date according to the desired format
      String formattedDate = DateFormat('hh:mm a').format(dateTime);


      return formattedDate;
    } catch (e) {
      return "";
    }
  }
}
