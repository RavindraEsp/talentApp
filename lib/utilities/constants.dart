import 'package:url_launcher/url_launcher_string.dart';
//final GoogleSignIn googleSignIn = GoogleSignIn();

class ConstantMethod {
  ConstantMethod._();
  // static const dummy = 'dummy';

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
