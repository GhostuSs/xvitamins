import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class NoteWidget extends StatelessWidget {
  final String note;
  const NoteWidget({Key? key, required this.note,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Note',
            style: AppTypography.semibold.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20.w,
              color: AppColors.black,
            )),
        SizedBox(
          height: 8.h,
        ),
        Wrap(
          children: [
            Text(
              note,
              textAlign: TextAlign.center,
              style: AppTypography.medium.copyWith(
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
