import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final _firestoreLeaderboard = Firestore.instance.collection('Leaderboard');
String name;
String email;
String imageUrl;
String uid;

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
  assert(firebaseuser.uid != null);

  name = firebaseuser.displayName;
  email = firebaseuser.email;
  imageUrl = firebaseuser.photoUrl;
  uid = firebaseuser.uid;

/* Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }*/

  User user = User();
  user.name = name;
  user.email = email;
  user.imageURL = imageUrl;
  user.uid = uid;

  SharedPreferenceHelper.setBooleanValue(Constants.USER_IS_LOGGED_IN, true);
  SharedPreferenceHelper.setStringValue(Constants.USER_OBJECT, user);
  final userDoc = _firestoreLeaderboard.document(uid);
  userDoc.get().then((docsnapshot) => {
        if (docsnapshot.exists)
          {print('Snapshot exists with docID 123')}
        else
          {
            print('No existance of doc with docID 123'),
            _firestoreLeaderboard.document(uid.toString()).setData({
              'name': name,
              'email': email,
              'total_point': 0,
              'uid': uid
            })
          }
      });

  return 'signInWithGoogle succeeded: $firebaseuser';
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  SharedPreferenceHelper.clearPreferences();

  print("User Sign Out");
}
