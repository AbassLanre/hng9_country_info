import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowDetails extends StatefulWidget {
  final String? name;
  final String? value;

  const RowDetails({Key? key, @required this.name, @required this.value})
      : super(key: key);

  @override
  State<RowDetails> createState() => _RowDetailsState();
}

class _RowDetailsState extends State<RowDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${widget.name!}:',
          style: TextStyle(fontSize: 20.sp),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Text(widget.value!,
              style:
                  TextStyle(color: Theme.of(context).hintColor, fontSize: 20.sp)),
        )
      ],
    );
  }
}
