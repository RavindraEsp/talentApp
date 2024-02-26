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
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/strings_utility.dart';
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
      backgroundColor: ColorUtility.colorF4F4F4,
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
                              left: 20.w, right: 20.w, top: 24.h),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: SearchTextField(
                                    controller: searchController,
                                    hintText: context.loc.hintSearchCourses,
                                    onChange: (value) {
                                      educationListScreenProvider.listToDisplay = searchController.text.isEmpty
                                          ? educationListScreenProvider.educationListResponseModel?.data ?? []
                                          : educationListScreenProvider.educationListResponseModel?.data
                                          ?.where((item) {
                                        // Ensure a bool is always returned. If item.title is null, treat it as an empty string.
                                        var titleLower = item.title?.toLowerCase() ?? '';
                                        return titleLower.contains(searchController.text.toLowerCase());
                                      })
                                          .toList() ?? [];


                                      educationListScreenProvider.updateUi();
                                    },
                                  )
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (educationListScreenProvider
                                            .filterLoading ==
                                        false) {
                                      filterDialog(
                                          context: context,
                                          filterData:
                                              educationListScreenProvider
                                                  .filterListResponseModel
                                                  ?.data,
                                          educationListScreenProvider:
                                              educationListScreenProvider,
                                          onApply: () {
                                            educationListScreenProvider
                                                .isLoading = true;
                                            educationListScreenProvider
                                                .notifyListeners();
                                            AppLogger.logD("On Apply call");

                                            educationListScreenProvider
                                                .getEducationList(
                                                    onFailure: (message) {
                                              Common.showErrorSnackBar(
                                                  context, message);
                                            });
                                          });
                                    } else {
                                      Common.showErrorSnackBar(context,
                                          StringsUtility.filterListNotLoaded);
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        border: Border.all(
                                            color: ColorUtility.colorD6D6D8),
                                        color: Colors.white,
                                      ),
                                      child: Image.asset(
                                        ImageUtility.filterIcon,
                                        width: 18.w,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                            child: (educationListScreenProvider
                                .listToDisplay
                                ?.length ??
                                0) >
                                0
                                ? ListView.builder(
                                padding: EdgeInsets.only(
                                    bottom: 20.h, top: 22.h),
                                itemCount: educationListScreenProvider
                                    .listToDisplay
                                    ?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (educationListScreenProvider
                                          .listToDisplay?[index]
                                          .videolink !=
                                          null &&
                                          educationListScreenProvider
                                              .listToDisplay?[index]
                                              .videolink !=
                                              "") {
                                        Navigator.pushNamed(context,
                                            RouteName.videoPlayerScreen,
                                            arguments: {
                                              "videoFromApi":
                                              educationListScreenProvider.listToDisplay?[index]
                                                  .videolink ?? ""
                                            });
                                      }else{
                                        Common.showErrorSnackBar(context,
                                            StringsUtility.videoNotAvailable);

                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w,
                                          right: 20.w,
                                          bottom: 12.h),
                                      padding: EdgeInsets.only(
                                          top: 9.w,
                                          left: 9.w,
                                          right: 9.w,
                                          bottom: 11.w),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(10.r),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(7.r),
                                            child: CachedNetworkImage(
                                                width: 117.h,
                                                height: 90.h,
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
                                                "${Endpoints.imageBaseUrl}${educationListScreenProvider.listToDisplay?[index].thumbnailImage ?? ""}"),
                                          ),
                                          SizedBox(
                                            width: 8.w,
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
                                                      .listToDisplay?[index]
                                                      .title ??
                                                      "",
                                                  style: StyleUtility
                                                      .quicksandSemiBoldBlackTextStyle
                                                      .copyWith(
                                                    fontSize:
                                                    TextSizeUtility
                                                        .textSize14.sp,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 12.h,
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
                                                      color: ColorUtility
                                                          .color5457BE,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(
                                                      // "Uploaded on 18/8/2023",
                                                      "${context.loc.uploadedOn} ${educationListScreenProvider.listToDisplay?[index].date ?? ""}",
                                                      style: StyleUtility
                                                          .quicksandRegular858686TextStyle
                                                          .copyWith(
                                                          fontSize:
                                                          TextSizeUtility
                                                              .textSize12
                                                              .sp),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8.h,
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
                                                          .color5457BE,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(
                                                      //"09:00",
                                                      educationListScreenProvider
                                                          .listToDisplay?[index]
                                                          .time ??
                                                          "",

                                                      style: StyleUtility
                                                          .quicksandRegular787E84TextStyle
                                                          .copyWith(
                                                          fontSize:
                                                          TextSizeUtility
                                                              .textSize12
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


                        // Expanded(
                        //     child: (educationListScreenProvider
                        //                     .educationListResponseModel
                        //                     ?.data
                        //                     ?.length ??
                        //                 0) >
                        //             0
                        //         ? ListView.builder(
                        //             padding: EdgeInsets.only(
                        //                 bottom: 20.h, top: 22.h),
                        //             itemCount: educationListScreenProvider
                        //                     .educationListResponseModel
                        //                     ?.data
                        //                     ?.length ??
                        //                 0,
                        //             itemBuilder: (context, index) {
                        //               return GestureDetector(
                        //                 onTap: () {
                        //                   if (educationListScreenProvider
                        //                               .educationListResponseModel
                        //                               ?.data?[index]
                        //                               .videolink !=
                        //                           null &&
                        //                       educationListScreenProvider
                        //                               .educationListResponseModel
                        //                               ?.data?[index]
                        //                               .videolink !=
                        //                           "") {
                        //                     Navigator.pushNamed(context,
                        //                         RouteName.videoPlayerScreen,
                        //                         arguments: {
                        //                           "videoFromApi":
                        //                               educationListScreenProvider
                        //                                   .educationListResponseModel
                        //                                   ?.data?[index]
                        //                                   .videolink ?? ""
                        //                         });
                        //                   }else{
                        //                     Common.showErrorSnackBar(context,
                        //                         StringsUtility.videoNotAvailable);
                        //
                        //                   }
                        //                 },
                        //                 child: Container(
                        //                   margin: EdgeInsets.only(
                        //                       left: 20.w,
                        //                       right: 20.w,
                        //                       bottom: 12.h),
                        //                   padding: EdgeInsets.only(
                        //                       top: 9.w,
                        //                       left: 9.w,
                        //                       right: 9.w,
                        //                       bottom: 11.w),
                        //                   width: double.infinity,
                        //                   decoration: BoxDecoration(
                        //                     color: Colors.white,
                        //                     borderRadius:
                        //                         BorderRadius.circular(10.r),
                        //                   ),
                        //                   child: Row(
                        //                     mainAxisSize: MainAxisSize.min,
                        //                     children: [
                        //                       ClipRRect(
                        //                         borderRadius:
                        //                             BorderRadius.circular(7.r),
                        //                         child: CachedNetworkImage(
                        //                             width: 117.h,
                        //                             height: 90.h,
                        //                             fit: BoxFit.cover,
                        //                             placeholder: (context,
                        //                                     url) =>
                        //                                 const Center(
                        //                                     child:
                        //                                         CircularProgressIndicator()),
                        //                             errorWidget: (context, url,
                        //                                     error) =>
                        //                                 Container(
                        //                                     color: Colors.grey,
                        //                                     child: Center(
                        //                                         child: Icon(
                        //                                       Icons.error,
                        //                                       size: 25.sp,
                        //                                     ))),
                        //                             imageUrl:
                        //                                 "${Endpoints.imageBaseUrl}${educationListScreenProvider.educationListResponseModel?.data?[index].thumbnailImage ?? ""}"),
                        //                       ),
                        //                       SizedBox(
                        //                         width: 8.w,
                        //                       ),
                        //                       Expanded(
                        //                         child: Column(
                        //                           mainAxisSize:
                        //                               MainAxisSize.min,
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.start,
                        //                           children: [
                        //                             Text(
                        //                               // "How to pass an audition  successfully",
                        //                               educationListScreenProvider
                        //                                       .educationListResponseModel
                        //                                       ?.data?[index]
                        //                                       .title ??
                        //                                   "",
                        //                               style: StyleUtility
                        //                                   .quicksandSemiBoldBlackTextStyle
                        //                                   .copyWith(
                        //                                 fontSize:
                        //                                     TextSizeUtility
                        //                                         .textSize14.sp,
                        //                               ),
                        //                               maxLines: 2,
                        //                               overflow:
                        //                                   TextOverflow.ellipsis,
                        //                             ),
                        //                             SizedBox(
                        //                               height: 12.h,
                        //                             ),
                        //                             Row(
                        //                               crossAxisAlignment:
                        //                                   CrossAxisAlignment
                        //                                       .center,
                        //                               children: [
                        //                                 Image.asset(
                        //                                   ImageUtility
                        //                                       .calenderVerifiedIcon,
                        //                                   width: 14.w,
                        //                                   fit: BoxFit.fill,
                        //                                   color: ColorUtility
                        //                                       .color5457BE,
                        //                                 ),
                        //                                 SizedBox(
                        //                                   width: 5.w,
                        //                                 ),
                        //                                 Text(
                        //                                   // "Uploaded on 18/8/2023",
                        //                                   "${context.loc.uploadedOn} ${educationListScreenProvider.educationListResponseModel?.data?[index].date ?? ""}",
                        //                                   style: StyleUtility
                        //                                       .quicksandRegular858686TextStyle
                        //                                       .copyWith(
                        //                                           fontSize:
                        //                                               TextSizeUtility
                        //                                                   .textSize12
                        //                                                   .sp),
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                             SizedBox(
                        //                               height: 8.h,
                        //                             ),
                        //                             Row(
                        //                               crossAxisAlignment:
                        //                                   CrossAxisAlignment
                        //                                       .center,
                        //                               children: [
                        //                                 Image.asset(
                        //                                   ImageUtility
                        //                                       .clockIcon,
                        //                                   width: 14.w,
                        //                                   color: ColorUtility
                        //                                       .color5457BE,
                        //                                   fit: BoxFit.fill,
                        //                                 ),
                        //                                 SizedBox(
                        //                                   width: 5.w,
                        //                                 ),
                        //                                 Text(
                        //                                   //"09:00",
                        //                                   educationListScreenProvider
                        //                                           .educationListResponseModel
                        //                                           ?.data?[index]
                        //                                           .time ??
                        //                                       "",
                        //
                        //                                   style: StyleUtility
                        //                                       .quicksandRegular787E84TextStyle
                        //                                       .copyWith(
                        //                                           fontSize:
                        //                                               TextSizeUtility
                        //                                                   .textSize12
                        //                                                   .sp),
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               );
                        //             })
                        //         : const NoDataWidget())


                      ],
                    ),
            );
          }),
        ],
      ),
    );
  }

  Future<dynamic> filterDialog(
      {required BuildContext context,
      required Data? filterData,
      required VoidCallback onApply,
      required EducationListScreenProvider educationListScreenProvider}) {
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
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 10.w, bottom: 18.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 56.h,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(5.sp),
                                          child: Image.asset(
                                            ImageUtility.crossIcon,
                                            color: ColorUtility.color29244C,
                                            width: 20.w,
                                            height: 20.w,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        context.loc.titleFilter,
                                        textAlign: TextAlign.center,
                                        style: StyleUtility
                                            .kantumruyProBoldBlackTextStyle
                                            .copyWith(
                                                fontSize: TextSizeUtility
                                                    .textSize16.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          educationListScreenProvider.getIds();
                                          Navigator.pop(context);
                                          onApply.call();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(5.sp),
                                          child: Text(
                                            context.loc.done,
                                            textAlign: TextAlign.center,
                                            style: StyleUtility
                                                .kantumruyProMedium5457BETextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize18.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: Text(
                                  context.loc.titleSubjects,
                                  textAlign: TextAlign.center,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              (filterData!.subjects?.length ?? 0) > 0
                                  ? Wrap(
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
                                                    color:
                                                        item.isSelect == false
                                                            ? ColorUtility
                                                                .colorWhite
                                                            : ColorUtility
                                                                .colorEFF2F4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r),
                                                    border: Border.all(
                                                        color: ColorUtility
                                                            .colorD3D6D6)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      item.isSelect == false
                                                          ? ImageUtility
                                                              .plusIcon
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
                                    )
                                  : const SizedBox(),
                              SizedBox(height: 16.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Text(
                                  context.loc.titleLevels,
                                  textAlign: TextAlign.center,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              (filterData.levels?.length ?? 0) > 0
                                  ? Wrap(
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
                                                    color:
                                                        item.isSelect == false
                                                            ? ColorUtility
                                                                .colorWhite
                                                            : ColorUtility
                                                                .colorEFF2F4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r),
                                                    border: Border.all(
                                                        color: ColorUtility
                                                            .colorD3D6D6)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      item.isSelect == false
                                                          ? ImageUtility
                                                              .plusIcon
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
                                    )
                                  : const SizedBox(),
                              SizedBox(height: 16.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: Text(
                                  context.loc.titleFilterBy,
                                  textAlign: TextAlign.center,
                                  style: StyleUtility
                                      .quicksandSemiBold5457BETextStyle
                                      .copyWith(
                                          fontSize:
                                              TextSizeUtility.textSize16.sp),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              (filterData.filterby?.length ?? 0) > 0
                                  ? Wrap(
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
                                                    color:
                                                        item.isSelect == false
                                                            ? ColorUtility
                                                                .colorWhite
                                                            : ColorUtility
                                                                .colorEFF2F4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r),
                                                    border: Border.all(
                                                        color: ColorUtility
                                                            .colorD3D6D6)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      item.isSelect == false
                                                          ? ImageUtility
                                                              .plusIcon
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
                                    )
                                  : const SizedBox(),
                              // SizedBox(
                              //   height: 35.h,
                              // ),
                              // CustomButton(
                              //     onTap: () {
                              //
                              //       educationListScreenProvider.getIds();
                              //       // if(educationListScreenProvider.subjectsIds.isNotEmpty ||
                              //       //     educationListScreenProvider.levelsIds.isNotEmpty ||
                              //       //     educationListScreenProvider.filterIds.isNotEmpty){
                              //       //   Navigator.pop(context);
                              //       //   onApply.call();
                              //       // }
                              //       Navigator.pop(context);
                              //          onApply.call();
                              //
                              //     },
                              //     buttonText: context.loc.buttonApply),
                              // SizedBox(
                              //   height: 20.h,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: CustomButton(
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
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                  ],
                ),
              ),
            );
          });
        }).then((value) {});
  }
}
