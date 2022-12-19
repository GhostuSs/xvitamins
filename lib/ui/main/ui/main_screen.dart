import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:xvitamins/gen/assets.gen.dart';
import 'package:xvitamins/ui/calendar/ui/calendar_screen.dart';
import 'package:xvitamins/ui/main/bloc/main_cubit.dart';
import 'package:xvitamins/ui/main/uikit/custom_navbar_widget.dart';
import 'package:xvitamins/ui/onboarding/ui/onboarding.dart';
import 'package:xvitamins/ui/settings/ui/settings_screen.dart';
import 'package:xvitamins/ui/weekly_facts/ui/weekly_facts.dart';
import 'package:xvitamins/utils/colors/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context){
    return WillPopScope(child: BlocBuilder<MainCubit,MainState>(
      bloc: context.read<MainCubit>(),
      builder: (ctx,state)=>Scaffold(
        body: PersistentTabView.custom(
          context,
          controller: controller,
          screens: _buildScreens(context),
          backgroundColor: AppColors.white,
          items: _buildItems(),
          itemCount: 3,
          resizeToAvoidBottomInset: false,
          // navBarHeight: 45.h,
          customWidget: (navbarEss) => CustomNavBarWidget(
            items: _buildItems(),
            onItemSelected: (int value) => controller.index==value ? null : setState(() {
              controller.index = value;
            }),
            selectedIndex: controller.index,
          ),
        ),
      ),
    ), onWillPop: ()async=>false);
  }

  List<PersistentBottomNavBarItem> _buildItems() {
    TextStyle _style(bool isSelected) => const TextStyle(color: AppColors.black);

    Color colorSelector(int index) {
      return controller.index == index ? AppColors.blue : AppColors.gray2;
    }

    return [
      PersistentBottomNavBarItem(
        icon: Assets.images.calendar.svg(
          width: 23.w,
          color: colorSelector(0),
        ),
        inactiveIcon: Assets.images.calendar.svg(
          width: 23.w,
          color: colorSelector(0),
        ),
        title: 'Calendar',
        contentPadding: 0.0,
        textStyle: _style(controller.index == 0),
      ),
      PersistentBottomNavBarItem(
        icon: Assets.images.weeklyfacts.svg(
          width: 23.w,
          color: colorSelector(1),
        ),
        inactiveIcon: Assets.images.weeklyfacts.svg(
          width: 23.w,
          color: colorSelector(1),
        ),
        contentPadding: 0.0,
        title: 'Weekly facts',
        textStyle: _style(controller.index == 1),
      ),
      PersistentBottomNavBarItem(
        icon: Assets.images.settings.svg(width: 23.w, color: colorSelector(2)),
        inactiveIcon:
            Assets.images.settings.svg(width: 23.w, color: colorSelector(2)),
        title: 'Settings',
        contentPadding: 0.0,
        textStyle: _style(controller.index == 2),
      ),
    ];
  }

  List<Widget> _buildScreens(BuildContext context) => [
        CalendarScreen(ctx: context,),
        const WeeklyScreen(),
        SettingsScreen(navigateToOnb: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>const Onboarding())),),
      ];
}
