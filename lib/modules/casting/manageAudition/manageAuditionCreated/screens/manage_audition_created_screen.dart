import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/chat_button.dart';
import 'package:talent_app/widgets/buttons/custom_outline_button.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/search_text_field.dart';

class ManageAuditionCreatedScreen extends StatefulWidget {
  const ManageAuditionCreatedScreen({super.key});

  @override
  State<ManageAuditionCreatedScreen> createState() =>
      _ManageAuditionCreatedScreenState();
}

class _ManageAuditionCreatedScreenState
    extends State<ManageAuditionCreatedScreen> {
  List<String> categoryList = ["Modeling", "Acting", "Singing"];
  List<String> bodyList = [
    "Eye color: Blue",
    "Hair color: blond",
    "W :55k",
    "Pans Size : XS",
    "Shirt Size : S",
    "H :1.7cm"
  ];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 18.h),
                    child: Text(
                      context.loc.titleAuditionDescription,
                      style: StyleUtility.quicksandSemiBold5457BETextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    ),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Text(
                      "I’m looking for self-motivated, reliable, responsible and hard working person….",
                      style: StyleUtility.quicksandRegularBlackTextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              style: StyleUtility
                                  .quicksandRegular8B8B8BTextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize14.sp),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageUtility.eyeOpenIcon,
                              width: 16.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "230",
                              style: StyleUtility
                                  .quicksandRegular8B8B8BTextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize14.sp),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageUtility.userIcon,
                              width: 16.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "20 Applied",
                              style: StyleUtility
                                  .quicksandRegular8B8B8BTextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize14.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TabBar(
                    labelPadding: const EdgeInsets.all(0),
                    unselectedLabelColor: Colors.black,
                    labelColor: ColorUtility.color5457BE,
                    labelStyle: StyleUtility.unSelectTabTextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize16.sp),
                    unselectedLabelStyle: StyleUtility.hintTextStyle,
                    indicator: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: ColorUtility.blueGradientColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.r),
                      ),
                    ),
                    indicatorWeight: 1,
                    indicatorPadding:
                        EdgeInsets.only(top: 40, left: 16.w, right: 16.w),
                    tabs: const [
                      Tab(
                        child: Center(
                            child: Text(
                          //   context.loc.tabAuditionsCreated,
                          "Applied (120)",
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Tab(
                        child: Center(
                            child: Text(
                          "Approved (46)",
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 24.h,
                              ),
                              SearchTextField(
                                  controller: searchController,
                                  hintText: "Search Candidate"),
                              Text(
                                "Category",
                                style: StyleUtility
                                    .quicksandSemiBold5457BETextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize16.sp),
                              ),
                              Wrap(
                                children: [
                                  for (var item in categoryList!)
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 9.w, top: 12.h),
                                        padding: EdgeInsets.only(
                                            left: 20.sp,
                                            right: 20.sp,
                                            top: 9.sp,
                                            bottom: 12.sp),
                                        decoration: BoxDecoration(
                                            color: ColorUtility.colorWhite,
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            border: Border.all(
                                                color:
                                                    ColorUtility.colorD3D6D6)),
                                        child: Text(
                                          item,
                                          style: StyleUtility
                                              .quicksandRegularBlackTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
                                        ))
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Body",
                                style: StyleUtility
                                    .quicksandSemiBold5457BETextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize16.sp),
                              ),
                              Wrap(
                                children: [
                                  for (var item in bodyList)
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 9.w, top: 12.h),
                                        padding: EdgeInsets.only(
                                            left: 20.sp,
                                            right: 20.sp,
                                            top: 9.sp,
                                            bottom: 12.sp),
                                        decoration: BoxDecoration(
                                            color: ColorUtility.colorWhite,
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            border: Border.all(
                                                color:
                                                    ColorUtility.colorD3D6D6)),
                                        child: Text(
                                          item,
                                          style: StyleUtility
                                              .quicksandRegularBlackTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize14.sp),
                                        ))
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Intro text",
                                style: StyleUtility
                                    .quicksandSemiBold5457BETextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize16.sp),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                "I am an enthusiastic, self-motivated, reliable, responsible and hard working person. I am a mature team worker and adaptable to all challenging situations. I am able to work well both in a team environment as well as using own initiative.",
                                style: StyleUtility
                                    .quicksandRegularBlackTextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize16.sp),
                              ),
                              SizedBox(
                                height: 28.h,
                              ),
                              CustomOutlineButton(
                                buttonText: "See full profile",
                                onTap: () {},
                                buttonColor: ColorUtility.color5457BE,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              ChatButton(
                                  buttonText: "Chat with Michaela",
                                  icon: ImageUtility.messageNavIcon,
                                  onTap: () {}),
                              SizedBox(
                                height: 35.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text("f"),
                    ],
                  )),
                  SizedBox(
                    height: 38.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
