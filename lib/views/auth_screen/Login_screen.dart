import 'package:bluxkart_seller/views/common/bg_widget.dart';
import 'package:bluxkart_seller/views/common/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../Controllers/authcontroller.dart';
import '../../constants/consts.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Authcontroller());

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                SizedBox(height: context.screenHeight * 0.08),


                Center(
                  child: SizedBox(
                    height: 150,
                    child: Image.asset(
                      "assets/icons/Main_logo-removebg-preview.png",
                    ).scale200(),
                  ),
                ),

                const SizedBox(height: 30),

                Obx(() => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: emailHint,
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: passwordHint,
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                      ),

                      const SizedBox(height: 25),

                      controller.isloading.value
                          ? loadingIndicator()
                          : SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color.orange,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            controller.isloading(true);
                            String email = controller.emailController.text.trim();
                            String password = controller.passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              VxToast.show(context, msg: "Please enter email and password.");
                              controller.isloading(false);
                              return;
                            }

                            await controller
                                .loginMethod(email: email, password: password, context: context)
                                .then((value) {
                              if (value != null) {
                                Get.offAll(() => const Home());
                              }
                              controller.isloading(false);
                            });
                          },
                          child: const Text("Login", style: TextStyle(fontSize: 16)),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Forgot Password?"),
                        ),
                      ),
                    ],
                  ),
                )),

                const SizedBox(height: 20),

                "In case of any difficulty, contact admin"
                    .text
                    .gray300
                    .semiBold
                    .size(14)
                    .makeCentered(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
