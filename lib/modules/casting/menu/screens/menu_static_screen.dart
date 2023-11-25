import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/modules/casting/menu/providers/web_content_provider.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';

class MenuStaticScreen extends StatefulWidget {
  final String headerText;
  final PageName pageName;

  const MenuStaticScreen({super.key, required this.headerText, required this.pageName});

  @override
  State<MenuStaticScreen> createState() => _MenuStaticScreenState();
}

class _MenuStaticScreenState extends State<MenuStaticScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WebContentProvider>(context, listen: false).getWebContentData(
        onFailure: (msg) {
      Navigator.pop(context);
      Common.showErrorToast(context, msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        backgroundColor: ColorUtility.colorWhite,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.headerText,
          style: StyleUtility.kantumruyProMedium5457BETextStyle
              .copyWith(fontSize: TextSizeUtility.textSize20.sp),
        ),
      ),
      body: Consumer<WebContentProvider>(
          builder: (context, webContentProvider, child) {


        return
          webContentProvider.isLoading == true ?
          const CustomCircularLoaderWidget():

          SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              child: Column(
                children: [
                  // Text(
                  //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  //   style: StyleUtility.quicksandBlackWhiteTextStyle
                  //       .copyWith(fontSize: TextSizeUtility.textSize22.sp),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 20.h),
                  //   child: Text(
                  //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  //     style: StyleUtility.quicksandRegularBlackTextStyle
                  //         .copyWith(fontSize: TextSizeUtility.textSize14.sp),
                  //   ),
                  // )

                  Html(
                    // data: webContentProvider
                    //         .webContentResponseModel?.data?.aboutus ??
                    //     "",
                    data: webContentProvider.getHtmlData(widget.pageName),
                  )
                ],
              )),
        );
      }),
    );
  }
}
