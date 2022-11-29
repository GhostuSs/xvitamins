import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:xvitamins/data/GDays/gdays.dart';
import 'package:xvitamins/data/food/food_model.dart';
import 'package:xvitamins/data/goalday/goalday.dart';
import 'package:xvitamins/gen/assets.gen.dart';
import 'package:xvitamins/ui/current_day/ui/current_day.dart';
import 'package:xvitamins/ui/main/ui/main_screen.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

import '../../../uikit/dialog.dart';

class AddScreen extends StatefulWidget {
  final DateTime day;
  final VoidCallback updateParent;
  final bool? fromHome;
  const AddScreen({Key? key, required this.day, required this.updateParent, this.fromHome,}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController grammcontroller = TextEditingController(text: '100');

  @override
  void initState() {
    grammcontroller.addListener(() {
      if(grammcontroller.text.isNotEmpty==true){
      if(int.parse(grammcontroller.text.trim())==0) {
        setState(()=>canAdd=false);
      }else{
        setState(() {
          if(namecontroller.text.isNotEmpty==true)canAdd=true;
        });
      }
    }else{
        grammcontroller.text='0';
      }
    });
    super.initState();
  }
  bool canAdd = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Container(
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
            onPressed: () => {
              widget.fromHome==true ? pushNewScreen(context, screen: const MainScreen(),withNavBar: false) : Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> CurrentDayScreen(selected: widget.day,)))
            },
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 12),
                child: TextField(
                  controller: namecontroller,
                  textAlignVertical: TextAlignVertical.bottom,
                  textAlign: TextAlign.center,
                  maxLength: 20,
                  onChanged: (s){
                    setState(
                          () => canAdd = namecontroller.text.isNotEmpty == true&&int.parse(grammcontroller.text)>0,
                    );
                  },
                  style: AppTypography.regular.copyWith(
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.gray3,
                      hintText: 'What did you eat?',
                      counter: const SizedBox(height: 0,),
                      alignLabelWithHint: true,
                      constraints: BoxConstraints.expand(
                        height: 55.h,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GrammButton(
                    onTap: () {
                      setState(
                          (){int.parse(grammcontroller.text) > 10
                          ? grammcontroller.text =
                          (int.parse(grammcontroller.text) - 10).toString()
                          : null;
                          canAdd = namecontroller.text.isNotEmpty == true&&int.parse(grammcontroller.text)>0;
                          },
                    );
                      grammcontroller.selection = TextSelection.fromPosition(TextPosition(offset: grammcontroller.text.length));
                    },
                  ),
                  TextField(
                    controller: grammcontroller,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    cursorColor: AppColors.blue,
                    keyboardType: TextInputType.number,
                    // readOnly: true,
                    maxLines: 1,
                    maxLength: 5,
                    style: AppTypography.regular.copyWith(
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                    ),
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
                        counter: const SizedBox(height: 0,),
                        constraints:
                        BoxConstraints.expand(height: 55.w, width: 215.w),
                        hintStyle: AppTypography.regular.copyWith(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.emptyGoals,
                        )),
                  ),
                  GrammButton(
                    additional: true,
                    onTap: (){
                      grammcontroller.text.length<=99990 ? setState(
                          (){
                            int.parse(grammcontroller.text) >= 0
                          ? grammcontroller.text =
                          (int.parse(grammcontroller.text) + 10).toString()
                          : null;
                            canAdd = namecontroller.text.isNotEmpty == true&&int.parse(grammcontroller.text)>0;
                          },
                    ): null;
                    grammcontroller.selection = TextSelection.fromPosition(TextPosition(offset: grammcontroller.text.length));
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              MainButton(
                onTap: () async => (int.parse(grammcontroller.text)>0&&grammcontroller.text.length<6&&canAdd==true) ? await add().then((value) => setState(() {})) : null,
                label: 'Add',
                mainType: true,
                customColor: canAdd&&int.parse(grammcontroller.text)>0
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
                              Wrap(
                                children: [
                                  SizedBox(
                                    width: 250.w,
                                    child: Text(
                                      data.name +
                                          ' (' +
                                          data.gramms.toString() +
                                          "g)",
                                      style: AppTypography.medium.copyWith(
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap:()=>showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    clipBehavior: Clip.hardEdge,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.r),
                                    ),
                                    child: CustomDialog(
                                      label:
                                      'Do you really want to delete this item?',
                                      emojy: 'assets/images/reallywant.png',
                                      actions: const ['Yes', 'No'],
                                      onYes: () async => await delete(data).then((value) => Navigator.pop(_)),
                                    ),
                                  ),
                                ),
                                child: Assets.images.trash.svg(
                                  width: 24.w,
                                  height: 24.w,
                                ),),
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

  Future<void> delete(Food data) async {
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
  }

  Future<void> add() async {
    if (Hive.box<GDays>('goals')
            .values
            .first
            .days
            ?.where((element) => element.day == widget.day).isNotEmpty ==
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
      final Food newFood = Food(
        name: namecontroller.text,
        gramms: int.parse(grammcontroller.text),
      );
      gday.food?.add(newFood);
      gday.food?.sort((a,b)=>b.gramms!.compareTo(a.gramms!));

      Hive.box<GDays>('goals').values.first.days?.add(gday);
      int sum=0;
      gday.food?.every((element){
        sum+=element.gramms??0;
        return true;
      });
      if(sum>=Hive.box<int>('dailygoal').values.first)gday.completed=true;
      final gdays = Hive.box<GDays>('goals').values.first;
      await Hive.box<GDays>('goals').clear();
      await Hive.box<GDays>('goals').put('goals', gdays);
    } else {
      final gday=GoalDay(
        day: widget.day,
        food: [
          Food(
            name: namecontroller.text,
            gramms: int.parse(grammcontroller.text),
          )
        ],
        completed: (int.parse(grammcontroller.text)>=Hive.box<int>('dailygoal').values.first) ? true : null,
      );
      Hive.box<GDays>('goals').values.first.days?.add(gday);
      final newData = Hive.box<GDays>('goals').values.first;
      await Hive.box<GDays>('goals').clear();
      await Hive.box<GDays>('goals').put('goals', newData);
    }
    namecontroller.clear();
    grammcontroller.text = '100';
    canAdd=false;
    widget.updateParent();
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
