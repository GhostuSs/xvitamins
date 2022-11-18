import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool? mainType;
  const MainButton({Key? key, required this.onTap, this.mainType, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints.expand(
          height: 44.h,
        ),
        decoration: BoxDecoration(
            color: mainType==true ? AppColors.blue : AppColors.gray3,
            borderRadius: BorderRadius.circular(5.r)
        ),
        child: Center(
          child: Text(
            'Monthly statistics',
            style: AppTypography.medium.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14.w,
              color: mainType==true ? AppColors.white :AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
