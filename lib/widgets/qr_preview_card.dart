
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../services/qr_code_service.dart';
import '../theme/app_theme.dart';

class QrPreviewCard extends StatefulWidget {
  final String qrData;

  const QrPreviewCard({
    super.key,
    required this.qrData,
  });

  @override
  State<QrPreviewCard> createState() => _QrPreviewCardState();
}

class _QrPreviewCardState extends State<QrPreviewCard> {
  final GlobalKey _qrBoundaryKey = GlobalKey();

  bool _isSaving = false;
  bool _isSharing = false;

  bool get _hasQr => widget.qrData.isNotEmpty;

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<Uint8List?> _captureQrImage() async {
    final boundary = _qrBoundaryKey.currentContext
        ?.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) return null;

    return QrCodeService.captureQrImage(boundary);
  }

  Future<void> _saveQrCode() async {
    if (!_hasQr || _isSaving || _isSharing) return;

    setState(() => _isSaving = true);

    try {
      final bytes = await _captureQrImage();

      if (bytes == null) {
        throw Exception('QR image is not ready.');
      }

      await QrCodeService.saveQrImage(bytes);
      _showMessage('QR code saved successfully.');
    } catch (error) {
      debugPrint('Save QR error: $error');
      _showMessage('Could not save QR code. Please try again.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _shareQrCode() async {
    if (!_hasQr || _isSaving || _isSharing) return;

    setState(() => _isSharing = true);

    try {
      final bytes = await _captureQrImage();

      if (bytes == null) {
        throw Exception('QR image is not ready.');
      }

      await QrCodeService.shareQrImage(bytes);
      _showMessage('Share action opened.');
    } catch (error) {
      debugPrint('Share QR error: $error');
      _showMessage(
        'Sharing is not supported or failed on this platform.',
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBusy = _isSaving || _isSharing;

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
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'QR CODE PREVIEW',
              style: TextStyle(
                color: AppTheme.navy,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 260,
            height: 260,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.border),
            ),
            child: Center(
              child: _hasQr
                  ? RepaintBoundary(
                key: _qrBoundaryKey,
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: QrImageView(
                      data: widget.qrData,
                      version: QrVersions.auto,
                      size: 204,
                      backgroundColor: Colors.white,
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                    ),
                  ),
                ),
              )
                  : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_2_rounded,
                    size: 75,
                    color: Color(0xFFCBD5E1),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Your QR code appears here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _hasQr
                ? 'QR code generated successfully'
                : 'Ready when you are',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.navy,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _hasQr
                ? widget.qrData
                : 'Enter text or a URL to get started.',
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppTheme.muted,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              onPressed: _hasQr && !isBusy ? _saveQrCode : null,
              icon: _isSaving
                  ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.download_rounded),
              label: Text(
                _isSaving ? 'Saving...' : 'Save QR Code',
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
              onPressed: _hasQr && !isBusy ? _shareQrCode : null,
              icon: _isSharing
                  ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.share_rounded),
              label: Text(
                _isSharing ? 'Preparing...' : 'Share QR Code',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.blue,
                side: const BorderSide(color: Color(0xFFD6E4FF)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          if (!_hasQr) ...[
            const SizedBox(height: 14),
            const Text(
              'Generate a QR code to enable saving and sharing.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.muted,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
