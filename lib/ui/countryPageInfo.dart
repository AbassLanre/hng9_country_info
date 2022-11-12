

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng9_country_info/main.dart';
import 'package:hng9_country_info/model/country_model.dart';
import 'package:hng9_country_info/provider/countryProvider.dart';
import 'package:hng9_country_info/widgets/rowDetails.dart';
import 'package:provider/provider.dart';

class CountryInfoPage extends StatefulWidget {
  final int? index;
  final Country? country;
  const CountryInfoPage({Key? key, @required this.index,@required this.country}) : super(key: key);

  @override
  State<CountryInfoPage> createState() => _CountryInfoPageState();
}

class _CountryInfoPageState extends State<CountryInfoPage> {
  List<String?> items = [];


  @override
  void initState() {
    // TODO: implement initState
    if(widget.country!.flag != null){
      items.add(widget.country!.flags!.png!);
      print(widget.country!.flag!);
    }
    if(widget.country!.coatOfArms!.png != null){
      items.add(widget.country!.coatOfArms!.png!);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 18.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_outlined, size: 35.r,)),
                        Center(child: Text(widget.country!.name!.common! ,style: TextStyle(fontSize: 24.sp),)),
                        SizedBox(width: 30.w,)
                      ],
                    ),
                    SizedBox(height: 16.h,),

                    CarouselSlider(
                        items: items.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    image: DecorationImage(
                                      image: NetworkImage(i!),
                                      fit: BoxFit.contain
                                    )
                                  ),

                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 250.h,
                          aspectRatio: 16/9,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )
                    ),
                    SizedBox(height: 24.h,),
                    RowDetails(name: strings.get(2), value: widget.country!.population!.toString()),
                    RowDetails(name: strings.get(3), value: widget.country?.region ?? '-----'),
                    RowDetails(name: strings.get(4), value: widget.country!.capital?.first ?? '-----'),
                    RowDetails(name: strings.get(5), value: '-----'),
                    SizedBox(height: 24.h,),
                    RowDetails(name: strings.get(6), value: widget.country!.languages?.eng ??'-----'),
                    RowDetails(name: strings.get(7), value: widget.country!.demonyms?.eng!.f ?? '-----'),
                    RowDetails(name: strings.get(8), value: '-----'),
                    RowDetails(name: strings.get(9), value: '-----'),
                    SizedBox(height: 24.h,),
                    RowDetails(name: strings.get(10), value: widget.country!.independent?.toString() ?? '-----'),
                    RowDetails(name: strings.get(11), value: widget.country?.area.toString() ?? '-----'),
                    RowDetails(name: strings.get(12), value: widget.country!.currencies?.bBD?.name ?? 'Euro'),
                    RowDetails(name: 'GDP', value: "-----"),
                    SizedBox(height: 24.h,),
                    RowDetails(name: strings.get(13), value: widget.country!.timezones?.first ?? 'UTC+01:00'),
                    RowDetails(name: strings.get(14), value: widget.country!.postalCode?.format ?? 'dd/mm/yyyy'),
                    RowDetails(name: strings.get(15), value: '${widget.country!.idd?.root ?? ''}${widget.country!.idd?.suffixes?.first ?? ''}' ),
                    RowDetails(name: strings.get(16), value: widget.country!.car?.side ?? 'right'),

                  ],
                ),
              )),
        ),

      );
  }
}
