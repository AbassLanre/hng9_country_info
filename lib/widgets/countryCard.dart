import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng9_country_info/model/country_model.dart';
import 'package:hng9_country_info/ui/countryPageInfo.dart';

class CountryCard extends StatefulWidget {
  final String? abbr;
  final String? image;
  final String? countryName;
  final String? capital;
  final int? index;
  final Country? country;

  const CountryCard(
      {Key? key,
      @required this.image,
      @required this.countryName,
      @required this.capital,
       @required this.abbr,
        @required this.index, @required this.country})
      : super(key: key);

  @override
  State<CountryCard> createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {


  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.abbr!.isEmpty? const SizedBox.shrink():Text(widget.abbr!),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>CountryInfoPage(index: widget.index, country: widget.country,)));
          },
          child: ListTile(

            leading: widget.image != null
                ? Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                            image: NetworkImage(widget.image!),
                          fit: BoxFit.cover
                        )),
                  )
                : SizedBox(
                    height: 40.h,
                    width: 40.w,
                  ),
            title: Text(widget.countryName == null ? '' : widget.countryName!),
            subtitle: Text(widget.capital == null ? '' : widget.capital!),
          ),
        ),
      ],
    );
  }
}
