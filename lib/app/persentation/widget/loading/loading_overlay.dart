import 'package:flutter/material.dart';

class LoadingOverlay {
  static final LoadingOverlay _loadingOverlay = LoadingOverlay._internal();
  factory LoadingOverlay() {
    return _loadingOverlay;
  }
  LoadingOverlay._internal();

  OverlayEntry _overlay = 
    OverlayEntry(
      builder: (context) => ColoredBox(
        color: Color(0x80000000),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
    );
  
  void show(BuildContext context) {
      Overlay.of(context).insert(_overlay);
  }

  void hide() {
    _overlay.remove();
  }
}