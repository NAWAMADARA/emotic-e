import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tflite/tflite.dart';

class EmotionDetectionScreen extends StatefulWidget {
  const EmotionDetectionScreen({super.key});

  @override
  _EmotionDetectionScreenState createState() => _EmotionDetectionScreenState();
}

class _EmotionDetectionScreenState extends State<EmotionDetectionScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  ScreenshotController screenshotController = ScreenshotController();
  String? emotion;

  @override
  void initState() {
    super.initState();
    loadModel();
    settingCamera();
  }


  @override
  void dispose() {
    controller?.dispose();
    Tflite.close();
    super.dispose();
  }

  Future<void> settingCamera() async{
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.medium);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      startTakingScreenshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          // aspectRatio: controller!.value.aspectRatio,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Screenshot(
            controller: screenshotController,
            child: Column(
              children: [
                Expanded(child: CameraPreview(controller!)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  decoration:  BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap:(){},
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.videocam_off),
                        ),
                      ),
                      InkWell(
                        onTap:(){},
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.mic_off),
                        ),
                      ),
                      InkWell(
                        onTap:(){},
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.cameraswitch),
                        ),
                      ),
                      InkWell(
                        onTap:(){},
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.call_end,color: Colors.red,),
                        ),
                      ),
                    ],
                  ),
                ),
                if(emotion!=null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                    child: Text(emotion!,style: const TextStyle(color: Colors.greenAccent,fontSize: 24),),
                  )

              ],
            ),
          ),
        ),
      ),
    );

  }

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

      if (kDebugMode) {
        print("Model loaded: $res");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading model: $e");
      }
    }
  }

  void startTakingScreenshots() async {
    Timer.periodic(const Duration(seconds: 10), (Timer t) async {
      screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          final directory = (await getApplicationDocumentsDirectory()).path;
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          final path = '$directory/$fileName.png';
          await File(path).writeAsBytes(image).then((File file) async {

            try {
              var recognitions = await Tflite.runModelOnImage(
                path: path,
                imageMean: 0.0, // Adjust if needed
                imageStd: 255.0, // Adjust if needed
                numResults: 7, // Number of emotions you want to detect
                threshold: 0.1, // Adjust if needed
                asynch: true,
              );

              if (recognitions != null && recognitions.isNotEmpty) {
                emotion = recognitions[0]['label'];
                setState(() {});
                for (var recognition in recognitions) {
                  String label = recognition["label"];
                  double confidence = recognition["confidence"];
                  print("Emotion: $label, Confidence: $confidence");
                  if (kDebugMode) {
                    print("Emotion: $label, Confidence: $confidence");
                  }
                }
              }
            } catch (e) {
              if (kDebugMode) {
                print("Error running emotion detection: $e");
              }
            }

            // if (kDebugMode) {
            //   print("Screenshot saved to $path");
            // }
            await File(path).delete();
          });
        }
      }).catchError((onError) {
        if (kDebugMode) {
          print(onError);
        }
      });
    });
  }

}













































// class EmotionDetectionScreen extends StatefulWidget {
//     const EmotionDetectionScreen({super.key});
//
//   @override
//   State<EmotionDetectionScreen> createState() => _EmotionDetectionScreenState();
// }
//
// class _EmotionDetectionScreenState extends State<EmotionDetectionScreen> {
//    CameraController? controller;
//    List<CameraDescription>? cameras;
//
//    // loadModel() async {
//    //   await Tflite.loadModel(
//    //     model: "assets/E_model.tflite",
//    //     labels: "assets/labels.txt",
//    //   );
//    // }
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //
//   //   loadModel().then((value) {
//   //     startCamera();
//   //   });
//   // }
//
//   @override
//   void dispose() {
//     controller!.dispose();
//     Tflite.close();
//     super.dispose();
//   }
//
//     startCamera() async {
//       cameras = await availableCameras();
//       controller = CameraController(cameras![0], ResolutionPreset.medium);
//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//
//         controller!.startImageStream((image) => {
//           if (controller != null)
//             {
//               Tflite.runModelOnFrame(
//                 bytesList: image.planes.map((plane) {
//                   return plane.bytes;
//                 }).toList(),
//                 imageHeight: image.height,
//                 imageWidth: image.width,
//                 imageMean: 127.5,
//                 imageStd: 127.5,
//                 rotation: 90,
//                 numResults: 2,
//                 threshold: 0.1,
//                 asynch: true,
//               ).then((value) {
//                 // handle the result
//                 print("Hello");
//                 print('Value : $value');
//               })
//             }
//         });
//       });
//     }
//
//   @override
//   Widget build(BuildContext context) {
//   //   if (controller == null || !controller!.value.isInitialized) {
//   //     return Container();
//   //   }
//   //   return AspectRatio(
//   //       aspectRatio:
//   //       controller!.value.aspectRatio,
//   //       child: CameraPreview(controller!));
//   // }
//      return Scaffold(
//       appBar: AppBar(
//         title: const Text('Emotion Detection'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//           //  captureAndRunInference();
//             final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//             await loadModel();
//             await runEmotionDetection(image!.path);
//           },
//           child: const Text('Detect Emotion'),
//         ),
//       ),
//     );
//  }
//
//   Future<Uint8List?> pickImage() async {
//     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     // or use ImageSource.gallery to pick from the gallery
//     if (image != null) {
//       return await image.readAsBytes();
//     }
//     return null; // Handle case where no image was selected
//   }
//
//
//    Future<void> loadModel() async {
//      try {
//        String modelPath = "assets/E_model.tflite"; // Update with your model path
//        String labelsPath = "assets/labels.txt"; // Update with your labels path
//
//        String? res = await Tflite.loadModel(
//          model: modelPath,
//          labels: labelsPath,
//          numThreads: 1, // You can adjust the number of threads
//          isAsset: true, // Indicates that the model and labels are in the assets
//        );
//
//        print("Model loaded: $res");
//      } catch (e) {
//        print("Error loading model: $e");
//      }
//    }
//
//
//   Future<void> runEmotionDetection(String imagePath) async {
//     try {
//       var recognitions = await Tflite.runModelOnImage(
//         path: imagePath,
//         imageMean: 0.0, // Adjust if needed
//         imageStd: 255.0, // Adjust if needed
//         numResults: 7, // Number of emotions you want to detect
//         threshold: 0.1, // Adjust if needed
//         asynch: true,
//       );
//
//       if (recognitions != null && recognitions.isNotEmpty) {
//         for (var recognition in recognitions) {
//           String label = recognition["label"];
//           double confidence = recognition["confidence"];
//           print("Emotion: $label, Confidence: $confidence");
//         }
//       }
//     } catch (e) {
//       print("Error running emotion detection: $e");
//     }
//   }
// }
