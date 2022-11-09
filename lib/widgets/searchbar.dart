

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng9_country_info/constants/styles.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController? searchCountryController;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: searchBarColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 8.w,),
          Icon(Icons.search,size: 16.r,),
          const Expanded(child:  SizedBox(width: 16,)),
          Expanded(
            child: TextField(
              controller: searchCountryController,
              decoration: InputDecoration(
                hintText: 'Search country',
                hintStyle: searchTextStyle,
                border: InputBorder.none
              ),

            ),
          ),
          const Expanded(child:  SizedBox(width: 16,))
        ],
      ),
    );
  }
}
