import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/search_text_field.dart';

class EducationListScreen extends StatefulWidget {
  const EducationListScreen({super.key});

  @override
  State<EducationListScreen> createState() => _EducationListScreenState();
}

class _EducationListScreenState extends State<EducationListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorD6D6D8,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r)),
                gradient:  const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: ColorUtility.talentHeaderGradientColor
                )),
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
                          'Education',
                          style: StyleUtility.kantumruyProSMedium18TextStyle
                              .copyWith(
                              fontSize: TextSizeUtility.textSize18.sp),
                        ),
                      ],
                    ),

                    const TalentMenuButtonWidget()
                  ],
                ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w,top: 20.h),
            child: Row(
              children: [
                Expanded(
                  child: SearchTextField(
                      controller: searchController, hintText: "Search Courses"),
                ),
                SizedBox(
                  width: 15.w,
                ),

              ],
            ),
          ),
          Expanded(
            child:ListView.builder(
                padding: EdgeInsets.only(bottom: 20.h, top: 15.h),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {

                    },
                    child: Padding(
                      padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, bottom: 18.h),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5), //color of shadow
                          //     spreadRadius: 0, //spread radius
                          //     blurRadius: 7, // blur radius
                          //     //   offset: Offset(0, 2), // changes position of shadow
                          //     offset: Offset(0, 0), // changes position of shadow
                          //   ),
                          //   //you can set more BoxShadow() here
                          // ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                             
                              child: Image.asset(ImageUtility.dummyAppliedUserImage),
                              width: 100.w,
                              height: 100.w,
                             
                              
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Text(
                                    "How to pass an audition  successfully",

                                    style: StyleUtility
                                        .quicksandRegularBlackTextStyle
                                        .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImageUtility.calenderVerifiedIcon,
                                        width: 14.w,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                         "Uploaded on 18/8/2023",
                                         style: StyleUtility
                                            .quicksandRegular8B8B8BTextStyle
                                            .copyWith(
                                            fontSize: TextSizeUtility
                                                .textSize13.sp),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImageUtility.clockIcon,
                                        width: 14.w,
                                        color: ColorUtility.color4FCC48,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "09:00",

                                        style: StyleUtility
                                            .quicksandRegular8B8B8BTextStyle
                                            .copyWith(
                                            fontSize: TextSizeUtility
                                                .textSize13.sp),
                                      ),
                                    ],
                                  ),



                                  SizedBox(
                                    height: 17.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
