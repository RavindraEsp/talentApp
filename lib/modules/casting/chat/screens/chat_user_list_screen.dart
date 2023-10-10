import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/search_text_field.dart';

class ChatUserListScreen extends StatefulWidget {
  const ChatUserListScreen({super.key});

  @override
  State<ChatUserListScreen> createState() => _ChatUserListScreenState();
}

class _ChatUserListScreenState extends State<ChatUserListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                          context.loc.headerChats,
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
          Padding(
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 18.h, bottom: 16.h),
            child: Text(
                context.loc.headerChats,
              style: StyleUtility.kantumruyProSemiBold5457BETextStyle
                  .copyWith(fontSize: TextSizeUtility.textSize26.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: SearchTextField(
                controller: searchController, hintText: "Search Candidate"),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 20.h, bottom: 35.h),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Navigator.pushNamed(context,
                          RouteName.chatScreen);
                    },
                    child: Padding(
                      padding:  EdgeInsets.only( left: 20.w, right: 20.w,),
                      child: Column(
                        children: [
                          index == 0
                              ? Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: ColorUtility.colorD6D6D8)
                              : const SizedBox(),
                          Container(
                            padding: EdgeInsets.only(
                                top: 17.h, bottom: 20.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ImageUtility.dummyProfileImage,
                                  width: 55.w,
                                  height: 55.w,
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Michaela Cohoen ",
                                            style: StyleUtility
                                                .quicksandBoldBlackTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize18.sp),
                                          ),
                                        ),
                                        Text(
                                          "Yesterday",
                                          style: StyleUtility
                                              .quicksandRegular787E84TextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "Hi, I’m glad you applied to the audition See you there",
                                      style: StyleUtility
                                          .quicksandRegular787E84TextStyle
                                          .copyWith(
                                              fontSize:
                                                  TextSizeUtility.textSize14.sp),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              height: 1,
                              color: ColorUtility.colorD6D6D8),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
