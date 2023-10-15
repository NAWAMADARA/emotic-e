import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:tflite/tflite.dart';


class EmotionDetectionScreen extends StatelessWidget {
    const EmotionDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Detection'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
          //  captureAndRunInference();
            final image = await ImagePicker().pickImage(source: ImageSource.gallery);
            await loadModel();
            await runEmotionDetection(image!.path);
          },
          child: const Text('Detect Emotion'),
        ),
      ),
    );
  }

  Future<Uint8List?> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // or use ImageSource.gallery to pick from the gallery
    if (image != null) {
      return await image.readAsBytes();
    }
    return null; // Handle case where no image was selected
  }
//
//    // Load the model and labels
   Future<void> loadModel() async {
     try {
       String modelPath = "assets/E_model.tflite"; // Update with your model path
       String labelsPath = "assets/labels.txt"; // Update with your labels path

       String? res = await Tflite.loadModel(
         model: modelPath,
         labels: labelsPath,
         numThreads: 1, // You can adjust the number of threads
         isAsset: true, // Indicates that the model and labels are in the assets
       );

       print("Model loaded: $res");
     } catch (e) {
       print("Error loading model: $e");
     }
   }
//
// // Run emotion detection on an image
  Future<void> runEmotionDetection(String imagePath) async {
    try {
      var recognitions = await Tflite.runModelOnImage(
        path: imagePath,
        imageMean: 0.0, // Adjust if needed
        imageStd: 255.0, // Adjust if needed
        numResults: 7, // Number of emotions you want to detect
        threshold: 0.1, // Adjust if needed
        asynch: true,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        for (var recognition in recognitions) {
          String label = recognition["label"];
          double confidence = recognition["confidence"];
          print("Emotion: $label, Confidence: $confidence");
        }
      }
    } catch (e) {
      print("Error running emotion detection: $e");
    }
  }

}
