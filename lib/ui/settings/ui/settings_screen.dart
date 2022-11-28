import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:xvitamins/data/goalday/goalday.dart';
import 'package:xvitamins/ui/settings/uikit/settings_button.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

import '../../../data/GDays/gdays.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback navigateToOnb;
  const SettingsScreen({Key? key, required this.navigateToOnb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: AppColors.gray2,
        width: 0.5.w,
      ))),
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 20.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Settings',
                      style: AppTypography.semibold.copyWith(
                        fontSize: 20.w,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              if (Hive.box<bool>('premium').values.first == false)
                SettingsButton(
                  label: 'Buy Premium😎',
                  isPrem: true,
                  onTap: () => navigateToOnb(),
                ),
              if (Hive.box<bool>('premium').values.first == true)
                SettingsButton(
                  label: 'Set the Goal',
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => GoalDialog(),
                  ),
                ),
              const SettingsButton(
                label: 'Privacy Policy',
              ),
              const SettingsButton(
                label: 'Terms of Use',
              ),
              const SettingsButton(
                label: 'Support',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoalDialog extends StatefulWidget {
  const GoalDialog({Key? key}) : super(key: key);

  @override
  State<GoalDialog> createState() => _GoalDialogState();
}

class _GoalDialogState extends State<GoalDialog> {
  int _currentIntValue = 400;
  @override
  void initState() {
    _currentIntValue = Hive.box<int>('dailygoal').values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Container(
        width: 343.w,
        height: 310.h,
        padding: EdgeInsets.all(36.w),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Daily Goal',
              style: AppTypography.semibold.copyWith(
                fontSize: 24.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 24.h),
            NumberPicker(
              value: _currentIntValue,
              minValue: 200,
              maxValue: 800,
              textStyle: AppTypography.semibold.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.w,
                  color: AppColors.gray3),
              selectedTextStyle: AppTypography.semibold.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 32.w,
                  color: AppColors.blue),
              step: 10,
              haptics: true,
              onChanged: (value) => setState(() => _currentIntValue = value),
            ),
            const Spacer(),
            MainButton(
              onTap: () async {
                //TODO:Доработать условие изменения
                await Hive.box<int>('dailygoal')
                    .put('dailygoal', _currentIntValue);
                if(Hive.box<GDays>('goals').values.first.days?.where((el)=>el.completed==true).isNotEmpty==true){
                  for(final GoalDay data in Hive.box<GDays>('goals').values.first.days?.where((el)=>el.completed==true)??[]){
                    int sum =0;
                    for(final food in data.food!){
                      sum+=food.gramms!;
                    }
                    if(sum<Hive.box<int>('dailygoal').values.first==true){
                      data.completed=false;
                    }else{
                      data.completed=true;
                    }
                    final newData = Hive.box<GDays>('goals').values.first;
                    await Hive.box<GDays>('goals').put('goals', newData);
                  }
                }
                Navigator.pop(context);
              },
              label: 'OK',
              mainType: true,
            )
          ],
        ),
      ),
    );
  }
}
