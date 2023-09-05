import 'package:client/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void getError(DioException e, BuildContext context) {
  if (e.response != null) {
    showToast(context, e.response!.data.toString());
  } else {
    print(e.requestOptions);
    print(e.message);
  }
}
