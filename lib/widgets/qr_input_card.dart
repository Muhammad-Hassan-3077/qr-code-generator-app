
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class QrInputCard extends StatelessWidget {
  final TextEditingController controller;
  final String? errorMessage;
  final VoidCallback onGenerate;
  final VoidCallback onClear;
  final ValueChanged<String> onInputChanged;

  const QrInputCard({
    super.key,
    required this.controller,
    required this.errorMessage,
    required this.onGenerate,
    required this.onClear,
    required this.onInputChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8EDF5)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.navy.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.edit_note_rounded,
                color: AppTheme.blue,
                size: 25,
              ),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Create your QR code',
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Enter any text, website URL or other information.',
            style: TextStyle(
              color: AppTheme.muted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'TEXT OR URL',
            style: TextStyle(
              color: AppTheme.navy,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            minLines: 4,
            maxLines: 6,
            maxLength: 2000,
            onChanged: onInputChanged,
            decoration: const InputDecoration(
              hintText: 'https://example.com\n\nOr type your own text...',
              alignLabelWithHint: true,
              counterStyle: TextStyle(color: AppTheme.muted),
            ),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
              ),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: onGenerate,
              icon: const Icon(Icons.qr_code_2_rounded),
              label: const Text(
                'Generate QR Code',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: onClear,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Clear'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.navy,
                side: const BorderSide(color: AppTheme.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
