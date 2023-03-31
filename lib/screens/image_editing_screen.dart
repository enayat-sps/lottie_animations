import 'dart:io';

import 'package:file_picker/file_picker.dart';

// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:image/image.dart' as image;
import 'package:lottie_animations/utils/loader_rive.dart';

class ImageEditingScreen extends StatefulWidget {
  const ImageEditingScreen({Key? key}) : super(key: key);

  @override
  State<ImageEditingScreen> createState() => _ImageEditingScreenState();
}

class _ImageEditingScreenState extends State<ImageEditingScreen> {
  bool _showLoading = false;
  Uint8List? _image;
  Uint8List? _originalImage;
  final List<Uint8List?> _backupImagesList = [];
  int _currentIndex = 0;

  void _showImagePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    _loadImage(result?.files.single.path);
  }

  void _loadImage(String? path) async {
    if (path == null) return;

    setState(() {
      _showLoading = true;
    });
    final image = await File(path).readAsBytes();
    setState(() {
      _image = image;
      _originalImage = image;
      _backupImagesList.add(image);
      _showLoading = false;
    });
  }

  void _applySepia() async {
    setState(() {
      _showLoading = true;
    });
    final image = await compute(_sepiaFilter, _image!);
    setState(() {
      _image = image;
      _backupImagesList.add(image);
      _currentIndex++;
      _showLoading = false;
    });
  }

  void _applyBlur() async {
    setState(() {
      _showLoading = true;
    });
    final image = await compute(_blurFilter, _image!);
    setState(() {
      _image = image;
      _backupImagesList.add(image);
      _currentIndex++;
      _showLoading = false;
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

  void _undo() {
    print(_currentIndex);
    printStatus('Backup list length: ${_backupImagesList.length}');
    if (_currentIndex > 0) {
      _backupImagesList.removeAt(_currentIndex);
      _currentIndex--;
      setState(() {
        _image = _backupImagesList[_currentIndex];
      });
    }
    print(_currentIndex);
    printStatus('Backup list length: ${_backupImagesList.length}');
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
          if (_showLoading) ...[
            const LoaderRive(),
          ],
        ],
      ),
      persistentFooterButtons: <Widget>[
        TextButton(
          onPressed: !_showLoading && _image == null ? _showImagePicker : null,
          child: const Text('Load'),
        ),
        TextButton(
          onPressed: !_showLoading && _image != null ? _applySepia : null,
          child: const Text('Sepia'),
        ),
        TextButton(
          onPressed: !_showLoading && _image != null ? _applyBlur : null,
          child: const Text('Blur'),
        ),
        TextButton(
          onPressed: !_showLoading && _image != _originalImage ? _undo : null,
          child: const Text('Undo'),
        ),
        TextButton(
          onPressed: !_showLoading && _image != _originalImage ? _reset : null,
          child: const Text('Reset'),
        ),
        TextButton(
          onPressed: !_showLoading && _image != null ? _clear : null,
          child: const Text('Clear'),
        ),
      ],
    );
  }
}
