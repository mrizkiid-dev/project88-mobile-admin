import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p88_admin/app/persentation/resource/app_assets.dart';
import 'package:p88_admin/app/persentation/widget/button.dart';
import 'package:p88_admin/app/util/widget_helper.dart';

class ErrorTryAgain extends StatelessWidget {
  const ErrorTryAgain({
    super.key,
    required VoidCallback onPressed
  }): _onPressed=onPressed;

  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppAssets.ERROR_WARNING, width: 160.w, height: 160.w,), 
          Text('oops something went wrong' , style: TextStyle(fontSize: 20.sp),),
          Gap.column(20.h),
          Button(
            onPressed: _onPressed, 
            title: 'try again',
            width: 100,
            height: 40,
          )
        ],
      ),
    );
  }
}