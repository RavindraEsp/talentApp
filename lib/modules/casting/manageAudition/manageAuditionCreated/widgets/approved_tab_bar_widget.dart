import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/chat_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';

class ApprovedTabBarWidget extends StatelessWidget {
  const ApprovedTabBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: 2,
                padding: EdgeInsets.only(top: 20.h),
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 14.w, bottom: 14.w, left: 12.w, right: 12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                            ),
                            color: ColorUtility.color5457BE,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    ImageUtility.calenderCheckIcon,
                                    width: 14.w,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    "18/8/2023",
                                    style: StyleUtility
                                        .quicksandSemiBoldWhiteTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    ImageUtility.clockIcon,
                                    width: 14.w,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "09:00",
                                    style: StyleUtility
                                        .quicksandSemiBoldWhiteTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    ImageUtility.userIcon,
                                    width: 16.w,
                                    color: ColorUtility.colorWhite,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "46/50",
                                    style: StyleUtility
                                        .quicksandSemiBoldWhiteTextStyle
                                        .copyWith(
                                            fontSize:
                                                TextSizeUtility.textSize16.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                            color: ColorUtility.colorWhite,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //spreadRadius: 5,
                                blurRadius: 4,
                                //offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: 4,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: EdgeInsets.only(
                                            left: 12.w, right: 20.w),
                                        child: Column(
                                          children: [
                                            // Container(
                                            //   height: 1,
                                            //   color: ColorUtility.colorE4E4E8,
                                            // ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                  children: [
                                                    Image.asset(
                                                      ImageUtility
                                                          .dummyProfileImage,
                                                      width: 45.sp,
                                                      height: 45.sp,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Wrap(
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "David Josef",
                                                                style: StyleUtility
                                                                    .quicksandSemiBoldBlackTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            TextSizeUtility.textSize16),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 4,
                                                                        left: 5
                                                                            .w),
                                                                child: SizedBox(
                                                                  width: 15.w,
                                                                  child: Image
                                                                      .asset(
                                                                    ImageUtility
                                                                        .eyeOpenIcon,
                                                                    color: ColorUtility
                                                                        .color8B8B8B,
                                                                    width: 15.w,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 7.h,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "25",
                                                                maxLines: 1,
                                                                style: StyleUtility
                                                                    .quicksandRegular8B8B8BTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            TextSizeUtility.textSize12),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            7.w),
                                                                child:
                                                                    Container(
                                                                  width: 1,
                                                                  color: ColorUtility
                                                                      .color8B8B8B,
                                                                  height: 10.sp,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Tel Aviv",
                                                                maxLines: 1,
                                                                style: StyleUtility
                                                                    .quicksandRegular8B8B8BTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            TextSizeUtility.textSize12),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            7.w),
                                                                child:
                                                                    Container(
                                                                  width: 1,
                                                                  color: ColorUtility
                                                                      .color8B8B8B,
                                                                  height: 10.sp,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Mail",
                                                                maxLines: 1,
                                                                style: StyleUtility
                                                                    .quicksandRegular8B8B8BTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            TextSizeUtility.textSize12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Column(
                                                  children: [
                                                    Image.asset(
                                                      ImageUtility.declineIcon,
                                                      width: 14.w,
                                                    ),
                                                    SizedBox(
                                                      height: 7.h,
                                                    ),
                                                    Text(
                                                      context.loc.decline,
                                                      style: StyleUtility
                                                          .quicksandRegular9F9E9ETextStyle
                                                          .copyWith(
                                                              fontSize:
                                                                  TextSizeUtility
                                                                      .textSize10
                                                                      .sp),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 9.h,
                                            ),
                                            Container(
                                              height: 1,
                                              color: ColorUtility.colorE4E4E8,
                                            ),
                                          ],
                                        ));
                                  }),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 16.h,
                                    left: 12.w,
                                    right: 20.w,
                                    top: 12.h),
                                child: ChatButton(
                                    buttonText:
                                        context.loc.buttonSendAGroupMessage,
                                    icon: ImageUtility.messageNavIcon,
                                    onTap: () {}),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: CustomOutlineButton(
                  buttonText: context.loc.buttonManageTimeSlots,
                  onTap: () {},
                  buttonColor: ColorUtility.color5457BE),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 17.h),
              child: CustomOutlineButton(
                  buttonText: context.loc.buttonCancelTheAudition,
                  onTap: () {},
                  buttonColor: ColorUtility.color5457BE),
            ),
            SizedBox(
              height: 35.h,
            )
          ],
        ),
      ),
    );
  }
}
