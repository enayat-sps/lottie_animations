import 'dart:io';

import 'package:file_picker/file_picker.dart';

// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;
import 'package:lottie_animations/utils/show_loader.dart';

class ImageEditingScreen extends StatefulWidget {
  const ImageEditingScreen({Key? key}) : super(key: key);

  @override
  State<ImageEditingScreen> createState() => _ImageEditingScreenState();
}

class _ImageEditingScreenState extends State<ImageEditingScreen> {
  bool _showProgress = false;
  Uint8List? _image;
  Uint8List? _originalImage;

  void _showImagePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    _loadImage(result?.files.single.path);
  }

  void _loadImage(String? path) async {
    if (path == null) return;

    setState(() {
      _showProgress = true;
    });
    final image = await File(path).readAsBytes();
    setState(() {
      _image = image;
      _originalImage = image;
      _showProgress = false;
    });
  }

  void _applySepia() async {
    setState(() {
      _showProgress = true;
    });
    final image = await compute(_sepiaFilter, _image!);
    setState(() {
      _image = image;
      _showProgress = false;
    });
  }

  void _applyGamma() async {
    setState(() {
      _showProgress = true;
    });
    final image = await compute(_blurFilter, _image!);
    setState(() {
      _image = image;
      _showProgress = false;
    });
  }

  static Uint8List _sepiaFilter(Uint8List original) {
    final decoded = image.decodeImage(original)!;
    final sepia = image.sepia(decoded);
    final encoded = Uint8List.fromList(image.encodeJpg(sepia));
    return encoded;
  }

  static Uint8List _blurFilter(Uint8List original) {
    final decoded = image.decodeImage(original)!;
    final sepia = image.gaussianBlur(decoded, radius: 20);
    final encoded = Uint8List.fromList(image.encodeJpg(sepia));
    return encoded;
  }

  void _reset() {
    setState(() {
      _image = _originalImage;
    });
  }

  void _clear() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Processing Demo'),
      ),
      body: Stack(
        children: [
          if (_image != null)
            Center(
              child: Image.memory(_image!, gaplessPlayback: true),
            ),
          if (_showProgress) ...[
            const ShowLoader(),
          ],
        ],
      ),
      persistentFooterButtons: <Widget>[
        TextButton(
          onPressed: !_showProgress && _image == null ? _showImagePicker : null,
          child: const Text('Load'),
        ),
        TextButton(
          onPressed: !_showProgress && _image != null ? _applySepia : null,
          child: const Text('Sepia'),
        ),
        TextButton(
          onPressed: !_showProgress && _image != null ? _applyGamma : null,
          child: const Text('Blur'),
        ),
        TextButton(
          onPressed: !_showProgress && _image != _originalImage ? _reset : null,
          child: const Text('Reset'),
        ),
        TextButton(
          onPressed: !_showProgress && _image != null ? _clear : null,
          child: const Text('Clear'),
        ),
      ],
    );
  }
}
