import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservice {
  /*
 Utilizing the existing Firebase instance to ensure a single authentication object is used across the project, 
 preventing redundant instantiations and adhering to the Singleton pattern.
  */ 
  final _auth = FirebaseAuth.instance;

// to fix error clientID not set as we are running flutter web 
  final GoogleSignIn googleSignIn = GoogleSignIn(
// getting clientId from firebase => Authertication => SignInMethod =>Google => Web SDK confuguration 
    clientId: "534307538138-solkonkgc8k9aaislj08v1r0t9n749cf.apps.googleusercontent.com", 
  );

  Future<UserCredential?> SignInByGoogle() async {
    try {
      // to open google page for SignIn 
      final googleuser = await GoogleSignIn().signIn();
      // getting tokens 
      final googleauth = await googleuser?.authentication;
      // sending tokens to firebase to enter 
      final cred = await GoogleAuthProvider.credential(
          idToken: googleauth?.idToken, accessToken: googleauth?.accessToken);

      return await _auth.signInWithCredential(cred);
    } catch (e) {
      print(e.toString());
    }
    // if anything went wrong we ask function to return null 
    return null;
  }
}
