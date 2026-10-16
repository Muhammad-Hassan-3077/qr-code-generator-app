
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/qr_input_card.dart';
import '../widgets/qr_preview_card.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final TextEditingController _inputController =
  TextEditingController();

  String _qrData = '';
  String? _errorMessage;

  void _generateQRCode() {
    final input = _inputController.text.trim();

    if (input.isEmpty) {
      setState(() {
        _qrData = '';
        _errorMessage = 'Please enter some text or a URL.';
      });
      return;
    }

    setState(() {
      _qrData = input;
      _errorMessage = null;
    });
  }

  void _clearInput() {
    setState(() {
      _inputController.clear();
      _qrData = '';
      _errorMessage = null;
    });
  }

  void _onInputChanged(String value) {
    if (_errorMessage != null) {
      setState(() => _errorMessage = null);
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        title: const Row(
          children: [
            Icon(
              Icons.qr_code_2_rounded,
              color: AppTheme.blue,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              'QR Studio',
              style: TextStyle(
                color: AppTheme.navy,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'QR GENERATOR',
                style: TextStyle(
                  color: AppTheme.blue,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1050),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Turn anything into a QR code.',
                    style: TextStyle(
                      color: AppTheme.navy,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Create, save and share QR codes in seconds.',
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 30),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final inputCard = QrInputCard(
                        controller: _inputController,
                        errorMessage: _errorMessage,
                        onGenerate: _generateQRCode,
                        onClear: _clearInput,
                        onInputChanged: _onInputChanged,
                      );

                      final previewCard = QrPreviewCard(
                        qrData: _qrData,
                      );

                      if (constraints.maxWidth >= 720) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: inputCard),
                            const SizedBox(width: 22),
                            Expanded(child: previewCard),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          inputCard,
                          const SizedBox(height: 22),
                          previewCard,
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'Simple • Secure • Fast',
                      style: TextStyle(
                        color: AppTheme.muted,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
