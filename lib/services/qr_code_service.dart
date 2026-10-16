
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_saver/file_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

class QrCodeService {
  QrCodeService._();

  /// Captures a QR code from its RepaintBoundary as PNG bytes.
  static Future<Uint8List> captureQrImage(
      RenderRepaintBoundary boundary,
      ) async {
    final ui.Image image = await boundary.toImage(pixelRatio: 3);

    try {
      final byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        throw Exception('Unable to convert QR code to PNG.');
      }

      return byteData.buffer.asUint8List();
    } finally {
      image.dispose();
    }
  }

  /// Saves the QR code as a PNG image.
  static Future<void> saveQrImage(Uint8List bytes) async {
    await FileSaver.instance.saveFile(
      name: 'qr_code.png',
      bytes: bytes,
      mimeType: MimeType.png,
    );
  }

  /// Shares the QR code image using the platform share interface.
  static Future<void> shareQrImage(Uint8List bytes) async {
    await SharePlus.instance.share(
      ShareParams(
        text: 'QR code generated with QR Studio.',
        files: [
          XFile.fromData(
            bytes,
            mimeType: 'image/png',
            name: 'qr_code.png',
          ),
        ],
      ),
    );
  }
}
