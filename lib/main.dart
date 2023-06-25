import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/constants/main_config_app.dart';
import 'package:custom_picker/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  // setupInjections();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MainConfigApp.screenSize,
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MainConfigApp.appName,
        theme: ThemeData(
          primaryColor: ColorStyles.primary,
          primarySwatch: ColorStyles.primarySwath,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: ColorStyles.white
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorStyles.white,
            centerTitle: true,
            elevation: 2.0,
            toolbarHeight: 56,
            iconTheme: IconThemeData(
              color: ColorStyles.black,
            ),
          )
        ),
        home: const MainView(),
      ),
    );
  }
}
