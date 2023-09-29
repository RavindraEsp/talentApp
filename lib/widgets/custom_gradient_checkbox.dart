import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/utilities/color_utility.dart';
import 'package:talent_app/utilities/style_utility.dart';

class CustomGradientCheckbox extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final String title;


  const CustomGradientCheckbox(
      {super.key, required this.isChecked, required this.onChanged, required this.title});

  @override
  CustomGradientCheckboxState createState() => CustomGradientCheckboxState();
}

class CustomGradientCheckboxState extends State<CustomGradientCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
            widget.onChanged.call(isChecked);
          },
          child: Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
             // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(10.r),
              gradient:
                  isChecked // if the checkbox is checked, apply a gradient to the container
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorUtility.color703297,
                            ColorUtility.color65389A,
                            ColorUtility.color445DB8

                          ],
                        )
                      : null,
              border: Border.all(color: ColorUtility.colorD6D6D8, width: 1),
            ),
            child: isChecked // if the checkbox is checked
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 26,
                  )
                : null,
          ),
        ),

        SizedBox(
          width: 8.w,
        ),
        Text(widget.title,style: StyleUtility.quicksandRegular15TextStyle.copyWith(
          color: ColorUtility.color9F9E9E
        ),)
      ],
    );
  }
}
