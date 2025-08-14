
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class PhoneLoginSheet extends StatefulWidget {
  const PhoneLoginSheet({super.key});
  @override
  State<PhoneLoginSheet> createState() => _PhoneLoginSheetState();
}

class _PhoneLoginSheetState extends State<PhoneLoginSheet> {
  final phoneCtrl = TextEditingController();
  final codeCtrl = TextEditingController();
  String? verificationId;
  bool sent = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();
    return Padding(
      padding: EdgeInsets.only(left:16,right:16,top:16,bottom:16 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!sent) ...[
            TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone number (+1...)')),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                setState(() { error = null; });
                try {
                  await auth.verifyPhone(phoneCtrl.text.trim(), onCodeSent: (vid, _) {
                    setState(() { verificationId = vid; sent = true; });
                  });
                } catch (e) { setState(() => error = e.toString()); }
              },
              child: const Text('Send code'),
            ),
          ] else ...[
            TextField(controller: codeCtrl, decoration: const InputDecoration(labelText: 'SMS code')),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                try { await auth.signInWithSmsCode(verificationId!, codeCtrl.text.trim()); if (mounted) Navigator.pop(context); }
                catch (e) { setState(() => error = e.toString()); }
              },
              child: const Text('Verify & Sign in'),
            ),
          ],
          if (error != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(error!, style: const TextStyle(color: Colors.red)))
        ],
      ),
    );
  }
}
