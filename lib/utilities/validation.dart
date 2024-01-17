import 'package:flutter/cupertino.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';

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
    } else if (value.toString().length < 8) {
      return context.loc.validationPassLength;
    }
    return null;
  }

  String? validatorEmail(value) {
    if (value.isEmpty) {
      return context.loc.validationEmail;
    } else if (validator.email(value) == false) {
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

  // String? validatorGovtId(value) {
  //   if (value.isEmpty && value.length()) {
  //     return context.loc.validationID;
  //   }
  //   return null;
  // }

  String? validatorGovtId(value) {
    if (value.isEmpty) {
      return context.loc.validationID;
    } else if (value.length != 9) {
      return 'Invalid id.';
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

  String? validatorMinAge(value) {
    if (value.isEmpty) {
      return "Min age is required.";
    }
    return null;
  }

  // String? validatorMaxAge(value) {
  //   if (value.isEmpty) {
  //     return "Max age is required.";
  //   }
  //   return null;
  // }

  String? validatorMaxAge2(String min, max) {
    if (max.isEmpty) {
      return "Max age is required.";
    } else if (double.parse(max) < double.parse(min)) {
      return "Invalid max age.";
    }
    return null;
  }

  String? validatorMinWeight(value) {
    if (value.isEmpty) {
      return "Min weight is required";
    } else if (double.parse(value) < 1) {
      return "Invalid weight.";
    }
    return null;
  }



  // String? validatorMaxWeight(value) {
  //   if (value.isEmpty) {
  //     return "Max weight is required.";
  //   } else if (double.parse(value) < 1) {
  //     return "Invalid max weight.";
  //   }
  //   return null;
  // }

  String? validatorMaxWeight2(String min, max) {
    if (max.isEmpty) {
      return "Max weight is required.";
    } else if (double.parse(max) < double.parse(min)) {
      return "Invalid max weight.";
    }
    return null;
  }


  String? validatorWeight(value) {
    if (value.isEmpty) {
      return "Weight is required";
    } else if (double.parse(value) < 1) {
      return "Invalid weight.";
    }
    return null;
  }
  String? validatorMinHeight(value) {
    if (value.isEmpty) {
      return "Min height is required.";
    } else if (double.parse(value) < 1) {
      return "Invalid height.";
    }
    return null;
  }



  // String? validatorMaxHeight(value) {
  //   if (value.isEmpty) {
  //     return "Max height is required.";
  //   } else if (double.parse(value) < 1) {
  //     return "Invalid max height.";
  //   }
  //   return null;
  // }

  String? validatorMaxHeight2(String min, max) {
    if (max.isEmpty) {
      return "Max height is required.";
    } else if (double.parse(max) < double.parse(min)) {
      return "Invalid max height.";
    }
    return null;
  }


  String? validatorHeight(value) {
    if (value.isEmpty) {
      return "Height is required.";
    } else if (double.parse(value) < 1) {
      return "Invalid height.";
    }
    return null;
  }


  String? validatorDescription(value) {
    if (value.isEmpty) {
      return "Description is required.";
    }
    return null;
  }

  String? validatorAboutYou(value) {
    if (value.isEmpty) {
      return "Tell us about you is required.";
    }
    return null;
  }

  String? validatorBirthday(value) {
    if (value.isEmpty) {
      return "Birthday date is required.";
    }
    return null;
  }
}
