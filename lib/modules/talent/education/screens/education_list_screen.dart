import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/talent/education/model/fliter_list_response_model.dart';
import 'package:talent_app/modules/talent/education/providers/education_list_screen_provider.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/no_data_widget.dart';
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
  void initState() {
    super.initState();

    Provider.of<EducationListScreenProvider>(context, listen: false)
        .getEducationList(onFailure: (message) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      Common.showErrorToast(context, message);
    });

    Provider.of<EducationListScreenProvider>(context, listen: false).filterList(
        onFailure: (message) {
      Common.showErrorToast(context, message);
    });
  }

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
                          context.loc.headerEducation,
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
          Consumer<EducationListScreenProvider>(
              builder: (context, educationListScreenProvider, child) {
            return Expanded(
              child: educationListScreenProvider.isLoading == true
                  ? const Center(
                      child: CustomCircularLoaderWidget(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: SearchTextField(
                                    controller: searchController,
                                    hintText: context.loc.hintSearchCourses),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (educationListScreenProvider
                                          .filterLoading ==
                                      false) {
                                    filterDialog(
                                        context: context,
                                        filterData: educationListScreenProvider
                                            .filterListResponseModel?.data,
                                    educationListScreenProvider: educationListScreenProvider,

                                    onApply: (){

                                      educationListScreenProvider.isLoading = true;
                                      educationListScreenProvider.notifyListeners();
                                          AppLogger.logD("On Apply call");

                                          educationListScreenProvider.getEducationList(onFailure: (message){

                                            Common.showErrorSnackBar(context, message);

                                          });
                                    });
                                  } else {
                                    Common.showErrorSnackBar(
                                        context, "Filter list not loaded");
                                  }
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
                            child: (educationListScreenProvider
                                            .educationListResponseModel
                                            ?.data
                                            ?.length ??
                                        0) >
                                    0
                                ? ListView.builder(
                                    padding: EdgeInsets.only(
                                        bottom: 20.h, top: 15.h),
                                    itemCount: educationListScreenProvider
                                            .educationListResponseModel
                                            ?.data
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 20.w,
                                              right: 20.w,
                                              bottom: 15.h),
                                          padding: EdgeInsets.all(10.w),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // SizedBox(
                                              //   width: 120.w,
                                              //   height: 100.w,
                                              //   child: Image.asset(
                                              //     ImageUtility.dummyAppliedUserImage,
                                              //     fit: BoxFit.cover,
                                              //   ),
                                              // ),

                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: CachedNetworkImage(
                                                    width: 120.w,
                                                    height: 100.w,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Container(
                                                            color: Colors.grey,
                                                            child: Center(
                                                                child: Icon(
                                                              Icons.error,
                                                              size: 25.sp,
                                                            ))),
                                                    imageUrl:
                                                        "${Endpoints.imageBaseUrl}${educationListScreenProvider.educationListResponseModel?.data?[index].thumbnailImage ?? ""}"),
                                              ),

                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      // "How to pass an audition  successfully",
                                                      educationListScreenProvider
                                                              .educationListResponseModel
                                                              ?.data?[index]
                                                              .title ??
                                                          "",
                                                      style: StyleUtility
                                                          .quicksandRegularBlackTextStyle
                                                          .copyWith(
                                                        fontSize:
                                                            TextSizeUtility
                                                                .textSize16.sp,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          ImageUtility
                                                              .calenderVerifiedIcon,
                                                          width: 14.w,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(
                                                          // "Uploaded on 18/8/2023",
                                                          "${context.loc.uploadedOn} ${educationListScreenProvider.educationListResponseModel?.data?[index].date ?? ""}",
                                                          style: StyleUtility
                                                              .quicksandRegular8B8B8BTextStyle
                                                              .copyWith(
                                                                  fontSize:
                                                                      TextSizeUtility
                                                                          .textSize13
                                                                          .sp),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          ImageUtility
                                                              .clockIcon,
                                                          width: 14.w,
                                                          color: ColorUtility
                                                              .color4FCC48,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(
                                                          //"09:00",
                                                          educationListScreenProvider
                                                                  .educationListResponseModel
                                                                  ?.data?[index]
                                                                  .time ??
                                                              "",

                                                          style: StyleUtility
                                                              .quicksandRegular8B8B8BTextStyle
                                                              .copyWith(
                                                                  fontSize:
                                                                      TextSizeUtility
                                                                          .textSize13
                                                                          .sp),
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
                                    })
                                : const NoDataWidget())
                      ],
                    ),
            );
          }),
        ],
      ),
    );
  }

  Future<dynamic> filterDialog(
      {required BuildContext context, required Data? filterData,
        required VoidCallback onApply,
        required EducationListScreenProvider educationListScreenProvider
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
                                context.loc.titleFilter,
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
                            context.loc.titleSubjects,
                            textAlign: TextAlign.center,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        (filterData!.subjects?.length ?? 0) > 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Wrap(
                                  children: [
                                    for (var item in filterData.subjects!)
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
                                                    color: ColorUtility
                                                        .colorD3D6D6)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  item.isSelect == false
                                                      ? ImageUtility.plusIcon
                                                      : ImageUtility
                                                          .crossSelectIcon,
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
                                                          fontSize:
                                                              TextSizeUtility
                                                                  .textSize14
                                                                  .sp),
                                                ),
                                              ],
                                            )),
                                      )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            context.loc.titleLevels,
                            textAlign: TextAlign.center,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        (filterData.levels?.length ?? 0) > 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Wrap(
                                  children: [
                                    for (var item in filterData.levels!)
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
                                                    color: ColorUtility
                                                        .colorD3D6D6)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  item.isSelect == false
                                                      ? ImageUtility.plusIcon
                                                      : ImageUtility
                                                          .crossSelectIcon,
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
                                                          fontSize:
                                                              TextSizeUtility
                                                                  .textSize14
                                                                  .sp),
                                                ),
                                              ],
                                            )),
                                      )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            context.loc.titleFilterBy,
                            textAlign: TextAlign.center,
                            style: StyleUtility.quicksandSemiBold5457BETextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        (filterData.filterby?.length ?? 0) > 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Wrap(
                                  children: [
                                    for (var item in filterData.filterby!)
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
                                                    color: ColorUtility
                                                        .colorD3D6D6)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  item.isSelect == false
                                                      ? ImageUtility.plusIcon
                                                      : ImageUtility
                                                          .crossSelectIcon,
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
                                                          fontSize:
                                                              TextSizeUtility
                                                                  .textSize14
                                                                  .sp),
                                                ),
                                              ],
                                            )),
                                      )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 35.h,
                        ),
                        CustomButton(
                            onTap: () {

                              educationListScreenProvider.getIds();
                              // if(educationListScreenProvider.subjectsIds.isNotEmpty ||
                              //     educationListScreenProvider.levelsIds.isNotEmpty ||
                              //     educationListScreenProvider.filterIds.isNotEmpty){
                              //   Navigator.pop(context);
                              //   onApply.call();
                              // }
                              Navigator.pop(context);
                                 onApply.call();

                            },
                            buttonText: context.loc.buttonApply),
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
