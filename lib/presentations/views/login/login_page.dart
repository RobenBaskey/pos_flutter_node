import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/core/constants/app_sizes.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/theme_controller.dart';
import 'package:pos/presentations/controller/login_controller.dart';
import 'package:pos/presentations/routes/app_routes.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';
import 'package:pos/presentations/widgets/glass_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  ThemeController get theme => Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => TextButton.icon(
          onPressed: theme.toggleTheme,
          label: Text(theme.isDarkMode.value ? "Light" : "Dark"),
          icon: Icon(Icons.dark_mode),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getHeight(90), width: double.infinity),
            Text(
              "POSTrack",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
            ),
            Text("Your Point of Sale Solution", style: TextStyle(height: 1)),
            SizedBox(height: getHeight(70)),
            SizedBox(
              width: 540,
              child: GlassWidget(
                padding: 24,
                child: Obx(
                  () => controller.isLoginActive.value
                      ? _loginWidget(context)
                      : _regisWidget(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _loginWidget(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        Text("Sign in to access all your content."),
        SizedBox(height: getHeight(30)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email Address",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            CustomTextField(
              borderColor: Theme.of(context).colorScheme.outline,
              borderRadius: 8,
              hintText: "admin@example.com",
              suffixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
            ),
            SizedBox(height: getHeight(20)),
            Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            CustomTextField(
              borderColor: Theme.of(context).colorScheme.outline,
              borderRadius: 8,
              hintText: "******",
              suffixIcon: Icon(Icons.visibility, color: AppColors.primary),
            ),

            SizedBox(height: 30),
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.mainShell);
              },
              title: "Sign In",
              borderRadius: 8,
            ),
            SizedBox(height: 20),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.labelSmall?.color,
                  ),
                  children: [
                    TextSpan(text: "Don't have an account?  "),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.isLoginActive(false);
                        },
                      text: "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _regisWidget(BuildContext context) {
    return Column(
      children: [
        Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        Text("Create account to explore inside."),
        SizedBox(height: getHeight(30)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full Name", style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            CustomTextField(
              borderColor: Theme.of(context).colorScheme.outline,
              borderRadius: 8,
              hintText: "John Doe",
              suffixIcon: Icon(Icons.person, color: AppColors.primary),
            ),
            SizedBox(height: getHeight(20)),
            Text(
              "Email Address",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            CustomTextField(
              borderColor: Theme.of(context).colorScheme.outline,
              borderRadius: 8,
              hintText: "admin@example.com",
              suffixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
            ),
            SizedBox(height: getHeight(20)),
            Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            CustomTextField(
              borderColor: Theme.of(context).colorScheme.outline,
              borderRadius: 8,
              hintText: "******",
              suffixIcon: Icon(Icons.visibility, color: AppColors.primary),
            ),
            SizedBox(height: getHeight(20)),
            Text(
              "Confirm Password",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            CustomTextField(
              borderColor: Theme.of(context).colorScheme.outline,
              borderRadius: 8,
              hintText: "******",
              suffixIcon: Icon(Icons.visibility, color: AppColors.primary),
            ),

            SizedBox(height: 30),
            CustomButton(onTap: () {}, title: "Sign Up", borderRadius: 8),
            SizedBox(height: 20),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.labelSmall?.color,
                  ),
                  children: [
                    TextSpan(text: "Already have an account?  "),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.isLoginActive(true);
                        },
                      text: "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
