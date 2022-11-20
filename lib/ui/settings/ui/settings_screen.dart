import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/ui/settings/uikit/settings_button.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback navigateToOnb;
  const SettingsScreen({Key? key, required this.navigateToOnb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SettingsButton(
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
    );
  }
}
