import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r)),
                gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: ColorUtility.castHeaderGradientColor)),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 18.w, right: 18.w, top: 24.h, bottom: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SettingButtonWidget(),
                    Row(
                      children: [
                        // const BackButton(
                        //   color: Colors.white,
                        // ),
                        Text(
                          "Chat",
                          style: StyleUtility.kantumruyProSMedium18TextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize18.sp),
                        ),
                      ],
                    ),
                    const MenuButtonWidget()
                  ],
                ),
              ),
            ),
          ),



          const Expanded(child: Center(child: Text("Chat Screen"),))

          // Expanded(
          //   child: ListView.builder(
          //       padding: EdgeInsets.only(top: 20.h, bottom: 35.h),
          //       itemCount: 21,
          //       itemBuilder: (context, index) {
          //         return Column(
          //           children: [
          //             index == 0
          //                 ? Container(
          //                 width: double.infinity,
          //                 height: 1,
          //                 color: ColorUtility.colorD6D6D8)
          //                 : const SizedBox(),
          //             Padding(
          //               padding: EdgeInsets.only(
          //                   left: 20.w, right: 20.w, top: 17.h, bottom: 20.h),
          //               child: Row(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Image.asset(
          //                     ImageUtility.dummyProfileImage,
          //                     width: 43.w,
          //                     height: 43.w,
          //                   ),
          //                   SizedBox(
          //                     width: 12.w,
          //                   ),
          //                   Expanded(
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         mainAxisAlignment: MainAxisAlignment.start,
          //                         children: [
          //                           RichText(
          //                             overflow: TextOverflow.ellipsis,
          //                             maxLines: 2,
          //                             text: TextSpan(
          //                               text: "Shir ivci",
          //                               style: StyleUtility
          //                                   .quicksandBoldBlackTextStyle
          //                                   .copyWith(
          //                                 fontSize: TextSizeUtility.textSize15.sp,
          //                               ),
          //                               children: <TextSpan>[
          //                                 TextSpan(
          //                                   text: " has withdrawn your audition",
          //                                   style: StyleUtility
          //                                       .quicksandRegularBlackTextStyle
          //                                       .copyWith(
          //                                     fontSize:
          //                                     TextSizeUtility.textSize15.sp,
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           SizedBox(
          //                             height: 7.w,
          //                           ),
          //                           Text(
          //                             "5 min ago",
          //                             style: StyleUtility
          //                                 .quicksandSemiBold76768BTextStyle
          //                                 .copyWith(
          //                                 fontSize:
          //                                 TextSizeUtility.textSize12.sp),
          //                           )
          //                         ],
          //                       ))
          //                 ],
          //               ),
          //             ),
          //             Container(
          //                 width: double.infinity,
          //                 height: 1,
          //                 color: ColorUtility.colorD6D6D8),
          //           ],
          //         );
          //       }),
          // )
        ],
      ),
    );
  }
}
