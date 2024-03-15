import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talent_app/modules/intro/intro_screen.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefCall();

    sendDateToApi();

  }


  void sendDateToApi() {

      // Create a DateTime object from the selected values
      DateTime selectedDate = DateTime(2021, 1, 2);

      // Format the date
      String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

      // Now you have the date in "dd-MM-yyyy" format, you can use it to send to the API
      print("date is for $formattedDate"); // This is just an example, replace it with your API call

      // Example API call (pseudo-code)
      // sendDataToApi({"date": formattedDate});

  }



  prefCall() async {
    await Preference().instance();
    setRoute();
  }

  setRoute() {
    bool isLogin = Preference().getUserLogin();
    int userType = Preference().getUserType();

    if (isLogin == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    } else {
      if (userType == 1) {
        // talent

        Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.talentBottomBarScreen,
            arguments: {"selectIndex": 0},
            (route) => false);
      } else if (userType == 2) {
        //caster

        Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.castBottomBarScreen,
            arguments: {"selectIndex": 0},
            (route) => false);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IntroScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(),
    );
  }
}
