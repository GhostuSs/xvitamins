import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/data/food/food_model.dart';
import 'package:xvitamins/data/goalday/goalday.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  int sum = 0;
  int completed = 0;
  int daysInMonth =
      DateUtils.getDaysInMonth(DateTime.now().year, DateTime.now().month);
  @override
  void initState() {
    for (final GoalDay days
        in Hive.box<GDays>('goals').values.first.days ?? []) {
      for (final Food data in days.food ?? []) {
        sum = sum + (data.gramms)!;
      }
      if (days.completed == true && days.day?.month == DateTime.now().month)
        completed++;
    }
    super.initState();
  }

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
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Text(
            'Monthly statistics',
            style: AppTypography.semibold.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20.w,
              color: AppColors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints.expand(height: 186.h),
                  child: DChartBar(
                    data: [
                      {
                        'id': 'Bar',
                        'data': [
                          {'domain': '1', 'measure': countSum(1)},
                          {'domain': '2', 'measure': countSum(2)},
                          {'domain': '3', 'measure': countSum(3)},
                          {'domain': '4', 'measure': countSum(4)},
                          {'domain': '5', 'measure': countSum(5)},
                          {'domain': '6', 'measure': countSum(6)},
                          {'domain': '7', 'measure': countSum(7)},
                          {'domain': '8', 'measure': countSum(8)},
                          {'domain': '9', 'measure': countSum(9)},
                          {'domain': '10', 'measure': countSum(10)},
                          {'domain': '11', 'measure': countSum(11)},
                          {'domain': '12', 'measure': countSum(12)},

                        ],
                      },
                    ],
                    domainLabelPaddingToAxisLine: 16,
                    axisLineTick: 1,
                    axisLinePointTick: 1,
                    axisLinePointWidth: 6,
                    axisLineColor: AppColors.black,
                    measureLabelPaddingToAxisLine: 10,
                    barColor: (barData, index, id) => AppColors.blue,
                    showBarValue: true,
                  ),
                ),
                SizedBox(height: 32.h,),
                StatWidget(
                    label: 'Total', subtitle: '${sum}g vegetables and fruit'),
                StatWidget(
                    label: 'Not completed',
                    subtitle: '${daysInMonth - completed} days'),
                StatWidget(label: 'Completed', subtitle: '$completed days'),
              ],
            ),
          ),
        ),
      ),
    );
  }
  int countSum(int month){
    int sum =0;
    if(Hive.box<GDays>('goals').values.first.days?.where((element) => element.day?.month==month).isNotEmpty==true){
      for(final GoalDay data in (Hive.box<GDays>('goals').values.first.days!.where((element) => element.day!.month==month).toList()??[])){
        for(final Food food in data.food??[]){
          sum=sum+food.gramms!;
        }
      }
    }
    return sum;
  }
}

class StatWidget extends StatelessWidget {
  final String label;
  final String subtitle;
  const StatWidget({Key? key, required this.label, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 16.h,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTypography.semibold.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 22.w,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            subtitle,
            style: AppTypography.medium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.w,
            ),
          ),
        ],
      ),
    );
  }
}
