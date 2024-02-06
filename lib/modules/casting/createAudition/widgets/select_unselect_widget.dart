import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/modules/casting/createAudition/models/audition_property_model.dart';
import 'package:talent_app/modules/casting/createAudition/models/talentdata_response_model_new.dart';
//import 'package:talent_app/network/model/response/casterAudition/talent_data_response_model.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/image_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';
//
// class SelectUnselectWidget extends StatelessWidget {
//   final VoidCallback onTap;
//   final EyeColor item;
//
//   const SelectUnselectWidget(
//       {super.key, required this.onTap, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//           margin: EdgeInsets.only(right: 9.w, bottom: 13.h),
//           padding: EdgeInsets.only(
//               left: 15.sp, right: 20.sp, top: 9.sp, bottom: 9.sp),
//           decoration: BoxDecoration(
//               color: item.isSelect == false
//                   ? ColorUtility.colorWhite
//                   : ColorUtility.colorEFF2F4,
//               borderRadius: BorderRadius.circular(30.r),
//               border: Border.all(color: ColorUtility.colorD3D6D6)),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 item.isSelect == false
//                     ? ImageUtility.plusIcon
//                     : ImageUtility.crossSelectIcon,
//                 width: 6.w,
//                 height: 6.w,
//               ),
//               SizedBox(
//                 width: 5.w,
//               ),
//               Text(
//                 item.name ?? "",
//                 style: StyleUtility.quicksandRegularBlackTextStyle
//                     .copyWith(fontSize: TextSizeUtility.textSize14.sp),
//               ),
//             ],
//           )),
//     );
//   }
// }
//




class SelectUnselectWidgetEdit extends StatelessWidget {
  final VoidCallback onTap;
  final AuditionPropertyModel item;

  const SelectUnselectWidgetEdit(
      {super.key, required this.onTap, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(right: 9.w, bottom: 13.h),
          padding: EdgeInsets.only(
              left: 15.sp, right: 20.sp, top: 9.sp, bottom: 9.sp),
          decoration: BoxDecoration(
              color: item.isSelect == false
                  ? ColorUtility.colorWhite
                  : ColorUtility.colorEFF2F4,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: ColorUtility.colorD3D6D6)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                item.isSelect == false
                    ? ImageUtility.plusIcon
                    : ImageUtility.crossSelectIcon,
                width: 6.w,
                height: 6.w,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                item.title ?? "",
                style: StyleUtility.quicksandRegularBlackTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize14.sp),
              ),
            ],
          )),
    );
  }
}



class LookingForWidget extends StatelessWidget {
  final VoidCallback onTap;
  final LookingFor item;

  const LookingForWidget(
      {super.key, required this.onTap, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(right: 9.w, bottom: 13.h),
          padding: EdgeInsets.only(
              left: 15.sp, right: 20.sp, top: 9.sp, bottom: 9.sp),
          decoration: BoxDecoration(
              color: item.isSelect == false
                  ? ColorUtility.colorWhite
                  : ColorUtility.colorEFF2F4,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: ColorUtility.colorD3D6D6)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                item.isSelect == false
                    ? ImageUtility.plusIcon
                    : ImageUtility.crossSelectIcon,
                width: 6.w,
                height: 6.w,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                item.name ?? "",
                style: StyleUtility.quicksandRegularBlackTextStyle
                    .copyWith(fontSize: TextSizeUtility.textSize14.sp),
              ),
            ],
          )),
    );
  }
}
