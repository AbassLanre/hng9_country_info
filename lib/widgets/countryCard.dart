import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryCard extends StatefulWidget {
  final String? image;
  final String? countryName;
  final String? capital;

  const CountryCard(
      {Key? key,
      @required this.image,
      @required this.countryName,
      @required this.capital})
      : super(key: key);

  @override
  State<CountryCard> createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.image != null
          ? Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(image: NetworkImage(widget.image!))),
            )
          : SizedBox(
              height: 40.h,
              width: 40.w,
            ),
      title: Text(widget.countryName == null ? '' : widget.countryName!),
      subtitle: Text(widget.capital == null ? '' : widget.capital!),
    );
  }
}
