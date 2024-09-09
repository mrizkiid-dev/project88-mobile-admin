import 'package:flutter/material.dart';

abstract class Controller {
  void didChangeDependencies(BuildContext context);
  void initState();
  void dispose();
}