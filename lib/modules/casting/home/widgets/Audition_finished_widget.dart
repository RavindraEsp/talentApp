import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/network/model/response/casterAudition/CasterHomeResponseModel.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/confirm_alert_dialog.dart';
import 'package:talent_app/widgets/alertDialog/success_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/no_data_widget.dart';

class AuditionFinishedWidget extends StatelessWidget {
  final List<CreateAudition>? finishedAudition;

  const AuditionFinishedWidget({
    super.key,
    this.finishedAudition,
  });

  @override
  Widget build(BuildContext context) {
    return (finishedAudition?.length ?? 0) == 0
        ? const NoDataWidget()
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 20.h, top: 15.h),
            // itemCount: 2,
            itemCount: finishedAudition?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 18.h),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
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
                                  ColorUtility.color4FCC48,
                                  ColorUtility.color31B42C,
                                  ColorUtility.color1B9D16
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
                                Text(
                                  // "Actors are needed for a variety of roles Extras and more",
                                  finishedAudition?[index].description ?? "",
                                  style: StyleUtility
                                      .quicksandRegularBlackTextStyle
                                      .copyWith(
                                    fontSize: TextSizeUtility.textSize16.sp,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                CustomButtonTopToBottomColor(
                                  buttonText: context.loc.buttonManage,
                                  height: 34,
                                  buttonType: ButtonType.green,
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteName.manageFinishedAuditionScreen);
                                  },
                                ),
                                SizedBox(
                                  height: 17.h,
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
                                          finishedAudition?[index].date != null
                                              ? CommonMethod.getDate(
                                                  finishedAudition![index]
                                                      .date!)
                                              : "",
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
                                          // "230",
                                          "${finishedAudition?[index].totalView ?? ""}",
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
                                          "${finishedAudition?[index].totalApply ?? ""} ${context.loc.applied}",
                                          style: StyleUtility
                                              .quicksandRegular8B8B8BTextStyle
                                              .copyWith(
                                                  fontSize: TextSizeUtility
                                                      .textSize13.sp),
                                        ),
                                      ],
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
