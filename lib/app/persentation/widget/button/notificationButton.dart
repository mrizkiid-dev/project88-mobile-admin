import 'package:flutter/material.dart';

class NotifcationButton extends StatelessWidget {
  const NotifcationButton({
    super.key,
    required void Function()? onPressed
  }):_onPressed = onPressed;

  final void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onPressed,
      icon: Stack(
        children: [
          Icon(Icons.notifications),
          Positioned(
            right: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}