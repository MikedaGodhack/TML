
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'phone_login_sheet.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();
    return Scaffold(
      appBar: AppBar(title: const Text('Track My Love - Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 12),
            if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loading ? null : () async {
                setState(() { loading = true; error = null; });
                try { await auth.signInWithEmail(emailCtrl.text.trim(), passCtrl.text.trim()); }
                catch (e) { setState(() => error = e.toString()); }
                finally { if (mounted) setState(() => loading = false); }
              },
              child: const Text('Sign in with Email'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
              child: const Text('Create an account'),
            ),
            const Divider(height: 32),
            ElevatedButton(
              onPressed: () async {
                try { await auth.signInWithGoogle(); } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google sign-in failed: $e')));
                }
              },
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () { showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) => const PhoneLoginSheet()); },
              child: const Text('Sign in with Phone'),
            ),
          ],
        ),
      ),
    );
  }
}
