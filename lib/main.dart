import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pocket/controllers/categorias_controller.dart';
import 'package:pocket/controllers/home_controller.dart';
import 'package:pocket/controllers/transacoes_controller.dart';
import 'package:pocket/data/database_helper.dart';
import 'package:pocket/views/home_page.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:pocket/controllers/home_controller.dart';
import 'package:pocket/data/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SQLite para Windows/Linux
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Inicializa o banco
  await DatabaseHelper.instance.database;

  // Inicializa controller
  Get.put(HomeController());
  Get.put(CategoriasController());
  Get.put(TransacoesController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pocket Finance',

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor: const Color(0xFFF7F9F8),

        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2E7D32),
          onPrimary: Colors.white,

          secondary: Color(0xFF1E88E5),
          onSecondary: Colors.white,

          error: Color(0xFFE53935),
          onError: Colors.white,

          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF263238),

          onSurfaceVariant: Color(0xFF78909C),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFFFF),
          foregroundColor: Color(0xFF263238),
          elevation: 0,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(
              color: Color(0xFFE0E0E0),
            ),
          ),
        ),
      ),

      home: const HomePage(),
    );
  }
}