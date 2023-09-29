import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talent_app/main.dart';

class LanguageSettingScreen extends StatefulWidget {
  const LanguageSettingScreen({super.key});

  @override
  State<LanguageSettingScreen> createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Setting"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
            width: double.infinity,
          ),
          Text(AppLocalizations.of(context)!.hello),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                _changeLanguage(context, const Locale("hi"));
              },
              child: const Text("Hindi")),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                _changeLanguage(context, const Locale("en"));
              },
              child: const Text("English")),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                _changeLanguage(context, const Locale("ar"));
              },
              child: const Text("Arabic")),
        ],
      ),
    );
  }

  void _changeLanguage(BuildContext context, Locale newLocale) {
    // Update the app's locale.
    MyApp.setLocale(context, newLocale);
    setState(() {});
  }
}
