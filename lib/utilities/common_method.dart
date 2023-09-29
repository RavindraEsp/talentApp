import 'package:flutter/material.dart';

class CommonMethod {

  CommonMethod._();
  static hideKeyBoard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }


}
