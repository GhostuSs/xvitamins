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
    required this.onYes, this.onNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        width: 343.w,
        height: 346.h
      ),
      padding: EdgeInsets.all(36.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        children: [
          Text(label,style: AppTypography.semibold.copyWith(
            fontSize: 23.w,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),),
          Text(emojy,style: TextStyle(
            fontSize: 80.w,
            color: AppColors.white
          ),),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainButton(
                onTap: onYes!,
                label: actions[0],
                width: actions.length > 1 ? 128.w : null,
                mainType: true,
                customColor:AppColors.blue,
              ),
              if(actions.length>1)const Spacer(),
              if(actions.length>1)
              MainButton(
                onTap: () => Navigator.pop(context),
                label: actions[1],
                width: actions.length > 1 ? 128.w : null,
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
