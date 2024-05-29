import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tes/firebase_options.dart';
import 'package:tes/pustaka.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Fungsi utama yang akan dijalankan pertama kali saat aplikasi dimulai
Future<void> main() async {
  // Menginisialisasi binding agar bisa menjalankan kode asinkron sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Menginisialisasi Firebase dengan konfigurasi platform saat ini
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Menjalankan aplikasi Flutter
  runApp(const MyApp());
}

// Definisi widget utama aplikasi
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // Menggunakan StatefulWidget sehingga kita bisa menggunakan state untuk menyimpan data
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Future yang akan digunakan untuk mendapatkan status tampilan layar
  late Future<Map<String, bool>> _initScreens;

  @override
  void initState() {
    super.initState();
    // Memulai proses asinkron untuk mendapatkan status tampilan layar saat inisialisasi state
    _initScreens = _getInitScreens();
  }

  // Fungsi untuk mendapatkan status tampilan layar dari SharedPreferences
  Future<Map<String, bool>> _getInitScreens() async {
    // Mendapatkan instance SharedPreferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Mengambil status apakah splash screen, onboarding, dan login telah ditampilkan
    bool splashScreenShown = preferences.getBool('splashScreenShown') ?? false;
    bool onboardingShown = preferences.getBool('onboardingShown') ?? false;
    bool loginShown = preferences.getBool('loginShown') ?? false;

    // Menyimpan status bahwa splash screen telah ditampilkan
    await preferences.setBool('splashScreenShown', true);

    // Mengembalikan hasil dalam bentuk map
    return {
      'splashScreenShown': splashScreenShown,
      'onboardingShown': onboardingShown,
      'loginShown': loginShown,
    };
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan FutureBuilder untuk membangun UI berdasarkan hasil dari _initScreens
    return FutureBuilder<Map<String, bool>>(
      future: _initScreens,
      builder: (context, snapshot) {
        // Menampilkan indikator loading selama proses mendapatkan data belum selesai
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Image.asset('assets/logoku.png'),
          );
        } else if (snapshot.hasError) {
          // Menangani error dengan menampilkan pesan error di UI
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ),
          );
        } else {
          // Jika data sudah berhasil didapatkan
          Map<String, bool> initScreens = snapshot.data!;
          bool splashScreenShown = initScreens['splashScreenShown']!;
          bool onboardingShown = initScreens['onboardingShown']!;
          bool loginShown = initScreens['loginShown']!;

          // Menentukan rute awal aplikasi berdasarkan status tampilan layar
          String initialRoute;
          if (!splashScreenShown) {
            initialRoute = 'splashscreen';
          } else if (!onboardingShown) {
            initialRoute = 'onboarding';
          } else if (!loginShown) {
            initialRoute = 'login';
          } else {
            initialRoute = 'bottomnavbar';
          }
          // Mengembalikan MaterialApp dengan rute yang sesuai
          return MaterialApp(
            initialRoute: initialRoute,
            routes: {
              'bottomnavbar': (context) => const BottomNavBar(),
              'splashscreen': (context) => const SplashScreen(),
              'onboarding': (context) => const OnboardingScreen(),
              'login': (context) => const LoginScreen(),
            },
          );
        }
      },
    );
  }
}
