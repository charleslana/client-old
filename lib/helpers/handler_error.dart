import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/handle_error.dart';
import '../utils/utils.dart';

Future<void> getError(DioException e, BuildContext context) async {
  if (e.response != null) {
    final int statusCode = e.response?.statusCode ?? 0;
    if (statusCode == 500) {
      await showInfo(context,
          'Um problema foi encontrado nesta ação, por favor entre em contato com o suporte');
      return;
    }
    if (statusCode == 401) {
      await showUnauthenticated(context);
      return;
    }
    if (statusCode == 403) {
      await showForbidden(context);
      return;
    }
    final error = HandleError.fromMap(e.response?.data);
    if (error.errors != null) {
      showToast(context, error.errors!.join(' '), error: true);
      return;
    }
    showToast(context, error.message, error: true);
    return;
  }
  await showInfo(context,
      'O servidor não está respondendo, por favor tente novamente mais tarde');
}
