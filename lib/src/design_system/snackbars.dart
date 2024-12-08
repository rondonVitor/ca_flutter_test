import 'package:flutter/material.dart';

void showErrorSnackbar({
  required BuildContext context,
  String message = 'Ocorreu um erro, tente novamente mais tarde.',
}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
