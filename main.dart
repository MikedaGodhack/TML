
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'src/services/auth_service.dart';
import 'src/ui/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TMLApp());
}

class TMLApp extends StatelessWidget {
  const TMLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ ChangeNotifierProvider(create: (_) => AuthService()..init()) ],
      child: MaterialApp(
        title: 'Track My Love',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          useMaterial3: true,
        ),
        home: const AuthGate(),
      ),
    );
  }
}
