import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.getInstance()..init(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        child: Shimmer.fromColors(
          highlightColor: Colors.black,
          baseColor: Colors.grey[300],
          period: Duration(seconds: 1),
          child: Container(
            height: 280,
            width: double.infinity,
          )
        ),
      ),
    );
  }
}