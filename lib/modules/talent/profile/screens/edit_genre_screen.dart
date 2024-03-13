import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talent_app/extension/context_extension.dart';
import 'package:talent_app/logger/app_logger.dart';import 'package:talent_app/modules/talent/profile/providers/edit_genre_screen_provider.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/common.dart';
import 'package:talent_app/utilities/common_method.dart';
import 'package:talent_app/utilities/enums.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/strings_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
import 'package:talent_app/widgets/alertDialog/congratulation_alert_dialog.dart';
import 'package:talent_app/widgets/buttons/custom_button_top_to_bottom_color.dart';
import 'package:talent_app/widgets/checkBox/category_select_widget.dart';
import 'package:talent_app/widgets/custom_circular_loader_widget.dart';

class EditGenreScreen extends StatefulWidget {
  final int id;

  const EditGenreScreen({super.key, required this.id});

  @override
  State<EditGenreScreen> createState() => _EditGenreScreenState();
}

class _EditGenreScreenState extends State<EditGenreScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Provider.of<EditGenreScreenProvider>(context, listen: false)
        .fetchTalentCategory(
            onSuccess: (message) {},
            onFailure: (message) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
                Common.showErrorToast(context, message);
              }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.colorWhite,
      body: SafeArea(
          child: Column(children: [
        Container(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Image.asset(
                ImageUtility.crossIcon,
                height: 20.w,
                width: 20.w,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Consumer<EditGenreScreenProvider>(
            builder: (context, editGenreScreenProvider, child) {
          return editGenreScreenProvider.isLoading == true
              ? const Expanded(
                  child: Center(
                  child: CustomCircularLoaderWidget(),
                ))
              : Expanded(
                  child: Form(
                    key: _formKey,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        CommonMethod.hideKeyBoard(context);
                      },
                      child: SingleChildScrollView(
                          child: Container(
                        margin:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 18.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25.h),
                            Text(
                              context.loc.titleYouCanChooseMoreThenOneCategory,
                              style: StyleUtility
                                  .quicksandSemiBold5457BETextStyle
                                  .copyWith(
                                      fontSize: TextSizeUtility.textSize16.sp),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),

                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: CategorySelectWidget(
                            //           title:
                            //           categoryModel?[0].title ?? "",
                            //           status:
                            //           categoryModel?[0].isSelect ==
                            //               true,
                            //           onTap: () {
                            //             categoryModel?[0].isSelect =
                            //             !categoryModel![0].isSelect;
                            //             setState(() {});
                            //           }),
                            //     ),
                            //     Expanded(
                            //       child: CategorySelectWidget(
                            //           title:
                            //           categoryModel?[1].title ?? "",
                            //           status:
                            //           categoryModel?[1].isSelect ==
                            //               true,
                            //           onTap: () {
                            //             categoryModel?[1].isSelect =
                            //             !categoryModel![1].isSelect;
                            //             setState(() {});
                            //           }),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 20.h,
                            // ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: CategorySelectWidget(
                            //           title:
                            //           categoryModel?[2].title ?? "",
                            //           status:
                            //           categoryModel?[2].isSelect ==
                            //               true,
                            //           onTap: () {
                            //             categoryModel?[2].isSelect =
                            //             !categoryModel![2].isSelect;
                            //             setState(() {});
                            //           }),
                            //     ),
                            //     Expanded(
                            //       child: CategorySelectWidget(
                            //           title:
                            //           categoryModel?[3].title ?? "",
                            //           status:
                            //           categoryModel?[3].isSelect ==
                            //               true,
                            //           onTap: () {
                            //             categoryModel?[3].isSelect =
                            //             !categoryModel![3].isSelect;
                            //             setState(() {});
                            //           }),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 20.h,
                            // ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: CategorySelectWidget(
                            //           title:
                            //           categoryModel?[4].title ?? "",
                            //           status:
                            //           categoryModel?[4].isSelect ==
                            //               true,
                            //           onTap: () {
                            //             categoryModel?[4].isSelect =
                            //             !categoryModel![4].isSelect;
                            //             setState(() {});
                            //           }),
                            //     ),
                            //     Expanded(
                            //       child: CategorySelectWidget(
                            //           title:
                            //           categoryModel?[5].title ?? "",
                            //           status:
                            //           categoryModel?[5].isSelect ==
                            //               true,
                            //           onTap: () {
                            //             categoryModel?[5].isSelect =
                            //             !categoryModel![5].isSelect;
                            //             setState(() {});
                            //           }),
                            //     ),
                            //   ],
                            // ),

                            Wrap(
                              children: [
                                for (var item in editGenreScreenProvider
                                    .talentCategoryResponseModel
                                    .data!
                                    .lookingForArr!)
                                  CategorySelectWidget(
                                      title: item.option ?? "",
                                      status: item.value ?? false,
                                      onTap: () {
                                        item.value = !item.value!;
                                        editGenreScreenProvider.updateUi();
                                      }),
                              ],
                            ),

                            SizedBox(
                              height: 36.h,
                            ),

                            CustomButtonTopToBottomColor(
                              width: double.infinity,
                              buttonText: context.loc.buttonUpdate,
                              onTap: () {
                                editGenreScreenProvider.setCategoryValue();

                                if ((editGenreScreenProvider
                                            .selectedLookingForIds?.length ??
                                        0) ==
                                    0) {
                                  Common.showErrorSnackBar(
                                      context, context.loc.pleaseSelectCategory);
                                } else {
                                  Common.showLoadingDialog(context);
                                  editGenreScreenProvider
                                      .updateTalentProfileData(
                                          id: widget.id,
                                          onSuccess: (message) {
                                            Navigator.pop(context);
                                            showCongratulationDialog(
                                                context: context,
                                                onButtonTap: () {});
                                          },
                                          onFailure: (message) {
                                            if (Navigator.canPop(context)) {
                                              Navigator.pop(context);
                                            }
                                            Common.showErrorSnackBar(context, message);

                                          });
                                }
                              },
                              buttonType: ButtonType.blue,
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                );
        }),
      ])),
    );
  }

  Future<dynamic> showCongratulationDialog({
    required BuildContext context,
    required VoidCallback onButtonTap,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CongratulationAlertDialog(
            title: context.loc.dialogWellDone,
            description: context.loc.dialogTalentCardSetSuccessDescription,
            buttonText: context.loc.buttonImReadyBringItOn,
            onButtonTap: onButtonTap,
            userType: UserType.talent,
          );
        }).then((value) {
      AppLogger.logD("Then is called");
      Navigator.pop(context,true);
    });
  }
}
