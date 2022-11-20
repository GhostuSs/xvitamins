import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool? mainType;
  final double? width;
  final Color? customColor;
  const MainButton({Key? key, required this.onTap, this.mainType, required this.label, this.width, this.customColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints.expand(
          height: 44.h,
          width: width ?? double.infinity,
        ),
        decoration: BoxDecoration(
            color: mainType==true ? customColor ?? AppColors.blue : AppColors.gray3,
            borderRadius: BorderRadius.circular(5.r)
        ),
        child: Center(
          child: Text(
            label,
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
