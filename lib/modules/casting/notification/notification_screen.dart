import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';
import 'package:talent_app/modules/casting/notification/notification_provider.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/menu_button_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class NotificationScreen extends StatefulWidget {
  final UserType userType;

  const NotificationScreen({super.key, required this.userType});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotificationProvider>(context, listen: false).getNotification(
      userType: widget.userType == UserType.talent  ? "1" :"2",
        onFailure: (msg) {
      Common.showErrorSnackBar(context, msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: Consumer<NotificationProvider>(
          builder: (context, notificationProvider, child) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.r),
                      bottomRight: Radius.circular(40.r)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      // colors: ColorUtility.castHeaderGradientColor
                      colors: widget.userType == UserType.cast
                          ? ColorUtility.castHeaderGradientColor
                          : ColorUtility.talentHeaderGradientColor)),
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
                          context.loc.headerNotification,
                          style: StyleUtility.kantumruyProSMedium18TextStyle
                              .copyWith(
                                  fontSize: TextSizeUtility.textSize18.sp),
                        ),
                      ],
                    ),
                    widget.userType == UserType.cast
                        ? const MenuButtonWidget()
                        : const TalentMenuButtonWidget()
                  ],
                ),
              )),
            ),
            Expanded(
              child: notificationProvider.isLoading == true
                  ? const CustomCircularLoaderWidget()
                  : (notificationProvider
                                  .notificationResponseModel?.data?.length ??
                              0) >
                          0
                      ? ListView.builder(
                          padding: EdgeInsets.only(top: 20.h, bottom: 35.h),
                          itemCount: notificationProvider
                                  .notificationResponseModel?.data?.length ??
                              0,
                          // itemCount: 2,
                          itemBuilder: (context, index) {
                            // final String dateTimeString = "2023-10-05T05:58:56.000Z";
                            final String dateTimeString = notificationProvider
                                    .notificationResponseModel
                                    ?.data?[index]
                                    .datetime ??
                                "";

                            DateTime dateTime = DateTime.parse(dateTimeString);

                            // Format the date and time using DateFormat
                            String formattedDateTime =
                                DateFormat.yMd().add_jm().format(dateTime);

                            AppLogger.logD("Date Time $formattedDateTime");

                            return Column(

                              children: [
                                index == 0
                                    ? Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: ColorUtility.colorD6D6D8)
                                    : const SizedBox(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w,
                                      right: 20.w,
                                      top: 17.h,
                                      bottom: 20.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        ImageUtility.dummyProfileImage,
                                        width: 43.w,
                                        height: 43.w,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // RichText(
                                          //   overflow: TextOverflow.ellipsis,
                                          //   maxLines: 2,
                                          //   text: TextSpan(
                                          //     text: "Shir ivci",
                                          //     style: StyleUtility
                                          //         .quicksandBoldBlackTextStyle
                                          //         .copyWith(
                                          //       fontSize: TextSizeUtility.textSize15.sp,
                                          //     ),
                                          //     children: <TextSpan>[
                                          //       TextSpan(
                                          //         text: " has withdrawn your audition",
                                          //         style: StyleUtility
                                          //             .quicksandRegularBlackTextStyle
                                          //             .copyWith(
                                          //           fontSize:
                                          //               TextSizeUtility.textSize15.sp,
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),

                                          Text(
                                            notificationProvider
                                                    .notificationResponseModel
                                                    ?.data?[index]
                                                    .message ??
                                                "",
                                            style: StyleUtility
                                                .quicksandRegularBlackTextStyle
                                                .copyWith(
                                              fontSize:
                                                  TextSizeUtility.textSize15.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.w,
                                          ),
                                          Text(
                                            //  "5 min ago",
                                            formattedDateTime,
                                            style: StyleUtility
                                                .quicksandSemiBold76768BTextStyle
                                                .copyWith(
                                                    fontSize: TextSizeUtility
                                                        .textSize12.sp),
                                          )
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
                            );
                          })
                      : Center(
                          child: Text(
                            context.loc.noAnyNotification,
                            style: StyleUtility.quicksandRegularBlackTextStyle
                                .copyWith(
                                    fontSize: TextSizeUtility.textSize15.sp),
                          ),
                        ),
            )
          ],
        );
      }),
    );
  }
}
