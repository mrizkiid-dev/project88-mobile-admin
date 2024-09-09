import 'package:flutter/material.dart';
import 'package:p88_admin/app/persentation/widget/appbar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(title: 'profile',),
      body: Center(
        child: Text('Notifications ganti'),
      )
    );
  }
}