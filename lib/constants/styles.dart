import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng9_country_info/config.dart';

Color searchTextColor = currentTheme.currentTheme() != ThemeMode.dark
    ? const Color(0xff667085)
    : const Color(0xffeaecf0);
Color countryTextColor = currentTheme.currentTheme() != ThemeMode.dark
    ? const Color(0xff1c1917)
    : const Color(0xfff2f4f7);
Color stateTextColor = currentTheme.currentTheme() != ThemeMode.dark
    ? const Color(0xff667085)
    : const Color(0xff98a2b3);
Color searchBarColor = currentTheme.currentTheme() != ThemeMode.dark
    ? const Color(0xfff2f4f7)
    : const Color(0xff98a2b3);

TextStyle searchTextStyle = TextStyle(
  fontSize: 16.sp, fontWeight: FontWeight.w300,color: searchTextColor
);

TextStyle optionsTextStyle = TextStyle(
    fontSize: 12.sp, fontWeight: FontWeight.w500
);
TextStyle countryTextStyle = TextStyle(
    fontSize: 14.sp, fontWeight: FontWeight.w400,color: countryTextColor
);
TextStyle stateTextStyle = TextStyle(
    fontSize: 14.sp, fontWeight: FontWeight.w400,color: stateTextColor
);
TextStyle valueTextStyle = TextStyle(
    fontSize: 16.sp, fontWeight: FontWeight.w300,color: countryTextColor
);
TextStyle namingTextStyle = TextStyle(
    fontSize: 16.sp, fontWeight: FontWeight.w500,color: countryTextColor
);