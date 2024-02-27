import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/network/model/response/casterAudition/CasterHomeResponseModel.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/no_data_widget.dart';

class AuditionCreatedWidget extends StatelessWidget {
  final List<CreateAudition>? createAudition;
  const AuditionCreatedWidget({
    super.key,
    this.createAudition,
  });

  @override
  Widget build(BuildContext context) {
    return (createAudition?.length ?? 0) == 0
        ? const NoDataWidget()
        : ListView.builder(
            itemCount: createAudition?.length ?? 0,
            padding: EdgeInsets.only(bottom: 20.h, top: 15.h),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 18.h),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Shadow color
                        spreadRadius: 1, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: const Offset(0, 0), // Changes position of shadow
                      ),
                    ],),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 15,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorUtility.color703297,
                                  ColorUtility.color65389A,
                                  ColorUtility.color445DB8
                                ]),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  // "Actors are needed for a variety of roles Extras and more",
                                  createAudition?[index].description ?? "",
                                  style: StyleUtility
                                      .quicksandRegularBlackTextStyle
                                      .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                 SizedBox(
                                //  height: 13.h,
                                  height: 17.h,
                                ),


                                CustomButtonTopToBottomColor(
                                  buttonText: context.loc.buttonManage,
                                  height: 34,
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteName.manageAuditionCreatedScreen,
                                        arguments: {
                                          "auditionId":
                                              createAudition?[index].auditionId
                                        });
                                  },
                                ),
                                SizedBox(
                                //  height: 17.h,
                                  height: 28.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImageUtility.calenderIcon,
                                          width: 14.w,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          // "23/8/2023",
                                          // createAudition?[index].date != null
                                          //     ? CommonMethod.getDate(
                                          //         createAudition![index].date!)
                                          //     : "",
                                          createAudition?[index].auditionDate ?? "",
                                          style: StyleUtility
                                              .quicksandRegular8B8B8BTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize13.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImageUtility.eyeOpenIcon,
                                          width: 14.w,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          //  "230",
                                          "${createAudition?[index].totalView ?? ""}",
                                          style: StyleUtility
                                              .quicksandRegular8B8B8BTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize13.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImageUtility.userIcon,
                                          width: 14.w,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          "${createAudition?[index].totalApply ?? ""} ${context.loc.applied}",
                                          style: StyleUtility
                                              .quicksandRegular8B8B8BTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize13.sp),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            RouteName.editAuditionScreen,
                                            arguments: {
                                              "auditionId":
                                                  createAudition?[index]
                                                      .auditionId
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image.asset(
                                          ImageUtility.editIcon,
                                          width: 25.w,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
