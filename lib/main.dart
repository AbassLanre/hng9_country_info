import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng9_country_info/config.dart';
import 'package:hng9_country_info/provider/countryProvider.dart';
import 'package:hng9_country_info/repository/countryRepository.dart';
import 'package:hng9_country_info/ui/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<CountryProvider>(create: (_)=>CountryProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CountryProvider>(context).setCountryData(CountryRespository().getData());

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'Axiforma'),
          darkTheme: ThemeData(
            scaffoldBackgroundColor:const Color(0xff000F24) ,

              brightness: Brightness.dark,
              fontFamily: 'Axiforma'),
          debugShowCheckedModeBanner: false,
          themeMode: currentTheme.currentTheme(),
          home: child,
        );
      },
      child: const HomePage(),
    );

  }
}
