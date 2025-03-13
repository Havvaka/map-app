import 'package:flutter/material.dart';
import 'package:map_app/screens/map_screen.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2 saniye bekleyip ardından başka bir ekrana geçiş yap
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MapScreen(), // NextScreen yerine geçmek istediğiniz ekranı yazın
        ),
      );
    });

    return Scaffold(
       backgroundColor: Color(0xFFc4d1d7),
      body: Center(
       
        child: Image.asset('assets/wait.jpeg'), // Resmi göster
      ),
    );
  }
}

