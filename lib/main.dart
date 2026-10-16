
import 'package:flutter/material.dart';

import 'screens/qr_generator_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const QRCodeGeneratorApp());
}

class QRCodeGeneratorApp extends StatelessWidget {
  const QRCodeGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Studio',
      theme: AppTheme.lightTheme,
      home: const QrGeneratorScreen(),
    );
  }
}
