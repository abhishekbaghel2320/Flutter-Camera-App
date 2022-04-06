import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
//import 'package:flutter/services.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/*
class MyWidgetsBinding extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() => MyImageCache();
}
*/
void main() {
  //MyWidgetsBinding();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project PDP!',
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Project PDP!'),
          backgroundColor: const ui.Color.fromARGB(255, 18, 32, 18),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background.jpg'),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 30, right: 30, bottom: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Plant Disease prediction Application Interface',
                        style: TextStyle(
                            fontSize: 40,
                            foreground: Paint()
                              ..shader = ui.Gradient.linear(
                                const Offset(0, 20),
                                const Offset(150, 20),
                                <Color>[
                                  const ui.Color.fromARGB(255, 115, 152, 117),
                                  const ui.Color.fromARGB(255, 160, 172, 160),
                                ],
                              )),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, right: 70, bottom: 30),
                            child: FloatingActionButton.extended(
                              heroTag: "btn1",
                              backgroundColor:
                                  const ui.Color.fromARGB(255, 74, 121, 76),
                              onPressed: () {
                                openCamera();
                              },
                              label:
                                  const Text('Click Images of Diseased Plant'),
                            ),
                          )),
                          SizedBox(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, right: 70, bottom: 30),
                            child: FloatingActionButton.extended(
                              heroTag: "btn2",
                              backgroundColor:
                                  const ui.Color.fromARGB(255, 74, 121, 76),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const UploadPage()),
                                );
                              },
                              label: const Text('Upload Images'),
                            ),
                          )),
                        ],
                      ),
                    ]))));
  }

  XFile? camImg;
  final ImagePicker _picker = ImagePicker();

  Future openCamera() async {
    XFile? camImg = await _picker.pickImage(source: ImageSource.camera);
    if (camImg != null) {
      File? croppedImg = await ImageCropper().cropImage(
          sourcePath: camImg.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          androidUiSettings: const AndroidUiSettings(
            toolbarColor: ui.Color.fromARGB(255, 74, 92, 74),
            statusBarColor: ui.Color.fromARGB(255, 44, 67, 44),
            backgroundColor: ui.Color.fromARGB(255, 44, 67, 44),
          ));
      GallerySaver.saveImage(croppedImg!.path);
    }
  }
}

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPage createState() => _UploadPage();
}
//This is to display the image on the front screen

class _UploadPage extends State<UploadPage> {
  List<String>? display;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select and Upload!"),
          backgroundColor: const ui.Color.fromARGB(255, 18, 32, 18),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background.jpg'),
              ),
            ),
            child: Column(children: <Widget>[
              if (display != null) ...[
                displayImgs()
              ] else ...[
                const Spacer(),
                Image.asset('assets/images/placeholder.png'),
              ],
              const Spacer(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton.extended(
                        heroTag: "btn3",
                        elevation: 0.0,
                        backgroundColor:
                            const ui.Color.fromARGB(255, 79, 80, 79),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: const Text('Return to Home Screen',
                            style: TextStyle(color: Colors.white)),
                      ),
                    )),
                    SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton.extended(
                        heroTag: "btn4",
                        elevation: 0.0,
                        backgroundColor:
                            const ui.Color.fromARGB(255, 84, 95, 84),
                        onPressed: () {
                          selectImg();
                        },
                        label: const Text('Choose Images from device',
                            style: TextStyle(color: Colors.white)),
                      ),
                    )),
                    SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton.extended(
                        heroTag: "btn5",
                        elevation: 0.0,
                        backgroundColor:
                            const ui.Color.fromARGB(255, 79, 80, 79),
                        onPressed: () {
                          //if(display != null) {}
                        },
                        label: const Text('Upload Images to Cloud',
                            style: TextStyle(color: Colors.white)),
                      ),
                    )),
                  ])
            ])));
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imgs;
  Future selectImg() async {
    var _imgs = await _picker.pickMultiImage();
    if (_imgs != null) {
      imgs = _imgs;
    }
    if (display != null) {
      setState(() {
        for (int i = 0; i < imgs!.length; i++) {
          display!.add(imgs![i].path);
        }
      });
    }
  }

  displayImgs() async {
    return Container(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: display!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          itemBuilder: (BuildContext context, int index) {
            if (display != null) {
              return Image.file(File(display![index]), key: UniqueKey());
            } else {
              return Image.asset('assets/images/default.jpeg');
            }
          },
        ));
  }
}
