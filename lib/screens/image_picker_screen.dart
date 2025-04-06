import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  bool _isUploading = false;
  double _uploadProgress = 0;
  String? _imageUrl;
  bool _showSuccess = false;
  final Random _random = Random();

  final List<String> _mockImages = [
    'https://picsum.photos/300/300?random=1',
    'https://picsum.photos/300/300?random=2',
    'https://picsum.photos/300/300?random=3',
  ];

  Future<void> _simulateImagePickAndUpload() async {
    // Phase 1: Image selection delay
    setState(() {
      _isUploading = true;
      _uploadProgress = 0;
      _showSuccess = false;
    });
    
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Phase 2: Upload simulation with progress
    const uploadSteps = 20;
    for (int i = 0; i < uploadSteps; i++) {
      await Future.delayed(Duration(milliseconds: 100 + _random.nextInt(200)));
      setState(() {
        _uploadProgress = (i + 1) / uploadSteps;
      });
    }
    
    // Phase 3: Processing simulation
    setState(() => _uploadProgress = 1.0);
    await Future.delayed(const Duration(seconds: 1));
    
    // Final result
    setState(() {
      _isUploading = false;
      _imageUrl = _mockImages[_random.nextInt(_mockImages.length)];
      _showSuccess = true;
    });
    
    // Hide success after delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _showSuccess = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Preview Section
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: _isUploading
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            value: _uploadProgress,
                            strokeWidth: 6,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _uploadProgress < 1.0
                                ? 'Uploading... ${(_uploadProgress * 100).toStringAsFixed(0)}%'
                                : 'Processing...',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : (_imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(_imageUrl!, fit: BoxFit.cover),
                        )
                      : const Center(
                          child: Icon(Icons.image, size: 80, color: Colors.grey),
                        )),
            ),
            const SizedBox(height: 30),
            
            // Upload Button
            ElevatedButton(
              onPressed: _isUploading ? null : _simulateImagePickAndUpload,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Select & Upload Image',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            
            // Success Message
            if (_showSuccess)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 10),
                    Text('Image uploaded successfully!'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}