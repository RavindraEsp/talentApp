import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class ManageFinishedAuditionScreen extends StatefulWidget {
  const ManageFinishedAuditionScreen({super.key});

  @override
  State<ManageFinishedAuditionScreen> createState() =>
      _ManageFinishedAuditionScreenState();
}

class _ManageFinishedAuditionScreenState
    extends State<ManageFinishedAuditionScreen> {
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
                        const BackButton(
                          color: Colors.white,
                        ),
                        Text(
                          context.loc.headerManageAudition,
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
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.loc.titleAuditionDescription,
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Text(
                      "I’m looking for self-motivated, reliable, responsible and hard working person….",
                      style: StyleUtility.quicksandRegularBlackTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageUtility.calenderIcon,
                          width: 16.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "23/8/2023",
                          style: StyleUtility.quicksandRegular8B8B8BTextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize14.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 38.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 6,
                            child: Text(
                              context.loc.titleCandidates,
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16),
                            )),
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: Text(
                              context.loc.titleEntrant,
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize12),
                            ))),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: Text(
                              context.loc.titleAccepted,
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize12),
                            ))),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const CandidateListWidget(),
                    SizedBox(
                      height: 35.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CandidateListWidget extends StatelessWidget {
  const CandidateListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 7.h),
        primary: false,
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                children: [
                  Container(
                    height: 1,
                    color: ColorUtility.colorE4E4E8,
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              Image.asset(
                                ImageUtility.dummyProfileImage,
                                width: 45.sp,
                                height: 45.sp,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Text(
                                          "David Josef",
                                          style: StyleUtility
                                              .quicksandSemiBoldBlackTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize16),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 4, left: 5.w),
                                          child: SizedBox(
                                            width: 15.w,
                                            child: Image.asset(
                                              ImageUtility.eyeOpenIcon,
                                              color: ColorUtility.color8B8B8B,
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
                                                  fontSize: TextSizeUtility
                                                      .textSize12),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7.w),
                                          child: Container(
                                            width: 1,
                                            color: ColorUtility.color8B8B8B,
                                            height: 10.sp,
                                          ),
                                        ),
                                        Text(
                                          "Tel Aviv",
                                          maxLines: 1,
                                          style: StyleUtility
                                              .quicksandRegular8B8B8BTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize12),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7.w),
                                          child: Container(
                                            width: 1,
                                            color: ColorUtility.color8B8B8B,
                                            height: 10.sp,
                                          ),
                                        ),
                                        Text(
                                          "Mail",
                                          maxLines: 1,
                                          style: StyleUtility
                                              .quicksandRegular8B8B8BTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize12),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Center(
                              child: Image.asset(
                            ImageUtility.verifyBlueIcon,
                            width: 28.w,
                          ))),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                          flex: 2,
                          child: Center(
                              child: Image.asset(
                            ImageUtility.verifyGreenIcon,
                            width: 28.w,
                          ))),
                    ],
                  ),
                ],
              ));
        });
  }
}
