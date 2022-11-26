import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/data/food/food_model.dart';
import 'package:xvitamins/data/goalday/goalday.dart';
import 'package:xvitamins/gen/assets.gen.dart';
import 'package:xvitamins/ui/current_day/ui/current_day.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class AddScreen extends StatefulWidget {
  final DateTime day;
  const AddScreen({Key? key, required this.day}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController grammcontroller = TextEditingController(text: '100');
  bool canAdd = false;
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
            'Fruit and Veg',
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
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => CurrentDayScreen(selected: widget.day))),
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 16),
                child: TextField(
                  controller: namecontroller,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  onChanged: (s) => setState(
                      () => canAdd = namecontroller.text.isNotEmpty == true),
                  style: AppTypography.regular.copyWith(
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.gray3,
                      hintText: 'What did you eat?',
                      alignLabelWithHint: true,
                      constraints: BoxConstraints.expand(
                        height: 48.h,
                      ),
                      hintStyle: AppTypography.regular.copyWith(
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.emptyGoals,
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GrammButton(
                    onTap: () => setState(
                      () => int.parse(grammcontroller.text) > 10
                          ? grammcontroller.text =
                              (int.parse(grammcontroller.text) - 10).toString()
                          : null,
                    ),
                  ),
                  TextField(
                    controller: grammcontroller,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    style: AppTypography.regular.copyWith(
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide.none,
                        ),
                        suffix: Text(
                          'g',
                          style: AppTypography.medium.copyWith(
                              fontSize: 14.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                        filled: true,
                        fillColor: AppColors.gray3,
                        alignLabelWithHint: true,
                        constraints:
                            BoxConstraints.expand(height: 48.w, width: 215.w),
                        hintStyle: AppTypography.regular.copyWith(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.emptyGoals,
                        )),
                  ),
                  GrammButton(
                    additional: true,
                    onTap: () => setState(
                      () => int.parse(grammcontroller.text) > 0
                          ? grammcontroller.text =
                              (int.parse(grammcontroller.text) + 10).toString()
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              MainButton(
                onTap: () async => await add().then((value) => setState(() {})),
                label: 'Add',
                mainType: true,
                customColor: canAdd
                    ? AppColors.blue
                    : const Color.fromRGBO(172, 172, 176, 1),
              ),
              const SizedBox(height: 32),
              if (Hive.box<GDays>('goals')
                      .values
                      .first
                      .days
                      ?.where((element) => element.day == widget.day)
                      .isNotEmpty ==
                  true)
                Expanded(
                  child: ListView(
                    children: [
                      for (final data in (Hive.box<GDays>('goals')
                              .values
                              .first
                              .days
                              ?.where((element) => element.day == widget.day)
                              .first
                              .food ??
                          []))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: Row(
                            children: [
                              Container(
                                width: 24.w,
                                height: 24.w,
                                decoration: BoxDecoration(
                                    color: colorSelector(
                                        index: (Hive.box<GDays>('goals')
                                                    .values
                                                    .first
                                                    .days
                                                    ?.where((element) =>
                                                        element.day ==
                                                        widget.day)
                                                    .first
                                                    .food ??
                                                [])
                                            .indexOf(data)),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                data.name +
                                    ' (' +
                                    data.gramms.toString() +
                                    "g)",
                                style: AppTypography.medium.copyWith(
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () async {
                                  Hive.box<GDays>('goals')
                                      .values
                                      .first
                                      .days
                                      ?.where((element) =>
                                          element.day == widget.day)
                                      .first
                                      .food
                                      ?.remove(data);
                                  final newData =
                                      Hive.box<GDays>('goals').values.first;
                                  await Hive.box<GDays>('goals').clear();
                                  await Hive.box<GDays>('goals')
                                      .put('goals', newData);
                                  setState(() {});
                                },
                                child: Assets.images.trash.svg(
                                  width: 24.w,
                                  height: 24.w,
                                ),
                              )
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
    );
  }

  Future<void> add() async {
    if (Hive.box<GDays>('goals')
            .values
            .first
            .days
            ?.any((element) => element.day == widget.day) ==
        true) {
      GoalDay gday = (Hive.box<GDays>('goals')
          .values
          .first
          .days!
          .firstWhere((element) => element.day == widget.day));
      Hive.box<GDays>('goals')
          .values
          .first
          .days
          ?.removeWhere((element) => element.day == widget.day);
      gday.food?.add(Food(
        name: namecontroller.text,
        gramms: int.parse(grammcontroller.text),
      ));
      Hive.box<GDays>('goals').values.first.days?.add(gday);
    } else {
      Hive.box<GDays>('goals').values.first.days?.add(GoalDay(
            day: widget.day,
            food: [
              Food(
                name: namecontroller.text,
                gramms: int.parse(grammcontroller.text),
              )
            ],
          ));
      final newData = Hive.box<GDays>('goals').values.first;
      await Hive.box<GDays>('goals').clear();
      await Hive.box<GDays>('goals').put('goals', newData);
    }
    namecontroller.clear();
    grammcontroller.text = '100';
  }
}

class GrammButton extends StatelessWidget {
  final bool? additional;
  final VoidCallback? onTap;
  const GrammButton({
    Key? key,
    this.additional,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.blue, width: 3.w),
        ),
        child: Center(
          child: Icon(
            additional == true ? Icons.add : Icons.remove,
            color: AppColors.blue,
            size: 30.w,
          ),
        ),
      ),
    );
  }
}
