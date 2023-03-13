import 'dart:io';
import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../styles/input_decoration.dart';
import '../../widgets/text_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCharityCause extends StatefulWidget {
  const AddCharityCause({Key? key}) : super(key: key);

  @override
  State<AddCharityCause> createState() => _AddCharityCauseState();
}

class _AddCharityCauseState extends State<AddCharityCause> {
  final MyAppController _app = Get.find();
  var addCharityCause = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController charityNo = TextEditingController();
  TextEditingController stripeKey = TextEditingController();

  bool value = false;

  ImagePicker picker = ImagePicker();
  final FirebaseStorage storage = FirebaseStorage.instance;
  var _image;
  var pickedFile;
  uploadImage() async {
    try {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        print(pickedFile.path);
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print("No file Selected");
      }
    } catch (e) {
      print("Image Picker Exception: $e");
      Get.snackbar("Something went wrong!", "Please try again later.");
    }
    // upload to firebase
    try {
      if (_image != null) {
        SettableMetadata metadata = SettableMetadata(
          contentType: 'image',
          cacheControl: 'max-age=60',
        );
        Reference _storageRef =
            storage.ref().child('RamadanCharities/${UniqueKey().toString()}');
        UploadTask _uploadTask;
        if (GetPlatform.isWeb) {
          _uploadTask =
              _storageRef.putData(await pickedFile.readAsBytes(), metadata);
        } else {
          _uploadTask = _storageRef.putFile(_image, metadata);
        }
        TaskSnapshot _tasksnapshot = await _uploadTask;
        // ignore: unused_local_variable
        var link;
        // ignore: unnecessary_null_comparison
        if (_uploadTask != null) {
          link = await _tasksnapshot.ref.getDownloadURL().then((fileUrl) async {
            print("Uploaded Image Link: $fileUrl");
            setState(() {
              image.text = fileUrl;
              print(image.text);
            });
          });
        }
      }
    } catch (e) {
      print('FirebaseStorage Exception: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withAlpha(0),
        title: const TextWidget(
          text: 'Add Charities Cause',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: htextDark),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: addCharityCause,
          child: Center(
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                width: Get.width * 0.4,
                padding: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        autofocus: true,
                        controller: name,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                            fontFamily: 'Futura', color: htextColor),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Cause name is required.';
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hint: 'Cause Name',
                          focusColor: const Color(0xffB08850),
                          textColor: Colors.grey,
                          borderColor: const Color(0xffB08850),
                          errorColor: const Color(0xffB08850),
                        ),
                      ),
                      TextFormField(
                        controller: address,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                            fontFamily: 'Futura', color: htextColor),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Price is required';
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hint: 'Price',
                          helper: 'Default price is in Pounds',
                          focusColor: const Color(0xffB08850),
                          helperColor: const Color(0xffB08850),
                          textColor: Colors.grey,
                          borderColor: const Color(0xffB08850),
                          errorColor: const Color(0xffB08850),
                        ),
                      ),
                      TextFormField(
                        controller: image,
                        maxLines: 1,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                            fontFamily: 'Futura', color: htextColor),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Cause picture is required';
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hint: 'Cause Picture',
                          focusColor: const Color(0xffB08850),
                          textColor: Colors.grey,
                          borderColor: const Color(0xffB08850),
                          errorColor: const Color(0xffB08850),
                          suffix: IconButton(
                              onPressed: () {
                                uploadImage();
                              },
                              icon: const Icon(Icons.camera, color: htextDark)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 200,
                        margin: const EdgeInsets.only(top: 60),
                        child: ElevatedButton(
                          child: const TextWidget(
                            text: 'Add Charity',
                            size: 17,
                            alignment: Alignment.center,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (addCharityCause.currentState!.validate()) {
                              _app.causesRef.add({
                                'name': name.text,
                                'price': address.text,
                                'type': 'Fitrana',
                                'image': image.text,
                              }).then((value) {
                                Get.snackbar('Cause added successfully', '');
                                // Get.back();
                                Get.offAllNamed('/LoveRamadan');
                              });
                              addCharityCause.currentState!.save();
                            }
                          },
                          style: elevatedButton(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
