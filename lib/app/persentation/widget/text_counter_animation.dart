import 'package:flutter/material.dart';

class TextCounter extends StatefulWidget {
  ///
  /// duration in miliseconds
  ///
  const TextCounter({
    super.key,
    this.style,
    this.duration = 2000,
    required this.count
  });

  final TextStyle? style;
  ///
  /// duration in miliseconds
  ///
  final int duration;
  final int count;


  @override
  State<TextCounter> createState() => _TextCounterState();
}

class _TextCounterState extends State<TextCounter> {

  @override
  void initState() {
    super.initState();
  }

  Stream<int> counterInt({required int count,required int duration}) async* {
    if (count > 1) {
      duration = (duration/count).truncate();
    }
    for (var i = 0; i <= count; i++) {
      await Future.delayed(Duration(milliseconds: duration));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: counterInt(count: widget.count, duration: widget.duration), 
      builder: (context, snapshot) {
        return Text((snapshot.data ?? 100).toString(), style: widget.style, textAlign: TextAlign.center,);
      },
    );
  }
}