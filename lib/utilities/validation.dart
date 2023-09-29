import 'package:flutter/cupertino.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:talent_app/extension/context_extension.dart';

class Validators {
  BuildContext context;

  Validators(this.context);

  String? validatorName(value) {
    if (value.isEmpty) {
      return context.loc.validationName;
    }
    return null;
  }

  String? validatorPassword(value) {
    if (value.isEmpty) {
      return context.loc.validationPass;
    }else if (value.toString().length < 8) {
      return context.loc.validationPassLength;
    }
    return null;
  }

  String? validatorEmail(value) {
    if (value.isEmpty) {
      return context.loc.validationEmail;
    }
    else if(validator.email(value) == false){
      return "Please enter valid email.";
    }

    return null;
  }

  String? validatorPhone(value) {
    if (value.isEmpty) {
      return context.loc.validationPhone;
    }
    return null;
  }

  String? validatorFirstName(value) {
    if (value.isEmpty) {
      return context.loc.validationFirstName;
    }
    return null;
  }
  String? validatorLastName(value) {
    if (value.isEmpty) {
      return context.loc.validationLastName;
    }
    return null;
  }
  String? validatorId(value) {
    if (value.isEmpty) {
      return context.loc.validationID;
    }
    return null;
  }
  String? validatorAddress(value) {
    if (value.isEmpty) {
      return context.loc.validationAddress;
    }
    return null;
  }
  String? validatorCompanyName(value) {
    if (value.isEmpty) {
      return context.loc.validationCompanyName;
    }
    return null;
  }
}
