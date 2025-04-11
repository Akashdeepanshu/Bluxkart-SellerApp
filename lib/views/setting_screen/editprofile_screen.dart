import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bluxkart_seller/views/common/bg_widget.dart';
import '../../Controllers/profileController.dart';
import '../../constants/consts.dart';

class editpofileScreen extends StatefulWidget {
  final String? username;
  const editpofileScreen({super.key, this.username});

  @override
  State<editpofileScreen> createState() => _editpofileScreenState();
}

class _editpofileScreenState extends State<editpofileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    controller.namecontroller.text = widget.username!;
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Name Field
              TextField(
                controller: controller.namecontroller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password Field
              TextField(
                controller: controller.passwordcontroller,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "New Password",
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Confirm Password Field
              TextField(
                controller: controller.confirmpasswordcontroller,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              controller.isloading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Row(
                children: [
                  // Save Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.namecontroller.text.isEmpty) {
                          VxToast.show(context,
                              msg: "Name cannot be empty");
                          return;
                        }

                        if (controller.passwordcontroller.text !=
                            controller
                                .confirmpasswordcontroller.text) {
                          VxToast.show(context,
                              msg: "Passwords do not match");
                          return;
                        }

                        controller.isloading(true);

                        if (controller.snapshotData['password'] !=
                            controller.passwordcontroller.text) {
                          await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password:
                            controller.snapshotData['password'],
                            newpassword:
                            controller.passwordcontroller.text,
                          );
                        }

                        await controller.updateProfile(
                          name: controller.namecontroller.text,
                          password: controller.passwordcontroller.text,
                        );

                        controller.isloading(false);
                        VxToast.show(context,
                            msg: "Profile Updated");
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Save"),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: OutlinedButton.styleFrom(
                        side:
                        const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
