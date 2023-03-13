import 'dart:io';
import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../widgets/text_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MyAppController _app = Get.find();

  Future onActionSelected(String value) async {
    switch (value) {
      case 'Change Password':
        Get.toNamed('/ChangePassword');
        break;
      case 'New Admin':
        Get.toNamed('/AddAdmin');
        break;
      case 'logout':
        _app.logout();
        break;
    }
  }

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
            storage.ref().child('ProfilePicture/${UniqueKey().toString()}');
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
              _app.picture.value = fileUrl;
              _app.adminsRef.doc(_app.adminId.value).update({
                'picture': _app.picture.value,
              });
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
          text: 'Admin Dashboard',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ),
        leading: Obx(() => IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                _app.picture.value,
              ),
            ))),
        actions: [
          PopupMenuButton(
            onSelected: onActionSelected,
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'Change Password',
                  child: TextWidget(
                    text: 'Change Password',
                  ),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: TextWidget(
                    text: 'Logout',
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Row(
                  children: [
                    Obx(() => Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(_app.picture.value),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90.0, right: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: const CircleAvatar(
                            backgroundColor: htextDark,
                            radius: 25.0,
                            child: Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ]),
                ),
                Column(
                  children: [
                    TextWidget(
                      text: _app.adminName.value,
                      weight: FontWeight.bold,
                      size: 20,
                    ),
                    const SizedBox(height: 10),
                    TextWidget(
                      text:'Username: '+ _app.userName.value,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => TextButton(
                      onPressed: () {
                        setState(() {
                          _app.ramadan.value = !_app.ramadan.value;
                          _app.mode.doc('mode_type').update({
                            'Ramadan': _app.ramadan.value,
                          });
                        });
                      },
                      child: TextWidget(
                          alignment: Alignment.topRight,
                          text: !_app.ramadan.value
                              ? 'Enable Ramadan Mode'
                              : 'Disable Ramadan Mode'),
                    )),
                Obx(() => TextButton(
                      onPressed: () {
                        setState(() {
                          _app.hajj.value = !_app.hajj.value;
                          _app.mode.doc('mode_type').update({
                            'Hajj': _app.hajj.value,
                          });
                        });
                      },
                      child: TextWidget(
                          alignment: Alignment.topRight,
                          text: !_app.hajj.value
                              ? 'Enable Hajj Mode'
                              : 'Disable Hajj Mode'),
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: Get.width * 0.4,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        width: 2.0, color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 10),
                      const TextWidget(
                        text: 'Love Easy Giving - General',
                        weight: FontWeight.bold,
                        size: 20,
                      ),
                      const Divider(thickness: 2),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const SizedBox(
                            height: 40,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                'assets/applogo.png',
                              ),
                            ),
                          ),
                          title: const TextWidget(text: 'Love Jummah'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color(0xff6B5233),
                          ),
                          onTap: () => Get.toNamed('/Mosque'),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const SizedBox(
                            height: 40,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                'assets/applogo.png',
                              ),
                            ),
                          ),
                          title: const TextWidget(text: 'Love Ramadan'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color(0xff6B5233),
                          ),
                          onTap: () => Get.toNamed('/LoveRamadan'),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const SizedBox(
                            height: 40,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                'assets/applogo.png',
                              ),
                            ),
                          ),
                          title: const TextWidget(text: 'Love Hajj'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color(0xff6B5233),
                          ),
                          onTap: () => Get.toNamed('/LoveHajj'),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const SizedBox(
                            height: 40,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                'assets/applogo.png',
                              ),
                            ),
                          ),
                          title:
                              const TextWidget(text: 'View Donation History'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color(0xff6B5233),
                          ),
                          onTap: () =>
                              Get.toNamed('/DonationHistory', parameters: {
                            'app_mode': 'general',
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.4,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        width: 2.0, color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 10),
                      const TextWidget(
                        text: 'Love Easy Giving - Individual',
                        weight: FontWeight.bold,
                        size: 20,
                      ),
                      const Divider(thickness: 2),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                            leading: const SizedBox(
                              height: 40,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  'assets/applogo.png',
                                ),
                              ),
                            ),
                            title: const TextWidget(text: 'Love Jummah'),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color(0xff6B5233),
                            ),
                            onTap: () => Get.toNamed('/JummahIndividual')),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const SizedBox(
                            height: 40,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                'assets/applogo.png',
                              ),
                            ),
                          ),
                          title: const TextWidget(text: 'Love Ramadan'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color(0xff6B5233),
                          ),
                          onTap: () => Get.toNamed('/LoveRamadan'),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const SizedBox(
                            height: 40,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                'assets/applogo.png',
                              ),
                            ),
                          ),
                          title: const TextWidget(text: 'Love Hajj'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color(0xff6B5233),
                          ),
                          onTap: () => Get.toNamed('/LoveHajj'),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const SizedBox(
                            height: 40,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                'assets/applogo.png',
                              ),
                            ),
                          ),
                          title:
                              const TextWidget(text: 'View Donation History'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color(0xff6B5233),
                          ),
                          onTap: () =>
                              Get.toNamed('/DonationHistory', parameters: {
                            'app_mode': 'individual',
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              width: Get.width * 0.4,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border:
                    Border.all(width: 2.0, color: Colors.grey.withOpacity(0.2)),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 10),
                  const TextWidget(
                    text: 'Love Easy Giving - Users & Admins',
                    weight: FontWeight.bold,
                    size: 20,
                  ),
                  const Divider(thickness: 2),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const SizedBox(
                        height: 40,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'assets/applogo.png',
                          ),
                        ),
                      ),
                      title: const TextWidget(text: 'App Users'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xff6B5233),
                      ),
                      onTap: () => Get.toNamed('/AppUsers'),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const SizedBox(
                        height: 40,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'assets/applogo.png',
                          ),
                        ),
                      ),
                      title: const TextWidget(text: 'Admins'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xff6B5233),
                      ),
                      onTap: () => Get.toNamed('/AppAdmins'),
                    ),
                  ),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: ListTile(
                  //     leading: const SizedBox(
                  //       height: 40,
                  //       child: CircleAvatar(
                  //         radius: 20,
                  //         backgroundImage: AssetImage(
                  //           'assets/applogo.png',
                  //         ),
                  //       ),
                  //     ),
                  //     title: const TextWidget(text: 'Love Hajj'),
                  //     trailing: const Icon(Icons.arrow_forward_ios_outlined,
                  //         color: Color(0xff6B5233)),
                  //     onTap: () {},
                  //   ),
                  // ),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: ListTile(
                  //     leading: const SizedBox(
                  //       height: 40,
                  //       child: CircleAvatar(
                  //         radius: 20,
                  //         backgroundImage: AssetImage(
                  //           'assets/applogo.png',
                  //         ),
                  //       ),
                  //     ),
                  //     title: const TextWidget(text: 'View Donation History'),
                  //     trailing: const Icon(Icons.arrow_forward_ios_outlined,
                  //         color: Color(0xff6B5233)),
                  //     onTap: () {},
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
