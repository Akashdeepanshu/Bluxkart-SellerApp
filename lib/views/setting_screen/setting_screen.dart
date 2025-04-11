import 'package:bluxkart_seller/services/StoreService.dart';
import 'package:bluxkart_seller/views/common/bg_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/authcontroller.dart';
import '../../Controllers/profileController.dart';
import '../../constants/consts.dart';
import '../../constants/firebase_const.dart';
import '../auth_screen/Login_screen.dart';
import 'editprofile_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Settings".text.white.bold.make(),
          centerTitle: true,
          elevation: 2,
        ),
        body: FutureBuilder(
          future: StoreService.getProfile(currentuser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              controller.snapshotData = snapshot.data!.docs[0];

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      20.heightBox,

                      // Profile Header
                      Row(
                        children: [
                          // Profile Avatar with initials
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Text(
                              controller.snapshotData['vendor_name'][0].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          16.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${controller.snapshotData['vendor_name']}".text.white.bold.size(20).make(),
                              "${controller.snapshotData['email']}".text.white.size(14).make(),
                            ],
                          )
                        ],
                      ),
                      30.heightBox,

                      // Section: Actions
                      Align(
                        alignment: Alignment.centerLeft,
                        child: "Account Settings".text.white.semiBold.size(16).make(),
                      ),
                      10.heightBox,

                      // Edit Profile Button
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.to(() => editpofileScreen(
                            username: controller.snapshotData['vendor_name'],
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      20.heightBox,

                      // Logout Button
                      ElevatedButton.icon(
                        onPressed: () async {
                          await Get.put(Authcontroller()).signoutMethod(context);
                          Get.delete<ProfileController>();
                          VxToast.show(context, msg: "Logout Successfully");
                          Get.offAll(() => LoginScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout", style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
