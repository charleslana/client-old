import 'package:client/app.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final fToast = FToast();

void showToast(BuildContext context, String message) {
  closeToast();
  fToast
      .init(context)
      .showToast(child: Text(message), gravity: ToastGravity.SNACKBAR);
}

void closeToast() {
  fToast.removeCustomToast();
}

void navigate(String route) {
  closeToast();
  routemaster.push(route);
}

void replace(String route) {
  closeToast();
  routemaster.replace(route);
}

void goToBack() {
  closeToast();
  routemaster.history.back();
}
