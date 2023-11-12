import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/controllers/auth_controller.dart';
import 'app/core/theme/colors.dart';
import 'app/routes/app_pages.dart';
import 'app/views/views/loading_screen_view.dart';
import 'firebase_options.dart';

void main() async {
  // Initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController(), permanent: true);

  // Run digital menu app
  runApp(DigitalMenu());
}

class DigitalMenu extends StatelessWidget {
  DigitalMenu({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapAuth) {
        if (snapAuth.connectionState == ConnectionState.waiting) return const LoadingScreenView();

        return GetMaterialApp(
          theme: ThemeData(
            primaryColor: AppColors.primary,
            fontFamily: GoogleFonts.notoSans().fontFamily,
          ),
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: snapAuth.hasData ? Routes.DASHBOARD_ADMIN : Routes.HOME,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
