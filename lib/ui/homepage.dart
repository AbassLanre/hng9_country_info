import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng9_country_info/config.dart';
import 'package:hng9_country_info/widgets/searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
bool darkMode = true;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 5.0.w),
          child: const Text('Explore',style: TextStyle(fontSize: 24),),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right:24.0.w),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentTheme.switchTheme();
                    darkMode = !darkMode;
                  });
                },
                child: !darkMode?const Icon(Icons.light_mode_outlined):
            const Icon(Icons.dark_mode_outlined)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBar(),
            ],
          ),
        ),
      ),
    );
  }
}
