import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/network/model/response/casterAudition/talent_data_response_model.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';
import 'package:talent_app/widgets/textField/search_text_field.dart';

class EducationListScreen extends StatefulWidget {
  const EducationListScreen({super.key});

  @override
  State<EducationListScreen> createState() => _EducationListScreenState();
}

class _EducationListScreenState extends State<EducationListScreen> {
  TextEditingController searchController = TextEditingController();

  List<EyeColor>? eyeColorModel = [
    EyeColor(
      id: 1,
      talentId: 1,
      name: "dancing",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    ),
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Acting",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    ),
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Infront of camera",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    ),
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Reading",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    ),
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Auditions",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    ),
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Best practice",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    )
  ];

  List<EyeColor>? levelModel = [
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Novice",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    ),
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Advanced",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    ),
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Experts",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    ),
  ];

  List<EyeColor>? filterByModel = [
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Popular",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    ),
    EyeColor(
      id: 1,
      talentId: 1,
      name: "Recently added",
      datetime: "date",
      talentName: "sfsd",
      isSelect: false,
    )
  ];

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
                gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: ColorUtility.talentHeaderGradientColor)),
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
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: Row(
              children: [
                Expanded(
                  child: SearchTextField(
                      controller: searchController, hintText: "Search Courses"),
                ),
                SizedBox(
                  width: 15.w,
                ),
                GestureDetector(
                  onTap: () {
                    filterDialog(context: context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.filter,
                      size: 22,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 20.h, top: 15.h),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 15.h),
                      padding: EdgeInsets.all(10.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 120.w,
                            height: 100.w,
                            child: Image.asset(
                              ImageUtility.dummyAppliedUserImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              ],
                            ),
                          ),
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

  Future<dynamic> filterDialog({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (
          BuildContext dialogContext,
        ) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              alignment: Alignment.topCenter,
              //  insetPadding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
              insetPadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              backgroundColor: Colors.white,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(20.r))),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 15.w, right: 15.w, top: 14.w, bottom: 18.w),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  ImageUtility.crossIcon,
                                  color: ColorUtility.color29244C,
                                  width: 20.w,
                                  height: 20.w,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Filter",
                                textAlign: TextAlign.center,
                                style: StyleUtility
                                    .quicksandRegularBlackTextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize18.sp),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Done",
                                textAlign: TextAlign.center,
                                style: StyleUtility
                                    .quicksandRegularBlackTextStyle
                                    .copyWith(
                                        fontSize:
                                            TextSizeUtility.textSize18.sp),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            "Subjects",
                            textAlign: TextAlign.center,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Wrap(
                            children: [
                              // for (var item in eyeColorModel!)
                              for (var item in eyeColorModel!)
                                GestureDetector(
                                  onTap: () {
                                    item.isSelect = !item.isSelect;
                                    setState(() {});
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          right: 9.w, bottom: 13.h),
                                      padding: EdgeInsets.only(
                                          left: 15.sp,
                                          right: 20.sp,
                                          top: 9.sp,
                                          bottom: 9.sp),
                                      decoration: BoxDecoration(
                                          color: item.isSelect == false
                                              ? ColorUtility.colorWhite
                                              : ColorUtility.colorEFF2F4,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          border: Border.all(
                                              color: ColorUtility.colorD3D6D6)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            item.isSelect == false
                                                ? ImageUtility.plusIcon
                                                : ImageUtility.crossSelectIcon,
                                            width: 5.w,
                                            height: 5.w,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            item.name ?? "",
                                            style: StyleUtility
                                                .quicksandRegularBlackTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize14.sp),
                                          ),
                                        ],
                                      )),
                                )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            "Levels",
                            textAlign: TextAlign.center,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Wrap(
                            children: [
                              // for (var item in eyeColorModel!)
                              for (var item in levelModel!)
                                GestureDetector(
                                  onTap: () {
                                    item.isSelect = !item.isSelect;
                                    setState(() {});
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          right: 9.w, bottom: 13.h),
                                      padding: EdgeInsets.only(
                                          left: 15.sp,
                                          right: 20.sp,
                                          top: 9.sp,
                                          bottom: 9.sp),
                                      decoration: BoxDecoration(
                                          color: item.isSelect == false
                                              ? ColorUtility.colorWhite
                                              : ColorUtility.colorEFF2F4,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          border: Border.all(
                                              color: ColorUtility.colorD3D6D6)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            item.isSelect == false
                                                ? ImageUtility.plusIcon
                                                : ImageUtility.crossSelectIcon,
                                            width: 5.w,
                                            height: 5.w,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            item.name ?? "",
                                            style: StyleUtility
                                                .quicksandRegularBlackTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize14.sp),
                                          ),
                                        ],
                                      )),
                                )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            "Filter by",
                            textAlign: TextAlign.center,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Wrap(
                            children: [
                              // for (var item in eyeColorModel!)
                              for (var item in filterByModel!)
                                GestureDetector(
                                  onTap: () {
                                    item.isSelect = !item.isSelect;
                                    setState(() {});
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          right: 9.w, bottom: 13.h),
                                      padding: EdgeInsets.only(
                                          left: 15.sp,
                                          right: 20.sp,
                                          top: 9.sp,
                                          bottom: 9.sp),
                                      decoration: BoxDecoration(
                                          color: item.isSelect == false
                                              ? ColorUtility.colorWhite
                                              : ColorUtility.colorEFF2F4,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          border: Border.all(
                                              color: ColorUtility.colorD3D6D6)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            item.isSelect == false
                                                ? ImageUtility.plusIcon
                                                : ImageUtility.crossSelectIcon,
                                            width: 5.w,
                                            height: 5.w,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            item.name ?? "",
                                            style: StyleUtility
                                                .quicksandRegularBlackTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize14.sp),
                                          ),
                                        ],
                                      )),
                                )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        CustomButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            buttonText: "Apply"),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        }).then((value) {});
  }
}

class EyeColor {
  int? id;
  int? talentId;
  String? name;
  String? datetime;
  String? talentName;
  bool isSelect = false;

  EyeColor(
      {this.id,
      this.talentId,
      this.name,
      this.datetime,
      this.talentName,
      required this.isSelect});

  EyeColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentId = json['talentId'];
    name = json['name'];
    datetime = json['datetime'];
    talentName = json['talentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talentId'] = this.talentId;
    data['name'] = this.name;
    data['datetime'] = this.datetime;
    data['talentName'] = this.talentName;
    return data;
  }
}
