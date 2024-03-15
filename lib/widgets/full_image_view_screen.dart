import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';
import 'package:talent_app/utilities/text_size_utility.dart';

class FullImageViewScreen extends StatefulWidget {
  final String imageFromApi;

  const FullImageViewScreen({super.key, required this.imageFromApi});

  @override
  State<FullImageViewScreen> createState() => _FullImageViewScreenState();
}

class _FullImageViewScreenState extends State<FullImageViewScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
                    colors: ColorUtility.castHeaderGradientColor)),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 18.w, right: 18.w, top: 14.h, bottom: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BackButton(
                      color: Colors.white,
                    ),
                    Text(
                      "Image view",
                      style: StyleUtility.kantumruyProSMedium18TextStyle
                          .copyWith(fontSize: TextSizeUtility.textSize18.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),


        Expanded(child: Center(child:  CachedNetworkImage(
            width: double.infinity,
           // height: double.infinity,
          //  height: 63.sp,
          //  fit: BoxFit.contain,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
            const Center(
                child:
                CircularProgressIndicator()),
            errorWidget: (context, url,
                error) =>
                Container(
                  //  color: Colors.grey,
                    child: Center(
                        child: Icon(
                          Icons.error,
                          size: 25.sp,
                        ))),
           // imageUrl: "${Endpoints.imageBaseUrl}image-1700915169262.jpg"
            imageUrl: "https://img.freepik.com/free-vector/gradient-blue-technology-background_23-2149108578.jpg"
        ),))

          // Total audio time
        ],
      ),
    );
  }


}
