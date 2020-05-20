import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser firebaseuser = authResult.user;

  assert(firebaseuser.email != null);
  assert(firebaseuser.displayName != null);
  assert(firebaseuser.photoUrl != null);

  name = firebaseuser.displayName;
  email = firebaseuser.email;
  imageUrl = firebaseuser.photoUrl;

/* Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }*/

  User user = User();
  user.name = name;
  user.email = email;
  user.imageURL = imageUrl;

  SharedPreferenceHelper.setBooleanValue(Constants.USER_IS_LOGGED_IN, true);
  SharedPreferenceHelper.setStringValue(Constants.USER_OBJECT, user);
  return 'signInWithGoogle succeeded: $firebaseuser';
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  SharedPreferenceHelper.clearPreferences();

  print("User Sign Out");
}
