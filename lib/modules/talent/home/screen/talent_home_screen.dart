import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/modules/talent/home/providers/talent_home_screen_provider.dart';
import 'package:talent_app/modules/talent/home/widgets/approved_audition_widget.dart';
import 'package:talent_app/modules/talent/home/widgets/audition_for_you_widget.dart';
import 'package:talent_app/modules/talent/home/widgets/promoted_dialog.dart';
import 'package:talent_app/modules/talent/widgets/talent_menu_widget.dart';
import 'package:talent_app/network/end_points.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/shared_preference.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';
import 'package:talent_app/widgets/setting_button_widget.dart';

class TalentHomeScreen extends StatefulWidget {
  final int selectHomeTab;
  const TalentHomeScreen({super.key, required this.selectHomeTab});

  @override
  State<TalentHomeScreen> createState() => _TalentHomeScreenState();
}

class _TalentHomeScreenState extends State<TalentHomeScreen> with SingleTickerProviderStateMixin{

  TabController? _tabController ;


  @override
  void initState() {
    super.initState();


 _tabController = TabController(length: 2, vsync: this, initialIndex: widget.selectHomeTab);
 //_tabController = TabController(length: 2, vsync: this, initialIndex: 1);


    Provider.of<TalentHomeScreenProvider>(context, listen: false)
        .getHomeDataForTalent(onFailure: (message) {
      Common.showErrorSnackBar(context, message);
    });

    Provider.of<TalentHomeScreenProvider>(context, listen: false)
        .getBoostPlan(onFailure: (message) {
      Common.showErrorSnackBar(context, message);
    });

  }




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50.sp),
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.r),
                          bottomRight: Radius.circular(40.r)),
                      gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: ColorUtility.talentHeaderGradientColor)),
                  child: SafeArea(
                    child: Container(
                      height: 124.h,
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 18.w, right: 18.w, top: 24.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SettingButtonWidget(),
                            Text(
                              "${context.loc.helloUserName} ${Preference().getUserName()}",
                              style: StyleUtility.kantumruyProSMedium18TextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize18.sp),
                            ),
                            const TalentMenuButtonWidget()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Image.asset(
                //   ImageUtility.dummyProfileImage,
                //   width: 100.sp,
                //   height: 100.sp,
                //   fit: BoxFit.fill,
                // )

                Consumer<TalentHomeScreenProvider>(

                  builder: (context, talentHomeScreenProvider,child) {
                    return Positioned(
                      bottom: 10.sp,
                      left: 187.w,
                      child: GestureDetector(
                        onTap: (){
                          boostBottomSheet(talentHomeScreenProvider);
                        //  showPromotedDialog(context: context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(right:15.sp,left: 65.sp),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors:ColorUtility.boostGradientColor
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.r),
                                bottomRight: Radius.circular(30.r),
                              )
                          ),
                          height: 32.sp,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(ImageUtility.boostIcon,
                                height: 27.sp,),

                              Padding(
                                padding:  EdgeInsets.only(left: 7.w),
                                child: Text(
                                //  "5/20",
                                  "${Preference().getBoosterCount()}",
                                  style: StyleUtility.quicksandMediumWhiteTextStyle.copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp
                                  ),),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                ),

                ClipOval(
                  child: CachedNetworkImage(
                      width: 100.sp,
                      height: 100.sp,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Container(
                          color: Colors.grey,
                          child: Center(
                              child: Icon(
                            Icons.error,
                            size: 25.sp,
                          ))),
                    imageUrl:
                          "${Endpoints.imageBaseUrl}${Preference().getProfileImage()}"),
                ),


              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            TabBar(
              controller: _tabController,
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

              tabs: [
                Tab(
                  child: Center(
                      child: Text(
                    context.loc.tabAuditionForYou,
                    textAlign: TextAlign.center,
                  )),
                ),
                Tab(
                  child: Center(
                      child: Text(
                    context.loc.tabApprovedAuditions,
                    textAlign: TextAlign.center,
                  )),
                ),
              ],
            ),
            Expanded(child: Consumer<TalentHomeScreenProvider>(
                builder: (context, talentHomeScreenProvider, child) {
              return TabBarView(
                controller: _tabController,
                children: [
                  talentHomeScreenProvider.isLoading == true
                      ? const CustomCircularLoaderWidget()
                      : AuditionForYouWidget(
                          auditionforyouList: talentHomeScreenProvider
                              .talentHomeResponseModel
                              ?.data
                              ?.auditionforyouList,
                          talentHomeScreenProvider: talentHomeScreenProvider,
                        ),
                  talentHomeScreenProvider.isLoading == true
                      ? const CustomCircularLoaderWidget()
                      : ApprovedAuditionWidget(
                          approvedAuditionList: talentHomeScreenProvider
                              .talentHomeResponseModel
                              ?.data
                              ?.approvedAuditionList,
                          talentHomeScreenProvider: talentHomeScreenProvider),
                ],
              );
            }))
          ],
        ),
      ),
    );
  }

  boostBottomSheet(TalentHomeScreenProvider talentHomeScreenProvider) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
                top: 20.h, bottom: 35.h, left: 15.w, right: 15.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          ImageUtility.crossIcon,
                          width: 20.sp,
                          height: 20.sp,
                        ),
                      )),
                  Text(
                    context.loc.titleBoostYourProfile,
                    style: StyleUtility.kantumruyProSemiBold5457BETextStyle
                        .copyWith(fontSize: TextSizeUtility.textSize22.sp),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      context.loc.descriptionBoostYourProfile,
                      style:
                      StyleUtility.quicksandRegularBlackTextStyle.copyWith(
                        fontSize: TextSizeUtility.textSize16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(vertical: 10.h),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10.r),
                  //             border:
                  //                 Border.all(color: ColorUtility.colorD6D6D8)),
                  //         child: Column(
                  //           children: [
                  //             Text(
                  //               '10',
                  //               style: StyleUtility
                  //                   .kantumruyProSemiBold5457BETextStyle
                  //                   .copyWith(
                  //                       fontSize:
                  //                           TextSizeUtility.textSize22.sp),
                  //             ),
                  //             SizedBox(
                  //               height: 5.h,
                  //             ),
                  //             Text(
                  //               'Boost',
                  //               style: StyleUtility
                  //                   .kantumruyProSemiBold5457BETextStyle
                  //                   .copyWith(
                  //                       fontSize:
                  //                           TextSizeUtility.textSize16.sp),
                  //             ),
                  //             SizedBox(
                  //               height: 8.h,
                  //             ),
                  //             Text(
                  //               '₪180',
                  //               style: StyleUtility
                  //                   .quicksandSemiBoldBlackTextStyle
                  //                   .copyWith(
                  //                       fontSize:
                  //                           TextSizeUtility.textSize16.sp),
                  //             ),
                  //             SizedBox(
                  //               height: 12.h,
                  //             ),
                  //             CustomButtonTopToBottomColor(
                  //               height: 35,
                  //               buttonText: "Boost Me",
                  //               padding: 0.0,
                  //               textStyle: StyleUtility.buttonTextStyle
                  //                   .copyWith(
                  //                       fontSize:
                  //                           TextSizeUtility.textSize12.sp),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 7.w,
                  //     ),
                  //     Expanded(
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(vertical: 10.h),
                  //         decoration: BoxDecoration(
                  //           color: ColorUtility.color5457BE,
                  //             borderRadius: BorderRadius.circular(10.r),
                  //             border:
                  //             Border.all(color: ColorUtility.color5457BE)),
                  //         child: Column(
                  //           children: [
                  //             Text(
                  //               '10',
                  //               style: StyleUtility
                  //                   .kantumruyProSemiBoldWhiteTextStyle
                  //                   .copyWith(
                  //                   fontSize:
                  //                   TextSizeUtility.textSize22.sp),
                  //             ),
                  //             SizedBox(
                  //               height: 5.h,
                  //             ),
                  //             Text(
                  //               'Boost',
                  //               style: StyleUtility
                  //                   .kantumruyProSemiBoldWhiteTextStyle
                  //                   .copyWith(
                  //                   fontSize:
                  //                   TextSizeUtility.textSize16.sp),
                  //             ),
                  //             SizedBox(
                  //               height: 8.h,
                  //             ),
                  //             Text(
                  //               '₪180',
                  //               style: StyleUtility
                  //                   .kantumruyProSemiBoldWhiteTextStyle
                  //                   .copyWith(
                  //                   fontSize:
                  //                   TextSizeUtility.textSize16.sp),
                  //             ),
                  //             SizedBox(
                  //               height: 12.h,
                  //             ),
                  //             Container(
                  //               height: 35,
                  //               decoration: BoxDecoration(
                  //                color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(30.r),
                  //               ),
                  //               child: ElevatedButton(
                  //                   onPressed: (){},
                  //                   style: ElevatedButton.styleFrom(
                  //                     backgroundColor: Colors.transparent,
                  //                     shadowColor: Colors.transparent.withOpacity(0.1),
                  //                     shape: RoundedRectangleBorder(
                  //                         borderRadius: BorderRadius.circular(30.r)),
                  //                   ),
                  //                   child: Padding(
                  //                     padding: EdgeInsets.symmetric(horizontal: 0.0),
                  //                     child: Row(
                  //                       mainAxisSize: MainAxisSize.min,
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       crossAxisAlignment: CrossAxisAlignment.center,
                  //                       children: [
                  //
                  //
                  //                         Text("Boost Me",
                  //                             maxLines: 1,
                  //                         style:  StyleUtility
                  //                               .kantumruyProSemiBold5457BETextStyle
                  //                               .copyWith(
                  //                           color: ColorUtility.color5457BE,
                  //                               fontSize:
                  //                               TextSizeUtility.textSize12.sp),),
                  //                       ],
                  //                     ),
                  //                   )),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 7.w,
                  //     ),
                  //     Expanded(
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(vertical: 10.h),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10.r),
                  //             border:
                  //             Border.all(color: ColorUtility.colorD6D6D8)),
                  //         child: Column(
                  //           children: [
                  //             Text(
                  //               '1',
                  //               style: StyleUtility
                  //                   .kantumruyProSemiBold5457BETextStyle
                  //                   .copyWith(
                  //                   fontSize:
                  //                   TextSizeUtility.textSize22.sp),
                  //             ),
                  //             SizedBox(
                  //               height: 5.h,
                  //             ),
                  //             Text(
                  //               'Boost',
                  //               style: StyleUtility
                  //                   .kantumruyProSemiBold5457BETextStyle
                  //                   .copyWith(
                  //                   fontSize:
                  //                   TextSizeUtility.textSize16.sp),
                  //             ),
                  //             SizedBox(
                  //               height: 8.h,
                  //             ),
                  //             Text(
                  //               '₪20',
                  //               style: StyleUtility
                  //                   .quicksandSemiBoldBlackTextStyle
                  //                   .copyWith(
                  //                   fontSize:
                  //                   TextSizeUtility.textSize16.sp),
                  //             ),
                  //             SizedBox(
                  //               height: 12.h,
                  //             ),
                  //             CustomButtonTopToBottomColor(
                  //               height: 35,
                  //               buttonText: "Boost Me",
                  //               padding: 0.0,
                  //               textStyle: StyleUtility.buttonTextStyle
                  //                   .copyWith(
                  //                 color: ColorUtility.colorWhite,
                  //                   fontSize:
                  //                   TextSizeUtility.textSize12.sp),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),


                  SizedBox(
                    height: 170.h,
                    child: ListView.builder(
                      //  itemCount: 4,
                        itemCount: talentHomeScreenProvider.boostPlanResponseModel.data?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){

                          var boostData = talentHomeScreenProvider.boostPlanResponseModel.data?[index];
                          return Container(
                            // padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            margin: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border:
                                Border.all(color: ColorUtility.colorD6D6D8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                //  '10',
                                  "${boostData?.count ?? ""}",
                                  style: StyleUtility
                                      .kantumruyProSemiBold5457BETextStyle
                                      .copyWith(
                                      fontSize:
                                      TextSizeUtility.textSize22.sp),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  context.loc.boost,
                                  style: StyleUtility
                                      .kantumruyProSemiBold5457BETextStyle
                                      .copyWith(
                                      fontSize:
                                      TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                 // '₪180',
                                  "₪${boostData?.price ?? ""}",
                                  style: StyleUtility
                                      .quicksandSemiBoldBlackTextStyle
                                      .copyWith(
                                      fontSize:
                                      TextSizeUtility.textSize16.sp),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                CustomButtonTopToBottomColor(
                                  height: 35,
                                  buttonText: context.loc.buttonBoostMe,
                                  padding: 0.0,
                                  textStyle: StyleUtility.buttonTextStyle
                                      .copyWith(
                                      fontSize:
                                      TextSizeUtility.textSize12.sp),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              )
            ),
          );
        });
  }


  Future<dynamic> showPromotedDialog({
    required BuildContext context,

  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return const PromotedAlertDialog(

            title: "Your profile has been promoted for this audition"
          );
        }).then((value) {});
  }




}
