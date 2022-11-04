import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class SettingsButton extends StatelessWidget {
  final String label;
  final bool? isPrem;
  final VoidCallback? onTap;
  const SettingsButton({
    Key? key,
    required this.label,
    this.isPrem,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6.h,
      ),
      child: InkWell(
        onTap: onTap,
        radius: 5.r,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isPrem == true ? AppColors.blue : AppColors.gray3,
            borderRadius: BorderRadius.circular(
              5.r,
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTypography.semibold.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isPrem == true ? AppColors.white : AppColors.black,
                  fontSize: 14.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
