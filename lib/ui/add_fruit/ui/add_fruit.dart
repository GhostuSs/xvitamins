import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xvitamins/uikit/main_button.dart';
import 'package:xvitamins/utils/colors/colors.dart';
import 'package:xvitamins/utils/typography/app_typography.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController grammcontroller = TextEditingController(text: '100');
  bool canAdd = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () => Navigator.pop(context),
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
              onTap: () async =>await add(),
              label: 'Add',
              mainType: true,
              customColor:
                  canAdd ? AppColors.blue : const Color.fromRGBO(172, 172, 176, 1),
            )
          ],
        ),
      ),
    );
  }
  Future<void> add()async {
    //TODO:implement
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
