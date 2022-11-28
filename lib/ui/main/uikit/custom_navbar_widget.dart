import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:xvitamins/utils/colors/colors.dart';

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget(
      {super.key, required this.selectedIndex,
        required this.items,
        required this.onItemSelected,});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      padding:EdgeInsets.only(top: 5.0.h),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                color: isSelected
                    ? AppColors.blue : AppColors.white,),
              child: item.icon,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                    item.title ?? '',
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.blue : AppColors.gray2,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0.w,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  onItemSelected(index);
                },
                child: _buildItem(
                    item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}