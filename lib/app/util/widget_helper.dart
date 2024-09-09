import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap._(double size, {
    super.key,
    bool isRow = false,
  }):  _isRow=isRow, _size=size;

  final bool _isRow;
  final double? _size;

  @override
  Widget build(BuildContext context) {
    if(_isRow) {
      return SizedBox(width: _size,);
    }
    return SizedBox(height: _size,);
  }

  factory Gap.row(double size, {Key? key}) {
    return Gap._(size,isRow: true,);
  }

  factory Gap.column(double size, {Key? key}) {
    return Gap._(size);
  }
}