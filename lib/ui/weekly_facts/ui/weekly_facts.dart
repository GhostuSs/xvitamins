import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/data/weekly_facts.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: ListView(
          children: [
            Text(
              WeeklyFacts.title,
              style: AppTypography.bold.copyWith(
                fontSize: 32.w,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              WeeklyFacts.facts,
              style: AppTypography.regular.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16.w,
              ),
            )
          ],
        ),
      ),
    );
  }
}
