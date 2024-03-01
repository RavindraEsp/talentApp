import 'package:url_launcher/url_launcher_string.dart';
//final GoogleSignIn googleSignIn = GoogleSignIn();

class Constant {
  Constant._();
  // static const dummy = 'dummy';

  static const String mapKey = "AIzaSyC0apFqdYGTRVuRDkuD7AurpXUVk-IZy3w";

  static Future<void> launchUrlBrowser(String url) async {
    try {
      if (await launchUrlString(url)) {
        await launchUrlString(url);
      }
    } catch (err) {
      // print('err --->$err');


    }
  }
}
