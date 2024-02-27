import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/talent/menu/provider/denied_audition_provider.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/no_data_widget.dart';

class DeniedAuditionScreen extends StatefulWidget {
  const DeniedAuditionScreen({super.key});

  @override
  State<DeniedAuditionScreen> createState() => _DeniedAuditionScreenState();
}

class _DeniedAuditionScreenState extends State<DeniedAuditionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DeniedAuditionProvider>(context, listen: false)
        .getDeniedAuditionList(onFailure: (message) {
      Common.showErrorSnackBar(context, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtility.colorWhite,
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black, // <-- SEE HERE
          ),
          backgroundColor: ColorUtility.colorWhite,
          centerTitle: true,
          elevation: 0,
          title: Text(
            // context.loc.headerMenu,
            "Denied Audition",
            style: StyleUtility.kantumruyProMedium5457BETextStyle
                .copyWith(fontSize: TextSizeUtility.textSize20.sp),
          ),
        ),
        body: Consumer<DeniedAuditionProvider>(
            builder: (context, deniedAuditionProvider, child) {
          return deniedAuditionProvider.isLoading == true
              ? const CustomCircularLoaderWidget()
              : (deniedAuditionProvider
                              .deniedAuditionResponseModel?.data?.length ??
                          0) ==
                      0
                  ? const NoDataWidget()
                  : ListView.builder(
                      itemCount: deniedAuditionProvider
                              .deniedAuditionResponseModel?.data?.length ??
                          0,
                      padding: EdgeInsets.only(bottom: 20.h, top: 15.h),
                      itemBuilder: (context, index) {
                        var deniedAudition = deniedAuditionProvider
                            .deniedAuditionResponseModel?.data;
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 18.h),
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
                                      color: ColorUtility.colorDD4F4F,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                                    //  "Audition date 18/8/2023 | 19/8/2023",
                                                    "${context.loc.auditionDate} ${deniedAudition?[index].getAuditionDateArr?[0].date ?? ""}",
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
                                          SizedBox(
                                            height: 17.h,
                                          ),
                                          Text(
                                            // "Actors are needed for a variety of roles Extras and more",
                                            deniedAudition?[index]
                                                    .description ??
                                                "",
                                            style: StyleUtility
                                                .quicksandRegularBlackTextStyle
                                                .copyWith(
                                              fontSize:
                                                  TextSizeUtility.textSize16.sp,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 13.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorUtility.colorDD4F4F,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r),
                                                ),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      // Navigator.pushNamed(context,
                                                      //     RouteName.auditionDetailScreen,
                                                      //     arguments: {
                                                      //       "auditionDetailType":
                                                      //           AuditionDetailType.denied
                                                      //     });

                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteName
                                                              .auditionDetailScreen,
                                                          arguments: {
                                                            "auditionDetailType":
                                                                AuditionDetailType
                                                                    .denied,
                                                            "auditionId":
                                                                deniedAudition?[
                                                                        index]
                                                                    .auditionId,
                                                          });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.r)),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1.w),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              context.loc
                                                                  .buttonDeniedAudition,
                                                              maxLines: 1,
                                                              style: StyleUtility
                                                                  .buttonTextStyle
                                                                  .copyWith(
                                                                fontSize:
                                                                    TextSizeUtility
                                                                        .textSize16
                                                                        .sp,
                                                              )),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Common.showLoadingDialog(context);
                                                  deniedAuditionProvider
                                                      .deleteDeniedAudition(
                                                          onFailure: (message) {
                                                            if (Navigator.canPop(context)) {
                                                              Navigator.pop(context);
                                                            }
                                                            Common.showErrorToast(context,message);
                                                          },
                                                          onSuccess: (message) {
                                                            Navigator.pop(context);
                                                            Common.showSuccessToast(context,message);
                                                          },
                                                          appliedId:
                                                          deniedAudition?[index].applyId,
                                                          index: index);
                                                },
                                                child: Text(
                                                  context.loc.delete,
                                                  style: StyleUtility
                                                      .kantumruyProRegularDD4F4FTextStyle
                                                      .copyWith(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
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
        }));
  }
}
