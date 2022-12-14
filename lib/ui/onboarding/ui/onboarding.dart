import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:xvitamins/data/urls.dart';
import 'package:xvitamins/ui/main/ui/main_screen.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Container(
      constraints: const BoxConstraints.expand(),
      child: Scaffold(
        backgroundColor: AppColors.onbBg,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Image.asset('assets/images/onb.png'),
              Padding(
                padding: EdgeInsets.only(
                  top: 45.h,
                  left: 16.w,
                  right: 16.w,
                  bottom: 20.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: AppColors.white,
                            size: 20.w,
                          ),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'GET PREMIUM AND IMPROVE YOUR LIFE',
                      textAlign: TextAlign.center,
                      style: AppTypography.bold.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 32.w,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustLabel(
                      label: 'without ads',
                      width: 200.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                      ),
                      child: CustLabel(
                        label: 'monthly statistics',
                        width: 336.w,
                      ),
                    ),
                    CustLabel(
                      label: 'goal setting',
                      width: 200.w,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      "GET PREMIUM FOR 0.99\$",
                      style: AppTypography.regular.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.w,
                        color: AppColors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15.h,
                        bottom: 26.h,
                      ),
                      child: MainButton(
                        onTap: () async => await Hive.box<bool>('premium')
                            .put('premium', true)
                            .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MainScreen()))),
                        label: 'Get Premium ????',
                        customColor: AppColors.blue,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: ()=>launchUrl(Uri.parse(BaseUrls.terms)),
                            child: Text(
                              'TERMS OF USE',
                              style: AppTypography.regular.copyWith(
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white),
                            ),
                          ),
                          InkWell(
                            onTap: () async =>await Hive.box<bool>('premium').put('premium', true).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const MainScreen()))),
                            child: Text(
                              'RESTORE',
                              style: AppTypography.regular.copyWith(
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white),
                            ),
                          ),
                          InkWell(
                            onTap: ()=>launchUrl(Uri.parse(BaseUrls.privacy)),
                            child: Text(
                              'PRIVACY POLICY',
                              style: AppTypography.regular.copyWith(
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ), onWillPop: ()async=>false);
  }
}

class CustLabel extends StatelessWidget {
  final String label;
  final double? width;
  const CustLabel({Key? key, required this.label, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: 60.h,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(99.r),
            boxShadow: [
              BoxShadow(
                  color: AppColors.blue,
                  blurStyle: BlurStyle.outer,
                  offset: Offset(
                    7.w,
                    7.h,
                  ),
                  spreadRadius: 0,
                  blurRadius: 1.w)
            ],
            border: Border.all(
              color: AppColors.blue,
              width: 1.w,
            ),
          ),
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: AppTypography.semibold.copyWith(
                fontSize: 20.w,
                fontWeight: FontWeight.w600,
                color: AppColors.onbBg,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
