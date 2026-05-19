import 'package:flutter/material.dart';
import 'package:saa2025/pages/secret_box/secret_box.dart';

void openSecretBox(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => const SecretBoxState()),
  );
}
