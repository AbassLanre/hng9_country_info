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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Explore',style: TextStyle(fontSize: 24),),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            darkMode = !darkMode;
                            currentTheme.switchTheme();
                          });
                        },
                        child: !darkMode?const Icon(Icons.light_mode_outlined):
                        const Icon(Icons.dark_mode_outlined))

                  ],
                ),
                SizedBox(height: 16.h,),
                const SearchBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
