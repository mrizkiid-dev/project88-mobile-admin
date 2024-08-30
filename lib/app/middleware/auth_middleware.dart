// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:p88_admin/app/domain/entity/auth.dart';
// import 'package:p88_admin/app/domain/usecase/auth/getToken.dart';
// import 'package:p88_admin/app/persentation/page/auth/login/index.dart';
// import 'package:p88_admin/core/response/error/cache_failure.dart';

// class AuthMiddleware {
//   AuthMiddleware(this._usecase);

//   GetAuthToken _usecase;

//   Future<Widget> router(Widget navigateTo) async {
//     try {
//       String? token;
//       Either<CacheFailure, Auth> result = await _usecase.execute();
//       result.fold(
//         (error) => throw error,
//         (success) {
//           token = success.token;
//         },
//       );

//       if (token != '') {
//         return navigateTo;
//       } else {
//         throw 'token not found';
//       }
//     } catch (e) {
//       return LoginPage();
//     }
//   }

// }