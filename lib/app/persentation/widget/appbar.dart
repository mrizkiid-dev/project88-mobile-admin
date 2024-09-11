import 'package:flutter/material.dart';
import 'package:p88_admin/app/util/color_item.dart';
import 'package:p88_admin/app/util/constata.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  AppBarDefault({
    super.key,
    String? title,
    List<Widget>? actions,
    bool isCenter = false
  }): _title=title, _actions=actions, _isCenter=isCenter;

  final String? _title;
  final List<Widget>? _actions;
  final bool _isCenter;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title ?? UtilConstanta.title),
      scrolledUnderElevation: 0,
      centerTitle: _isCenter,
      shape: Border(
          bottom:
              BorderSide(width: 1, color: ColorItem.tertiary.withOpacity(0.2))),
      backgroundColor: ColorItem.secondary,
      actions: [
        if(_actions != null && _actions.length > 0) ..._actions,
      ],
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}