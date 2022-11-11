import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng9_country_info/config.dart';
import 'package:hng9_country_info/constants/consts.dart';
import 'package:hng9_country_info/model/country_model.dart';
import 'package:hng9_country_info/network/network_enum.dart';
import 'package:hng9_country_info/network/network_helper.dart';
import 'package:hng9_country_info/network/network_service.dart';
import 'package:hng9_country_info/network/query_param.dart';
import 'package:hng9_country_info/provider/countryProvider.dart';
import 'package:hng9_country_info/repository/countryRepository.dart';
import 'package:hng9_country_info/widgets/countryCard.dart';
import 'package:hng9_country_info/widgets/searchbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool darkMode = true;

class _HomePageState extends State<HomePage> {
  final Country? country = Country();


  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    List alpha =['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  List added =[];
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.h),
          child: Consumer<CountryProvider>(
            builder: (_,provider,body){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Explore',
                          style: TextStyle(fontSize: 24.sp),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                darkMode = !darkMode;
                                currentTheme.switchTheme();
                              });
                            },
                            child: !darkMode
                                ? const Icon(Icons.light_mode_outlined)
                                : const Icon(Icons.dark_mode_outlined))
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    const SearchBar(),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Language
                        Container(
                          height: 40.h,
                          width: 73.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: const Color(0xffA9B8D4))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Icon(
                                Icons.language_rounded,
                                size: 18.r,
                              ),
                              Text(
                                'EN',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                            ],
                          ),
                        ),

                        /// filter
                        Container(
                          height: 40.h,
                          width: 86.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: const Color(0xffA9B8D4))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Icon(
                                Icons.filter_alt_outlined,
                                size: 19.r,
                              ),
                              Text(
                                'Filter',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    FutureBuilder(
                      future: provider.getCountryData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          // final json = snapshot.data;

                          final List<Country> country =
                          snapshot.data as List<Country>;

                          // print('here ' + country[245].name!.common.toString());
                          return ListView.builder(

                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              String first='';
                              for(int i=0; i<alpha.length; i++){
                                if (alpha[i] == country[index].name!.common![0] && !added.contains(alpha[i])){
                                  first =alpha[i];
                                  added.add(alpha[i]);
                                }
                                if(added.isEmpty){
                                  first =alpha[i];
                                  added.add(alpha[i]);
                                }


                              }
                              return CountryCard(
                                image: country[index].flags!.png,
                                capital: country[index].capital?.first ?? '-----',
                                countryName: country[index].name!.common,
                                abbr: first, index: index, country: country[index],
                              );
                            },
                            itemCount: country.length,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 25.r,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const Text('Something Went Wrong')
                              ],
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }



}
