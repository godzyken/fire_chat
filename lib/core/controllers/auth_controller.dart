import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/localizations.dart';
import 'package:fire_chat/main.dart';
import 'package:fire_chat/ui/components/components.dart';
import 'package:fire_chat/ui/pages/pages.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  //Variables Observers
  AppLocalizations_Labels labels;
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final interestController = TextEditingController().obs;

  final FacebookLogin plugin = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final TwitterLogin _twitterLogin = TwitterLogin(
      apiKey: TwitterApi.apiKey,
      apiSecretKey: TwitterApi.secret,
      redirectURI: TwitterApi.redirecTo);

  //Variables stream logic for
  Rx<User> firebaseUser = Rx<User>();
  Rx<UserModel> firestoreUser = Rx<UserModel>();
  final RxBool admin = false.obs;

  String _sdkVersion;
  FacebookAccessToken _token;
  FacebookUserProfile _profile;
  String _email;
  String _imageUrl;

  // Firebase user a realtime stream
  Stream<User> get user => FirebaseAuth.instance.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    if (firebaseUser?.value?.uid != null) {
      print(firebaseUser.value.uid);
      return FirebaseFirestore.instance
          .doc('/users/${firebaseUser.value.uid}')
          .snapshots()
          .map((snapshot) => UserModel.fromJson(snapshot.data()));
    }

    return null;
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
      await isAdmin();
    }

    if (_firebaseUser == null) {
      Get.to(() => SignInUI());
    } else {
      Get.to(() => HomeUI(tabIndex: null,));
    }
  }

  //Method to handle user sign in using email and password
  signInWithEmailAndPassword(BuildContext context) async {
    final labels = AppLocalizations.of(context);
    showLoadingIndicator();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.value.text.trim(),
          password: passwordController.value.text.trim());
      emailController.value.clear();
      passwordController.value.clear();
      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(labels.auth.signInErrorTitle, labels.auth.signInError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  // User registration using email and password
  registerWithEmailAndPassword(BuildContext context) async {
    final labels = AppLocalizations.of(context);
    showLoadingIndicator();
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text)
          .then((result) async {
        print('uID: ' + result.user.uid);
        print('email: ' + result.user.email);
        //get photo url from gravatar if user has one
        Gravatar gravatar = Gravatar(emailController.value.text);
        String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );
        //create the new user object
        UserModel _newUser = UserModel(
          uid: result.user.uid,
          email: result.user.email,
          name: nameController.value.text,
          createdAt: DateTime.now(),
          photoUrl: gravatarUrl,
        );
        //create the user in firestore
        _createUserFirestore(_newUser, result.user);

        await StreamUserApi.createUser(
            uid: result.user.uid,
            username: result.user.displayName,
            urlImage: result.user.photoURL);

        final resultA = await StreamUserApi.login(uid: result.user.uid);

        print('login id streamChat $resultA');


        emailController.value.clear();
        passwordController.value.clear();
        hideLoadingIndicator();
      });
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(labels.auth.signUpErrorTitle, error.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  //check if user is an admin user
  isAdmin() async {
    await getUser.then((user) async {
      DocumentSnapshot adminRef = await FirebaseFirestore.instance
          .collection('admin')
          .doc(user.uid)
          .get();
      if (adminRef.exists) {
        admin.value = true;
      } else {
        admin.value = false;
      }
      update();
    });
  }

  //Method to handle user sign in using google_sign_in
  googleSignIn(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final labels = AppLocalizations.of(context);
    showLoadingIndicator();

    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      await _auth.signInWithCredential(credential).then((result) async {

        //get photo url from gravatar if user has one
        Gravatar gravatar = Gravatar(result.user.photoURL);
        String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );

        //create the new user object
        UserModel _newUser = UserModel(
          uid: result.user.uid,
          email: result.user.email,
          name: result.user.displayName,
          createdAt: DateTime.now(),
          photoUrl: gravatarUrl,
        );
        //create the user in firestore
        _createUserFirestore(_newUser, result.user);

        await StreamUserApi.createUser(
            uid: result.user.uid,
            username: result.user.displayName,
            urlImage: result.user.photoURL);

        final resultA = await StreamUserApi.login(uid: result.user.displayName);

        print('Google create token : $resultA');


        update();

        hideLoadingIndicator();
      });
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(labels.auth.signInErrorTitle, labels.auth.signInError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  //Method to handle user sign in using facebook_sign_in
  facebookSignIn(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final labels = AppLocalizations.of(context);
    bool isExpress;

    showLoadingIndicator();

    try {
      if (isExpress != false) {
        await to.plugin.logIn(permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email
        ]).then((result) async {
          await _auth
              .signInWithCredential(
                  FacebookAuthProvider.credential(result.accessToken.token))
              .then((result) async {

            //get photo url from gravatar if user has one
            Gravatar gravatar = Gravatar(result.user.photoURL);
            String gravatarUrl = gravatar.imageUrl(
              size: 200,
              defaultImage: GravatarImage.retro,
              rating: GravatarRating.pg,
              fileExtension: true,
            );

            UserModel _newUser = UserModel(
              uid: result.user.uid,
              email: result.user.email,
              name: result.user.displayName,
              createdAt: DateTime.now(),
              photoUrl: gravatarUrl,
            );
            _createUserFirestore(_newUser, result.user);

            await StreamUserApi.createUser(
                uid: result.user.uid,
                username: result.user.displayName,
                urlImage: result.user.photoURL).then((value) => StreamUserApi.login(uid: value));

            final resultA = await StreamUserApi.login(uid: result.user.uid);

            print('facebook create token : $resultA');

            update();

            hideLoadingIndicator();
          });
        });
        await _updateUserFbInfo();
      } else {
        final res = await to.plugin.expressLogin();
        if (res.status == FacebookLoginStatus.success) {
          await _updateUserFbInfo();
        } else {
          hideLoadingIndicator();
          Get.snackbar("Can't make express log in. Try regular log in.",
              labels.auth.signInError,
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 7),
              backgroundColor: Get.theme.snackBarTheme.backgroundColor,
              colorText: Get.theme.snackBarTheme.actionTextColor);
        }
      }
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(labels.auth.signInErrorTitle, labels.auth.signInError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  //Method to handle user sign in using Twitter_login
  twitterSignIn(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final labels = AppLocalizations.of(context);
    showLoadingIndicator();

    try {
      final AuthResult authResult = await _twitterLogin.login();
      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          final AuthCredential credential = TwitterAuthProvider.credential(
              accessToken: authResult.authToken,
              secret: authResult.authTokenSecret);

          await _auth.signInWithCredential(credential).then((result) async {

            //get photo url from gravatar if user has one
            Gravatar gravatar = Gravatar(result.user.photoURL);
            String gravatarUrl = gravatar.imageUrl(
              size: 200,
              defaultImage: GravatarImage.retro,
              rating: GravatarRating.pg,
              fileExtension: true,
            );

            //create the new user object
            UserModel _newUser = UserModel(
              uid: result.user.uid,
              email: result.user.email,
              name: result.user.displayName,
              createdAt: DateTime.now(),
              photoUrl: gravatarUrl,
            );
            //create the user in firestore
            _createUserFirestore(_newUser, result.user);

            await StreamUserApi.createUser(
                uid: result.user.uid,
                username: result.user.displayName,
                urlImage: result.user.photoURL);

            await StreamUserApi.login(uid: result.user.uid);


            update();

            hideLoadingIndicator();
          });
          break;
        case TwitterLoginStatus.cancelledByUser:
          // cancel
          print(authResult.status);
          break;
        case TwitterLoginStatus.error:
          // error
          print(authResult.status);

          break;
      }
    } catch (e) {}
  }

  // Get PhotoUrl for Profile avatar
  getPhotoUrl() {
    final _auth = FirebaseAuth.instance;

    if (_auth.currentUser.photoURL != null) {
      return Image.network(_auth.currentUser.photoURL, height: 100, width: 100);
    } else {
      return Icon(Icons.account_circle, size: 100);
    }
  }

  //Method to update facebook user info
  Future<void> _updateUserFbInfo() async {
    final plugin = to.plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile profile;
    String email;
    String imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions?.contains(FacebookPermission.email.name) ?? false) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }

    _token = token;
    _profile = profile;
    _email = email;
    _imageUrl = imageUrl;

    final UserModel userModel = UserModel(
      uid: _profile?.userId,
      email: _email,
      name: _profile?.name,
      photoUrl: _imageUrl,
      createdAt: DateTime.now(),
    );
    _createUserFirestore(userModel, firebaseUser.value);

    await StreamUserApi.createUser(
        uid: firebaseUser?.value?.uid,
        username: firebaseUser?.value?.displayName,
        urlImage: firebaseUser?.value?.photoURL);

  }

  // Firebase user one-time fetch
  Future<User> get getUser async {
    return FirebaseAuth.instance.currentUser;
  }

  //handles updating the user when updating profile
  Future<void> updateUser(BuildContext context, UserModel user, String oldEmail,
      String password) async {
    final labels = AppLocalizations.of(context);
    try {
      showLoadingIndicator();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: oldEmail, password: password)
          .then((_firebaseUser) {
        _firebaseUser.user
            .updateEmail(user.email)
            .then((value) => _updateUserFirestore(user, _firebaseUser.user));
      });
      hideLoadingIndicator();
      Get.snackbar(labels.auth.updateUserSuccessNoticeTitle,
          labels.auth.updateUserSuccessNotice,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } on PlatformException catch (error) {

      hideLoadingIndicator();
      print(error.code);
      String authError;
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD':
          authError = labels.auth.wrongPasswordNotice;
          break;
        default:
          authError = labels.auth.unknownError;
          break;
      }
      Get.snackbar(labels.auth.wrongPasswordNoticeTitle, authError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  //password reset email
  Future<void> sendPasswordResetEmail(BuildContext context) async {
    final labels = AppLocalizations.of(context);
    showLoadingIndicator();
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.value.text);
      hideLoadingIndicator();
      Get.snackbar(
          labels.auth.resetPasswordNoticeTitle, labels.auth.resetPasswordNotice,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
      update();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(labels.auth.resetPasswordFailed, error.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  // Google_sign_out
  Future<void> _googleSignOut() async {
    await _googleSignIn.signOut().then((value) => Get.offAll(() => SignUpUI()));
  }

  // Sign out
  Future<void> signOut() {
    nameController.value.clear();
    emailController.value.clear();
    passwordController.value.clear();
    _googleSignOut();
    plugin.logOut();
    return FirebaseAuth.instance.signOut();
  }

  //updates the firestore user in users collection
  void _updateUserFirestore(UserModel user, User _firebaseUser) {
    FirebaseFirestore.instance
        .doc('/users/${_firebaseUser.uid}')
        .update(user.toJson());
    update();
  }

  //create the firestore user in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    FirebaseFirestore.instance
        .doc('/users/${_firebaseUser?.uid}')
        .set(user.toJson());
    update();
  }

  @override
  void onReady() async {
    //run every time auth state changes
    _updateUserFbInfo();

    ever(firebaseUser, handleAuthChanged);

    firebaseUser.value = await getUser;
    firebaseUser.bindStream(user);
    super.onReady();
  }

  @override
  void onClose() {
    nameController.value?.dispose();
    emailController.value?.dispose();
    passwordController.value?.dispose();
    interestController.value?.dispose();
    super.onClose();
  }
}
