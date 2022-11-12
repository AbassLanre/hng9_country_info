import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng9_country_info/config.dart';
import 'package:hng9_country_info/constants/consts.dart';
import 'package:hng9_country_info/constants/lang.dart';
import 'package:hng9_country_info/constants/styles.dart';
import 'package:hng9_country_info/main.dart';
import 'package:hng9_country_info/model/country_model.dart';
import 'package:hng9_country_info/network/network_enum.dart';
import 'package:hng9_country_info/network/network_helper.dart';
import 'package:hng9_country_info/network/network_service.dart';
import 'package:hng9_country_info/network/query_param.dart';
import 'package:hng9_country_info/provider/countryProvider.dart';
import 'package:hng9_country_info/repository/countryRepository.dart';
import 'package:hng9_country_info/widgets/countryCard.dart';
import 'package:hng9_country_info/widgets/searchbar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool darkMode = true;

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController? searchCountryController = TextEditingController();
  final _debouncer = Debouncer();
  List<Country> temp = [];
  List<Country> country = [];
  int langVal = 0;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((t) {
      Provider.of<CountryProvider>(context,listen: false).setCountryData(CountryRespository().getData());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List alpha = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    List added = [];
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.h),
          child: Consumer<CountryProvider>(
            builder: (_, provider, body) {

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
                    // const SearchBar(),
                    /// searchbar
                    Container(
                      height: 48.h,
                      width: 380.w,
                      decoration: BoxDecoration(
                        color: searchBarColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 16.w),
                          Icon(
                            Icons.search,
                            size: 16.r,
                            color: searchTextColor,
                          ),
                          Expanded(child: SizedBox(width: 16.w)),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: searchCountryController,
                                decoration: InputDecoration(
                                    hintText: strings.get(0),
                                    hintStyle: searchTextStyle,
                                    border: InputBorder.none),
                                onChanged: (string) {
                                  _debouncer.run(() {
                                    setState(() {
                                      country = temp
                                          .where(
                                            (u) => (u.name!.common!
                                                .toLowerCase()
                                                .contains(
                                                  string.toLowerCase(),
                                                )),
                                          )
                                          .toList();
                                    });
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox(width: 16.w))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Language
                        InkWell(
                          onTap: () => showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Text(strings.get(17)),
                                    ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: Lang().langData.length,
                                        shrinkWrap: true,
                                        itemBuilder: (_, index) {
                                          return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24.w,
                                                  right: 24.w),
                                              child: ListTile(
                                                title: Text(Lang()
                                                    .langData[index]
                                                    .name!),
                                                trailing: Radio<int>(
                                                  activeColor: Theme.of(context)
                                                      .primaryColor,
                                                  value: Lang()
                                                      .langData[index]
                                                      .id!,
                                                  groupValue: langVal,
                                                  onChanged:
                                                      (int? value) async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    setState(() {
                                                      langVal = value!;
                                                      prefs.setInt(
                                                          'langu', index + 1);
                                                      strings
                                                          .setLang(index + 1);
                                                    });
                                                  },
                                                ),
                                              ));
                                        }),
                                  ],
                                ),
                              );
                            },
                          ),
                          child: Container(
                            height: 40.h,
                            width: 73.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                border:
                                    Border.all(color: const Color(0xffA9B8D4))),
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
                        ),

                        /// filter
                        InkWell(
                          onTap: () => showModalBottomSheet(
                            backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Text(strings.get(1)),
                                    ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: Lang().langData.length,
                                        shrinkWrap: true,
                                        itemBuilder: (_, index) {
                                          return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24.w,
                                                  right: 24.w),
                                              child: ListTile(
                                                title: Text(Lang()
                                                    .langData[index]
                                                    .name!),
                                                trailing: Radio<int>(
                                                  activeColor: Theme.of(context)
                                                      .primaryColor,
                                                  value: Lang()
                                                      .langData[index]
                                                      .id!,
                                                  groupValue: langVal,
                                                  onChanged:
                                                      (int? value) async {
                                                    SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                    setState(() {
                                                      langVal = value!;
                                                      prefs.setInt(
                                                          'langu', index + 1);
                                                      strings
                                                          .setLang(index + 1);
                                                    });
                                                  },
                                                ),
                                              ));
                                        }),
                                  ],
                                ),
                              );
                            },
                          ),

                          child: Container(
                            height: 40.h,
                            width: 86.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                border:
                                    Border.all(color: const Color(0xffA9B8D4))),
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
                                  strings.get(1),
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),

                    /// country list
                    FutureBuilder(
                      future: provider.getCountryData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          temp = snapshot.data as List<Country>;
                          if (country.isEmpty) {
                            country = temp;
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              String first = '';
                              for (int i = 0; i < alpha.length; i++) {
                                if (alpha[i] ==
                                        country[index].name!.common![0] &&
                                    !added.contains(alpha[i])) {
                                  first = alpha[i];
                                  added.add(alpha[i]);
                                }
                                if (added.isEmpty) {
                                  first = alpha[i];
                                  added.add(alpha[i]);
                                }
                              }

                              return CountryCard(
                                image: country[index].flags!.png,
                                capital:
                                    country[index].capital?.first ?? '-----',
                                countryName: country[index].name!.common,
                                abbr: first,
                                index: index,
                                country: country[index],
                              );
                            },
                            itemCount: country.length,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
