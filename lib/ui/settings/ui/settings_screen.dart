import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:xvitamins/ui/settings/uikit/settings_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback navigateToOnb;
  const SettingsScreen({Key? key, required this.navigateToOnb}) : super(key: key);

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
              if(Hive.box<bool>('premium').values.first==false)SettingsButton(
                label: 'Buy Premium😎',
                isPrem: true,
                onTap: ()=>navigateToOnb(),
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
