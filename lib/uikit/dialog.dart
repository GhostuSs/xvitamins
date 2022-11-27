import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

import '../gen/assets.gen.dart';
import '../utils/colors/colors.dart';

class CustomDialog extends StatelessWidget {
  final String label;
  final String emojy;
  final List<String> actions;
  final VoidCallback? onYes;
  final VoidCallback? onNo;
  const CustomDialog({
    Key? key,
    required this.label,
    required this.emojy,
    required this.actions,
    required this.onYes,
    this.onNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints.expand(width: 343.w, height: 346.h),
      padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.semibold.copyWith(
              fontSize: 21.w,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height:24.h),
          Image.asset(
            emojy,
            height: 120.h,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainButton(
                onTap: onYes!,
                label: actions[0],
                mainType: true,
                width: 120.w,
                customColor: AppColors.blue,
              ),
              if (actions.length > 1)
                const SizedBox(
                  width: 12,
                ),
              if (actions.length > 1)
                MainButton(
                  onTap: () => Navigator.pop(context),
                  label: actions[1],
                  width: 120.w,
                  mainType: true,
                  customColor: AppColors.red,
                )
            ],
          ),
        ],
      ),
    );
  }
}
