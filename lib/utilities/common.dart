import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'color_utility.dart';

class Common {
  Common._();

  // static const dateFormatForAddDate = 'yyyy-MM-dd';
  static const dateFormatForAddDate = 'dd/MM/yyyy';
  static const dateFormat = 'dd/MM/yyyy hh:mm a';

  static showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: ColorUtility.colorDD4F4F,
      content: Text(
        message,
      ),
    ));
  }

  static showSuccessToast(BuildContext context, String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }


  static showErrorToast(BuildContext context, String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //Show loading dialog
  static showLoadingDialog(BuildContext ctx) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return Dialog(
            child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorUtility.color703297),
                    strokeWidth: 2.0,
                  ),
                  /*Platform.isAndroid
                      ? */
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      "Please wait...",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  )
//                      : SizedBox(),
                ]),
          ),
        ));
      },
    );
  }

  static Widget loadingIndicator() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Container(
            height: 25.0,
            width: 25.0,
            child: const CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blue,
              ),
            ),
          )),
        ]);
  }

  static selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2090),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: ColorUtility.color263287,
                // Set the primary color
                onPrimary: Colors.white, // Set the text color
              ),
              dialogBackgroundColor: Colors.white, // Set the background color
            ),
            child: child!,
          );
        });
    if (selected != null) {
      String formattedDate = DateFormat(dateFormatForAddDate).format(selected);
      dateController.text = formattedDate;
    }
  }
}
