import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_app/modules/casting/manageAudition/manageAuditionCreated/widgets/applied_user_detail_widget.dart';
import 'package:talent_app/utilities/color_utility.dart';


class AppliedViewPagerWidget extends StatefulWidget {
  const AppliedViewPagerWidget({Key? key}) : super(key: key);

  @override
  State<AppliedViewPagerWidget> createState() => _AppliedViewPagerWidgetState();
}

class _AppliedViewPagerWidgetState extends State<AppliedViewPagerWidget> {
  // declare and initizlize the page controller
  final PageController _pageController = PageController(initialPage: 0);

  // the index of the current page
  int _activePage = 0;

  final List<Widget> _pages = [
    const AppliedUserDetailWidget(),
    const AppliedUserDetailWidget(),
    const AppliedUserDetailWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 9.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  _pages.length,
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        _pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        height: 4.h,
                        width: 68.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: _activePage == index
                                ? ColorUtility.color3D2D82
                                : ColorUtility.colorWhite),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

