import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GoogleSignIn.instance.initialize(
    serverClientId:
        '338811456599-ekb7nrr2oojbq3fqecbg56v5m68s4nhb.apps.googleusercontent.com',
  );
  runApp(const App());
}
