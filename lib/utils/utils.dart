import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final fToast = FToast();

void showToast(BuildContext context, String message, {bool error = false}) {
  closeToast();
  final toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: error ? Colors.redAccent : Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (error) ...[
          Icon(Icons.close, color: error ? Colors.white : Colors.black),
        ] else ...[
          Icon(Icons.check, color: error ? Colors.white : Colors.black),
        ],
        const SizedBox(
          width: 12,
        ),
        Flexible(
            child: Text(
          message,
          style: TextStyle(color: error ? Colors.white : Colors.black),
        )),
      ],
    ),
  );
  fToast.init(context).showToast(
        child: toast,
        gravity: ToastGravity.TOP,
      );
}

void closeToast() {
  fToast.removeCustomToast();
}

void navigate(BuildContext context, String route) {
  closeToast();
  Navigator.pushNamed(context, route);
}

void replace(BuildContext context, String route) {
  closeToast();
  Navigator.pushReplacementNamed(context, route);
}

void goToBack(BuildContext context) {
  closeToast();
  Navigator.of(context).popUntil((route) => route.isFirst);
}

void close(BuildContext context) {
  Navigator.pop(context);
}

void showLoading(BuildContext context) {
  showDialog<dynamic>(
    barrierColor: Colors.transparent,
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return WillPopScope(
        onWillPop: () async => false,
        child: const Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 5),
                Text(
                  'Aguarde...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showInfo(BuildContext context, String message) async {
  await showDialog<dynamic>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => close(context),
              child: const Text('Fechar'),
            ),
          ],
        ),
      );
    },
  );
}
