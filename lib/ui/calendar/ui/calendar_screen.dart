import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/utils/colors/colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.gray2,width: 0.5.w,)
          )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(children: [
                
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
