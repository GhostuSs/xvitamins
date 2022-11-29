import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

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
      constraints: const BoxConstraints.expand(height: 317),
      padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 14.w),
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
          const SizedBox(height:24),
          Image.asset(
            emojy,
            height: 120,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainButton(
                onTap: onYes!,
                label: actions[0],
                mainType: true,
                width: actions.length>1 ? 120.w : 250.w,
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
