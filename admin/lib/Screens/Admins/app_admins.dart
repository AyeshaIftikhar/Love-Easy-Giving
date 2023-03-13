import '../../Constants/colors.dart';
import '../../Controller/app_controller.dart';
import '../../styles/button_styles.dart';
import '../../widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppAdmins extends StatelessWidget {
  AppAdmins({Key? key}) : super(key: key);
  final MyAppController _app = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withAlpha(0),
        title: const TextWidget(
          text: 'Love Easy Giving - Admins',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ),
        leading: IconButton(
         onPressed: () => Get.offAllNamed('/'),
          icon: const Icon(Icons.arrow_back_ios, color: htextDark),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _app.allowed.value
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 30,
                      width: 200,
                      padding: const EdgeInsets.only(right: 20),
                      child: OutlinedButton.icon(
                        onPressed: () => Get.toNamed('/AddAdmin'),
                        label: const TextWidget(
                          text: 'Add New Admin',
                          color: Color(0xff6B5233),
                          alignment: Alignment.center,
                        ),
                        icon: const Icon(Icons.edit_outlined,
                            color: Color(0xff6B5233)),
                        style: outlinebutton(
                          borderColor: const Color(0xff6B5233),
                          radius: 10,
                        ),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: 10),
            StreamBuilder(
                stream: _app.adminsRef
                    .where('username', isNotEqualTo: _app.userName.value)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: Get.width * .3,
                            child: Card(
                              elevation: 5.0,
                              margin: const EdgeInsets.only(
                                left: 50,
                                right: 50,
                                bottom: 10,
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ListTile(
                                contentPadding: const EdgeInsets.only(left: 20),
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    snapshot.data.docs[index].get('picture'),
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextWidget(
                                    text: snapshot.data.docs[index].get('Name'),
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextWidget(
                                    text:
                                        'Username: ${snapshot.data.docs[index].get('username')}\nAllowed to edit other admins: ${snapshot.data.docs[index].get('allowed').toString()}\n',
                                    lineHeight: 1.5,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _app.allowed.value
                                        ? IconButton(
                                            onPressed: () {
                                              _app.adminsRef
                                                  .doc(snapshot
                                                      .data.docs[index].id)
                                                  .delete();
                                            },
                                            icon: const Icon(Icons.delete,
                                                color: htextDark))
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryDark),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryDark),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
