import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/routes/route_name.dart';
import 'package:talent_app/utilities/image_utility.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteName.menuScreen);
      },
      child: Image.asset(
        ImageUtility.menuIcon,
        width: 27.w,
        height: 27.w,
      ),
    );
  }
}
