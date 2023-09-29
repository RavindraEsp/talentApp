import 'package:flutter/material.dart';
import 'package:talent_app/utilities/color_utility.dart';

class CommonDialog {
  //Show loading dialog
  static showLoadingDialog(BuildContext ctx) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorUtility.color703297),
                    strokeWidth: 2.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: const Text(
                      "Please wait...",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  )
                ]),
          ),
        ));
      },
    );
  }
}
