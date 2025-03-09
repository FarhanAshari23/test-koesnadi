import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/auth/signin_user_req.dart';
import '../../model/auth/user_creation_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signin(SignInUserReq signinUserReq);
  Future<Either> signUp(UserCreationReq user);
  Future<Either> editUser(UserCreationReq updateUserReq);
  Future<Either> logout();
  Future<Either> getUser();
  Future<bool> isLoggedIn();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right("Logout Succes");
    } on FirebaseAuthException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> signUp(UserCreationReq user) async {
    try {
      var returnedData =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      await FirebaseFirestore.instance
          .collection('User')
          .doc(returnedData.user!.uid)
          .set(
        {
          'email': user.email,
          'name': user.name,
          'birth_date': user.birthDate,
          'gender': user.gender,
          'favorite': user.favorite,
        },
      );
      await FirebaseFirestore.instance
          .collection('User')
          .doc(returnedData.user!.uid)
          .collection('Notes')
          .add(
        {
          'title': 'Lets create a notes now!',
          'content':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          "created at": Timestamp.now(),
        },
      );

      return const Right('Signup was succesfull');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == "weak-password") {
        message = "Your password is to weak";
      } else if (e.code == 'email-already-in-use') {
        message = "This email already used";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signin(SignInUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email!,
        password: signinUserReq.password!,
      );

      return const Right('Succes Login');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'The user not found for that email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      var userData = await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser?.uid)
          .get()
          .then((value) => value.data());
      return Right(userData);
    } catch (e) {
      return left('An Error Occured');
    }
  }

  @override
  Future<Either> editUser(UserCreationReq updateUserReq) async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser?.uid)
          .update({
        'name': updateUserReq.name,
        'birth_date': updateUserReq.birthDate,
        "favorite": updateUserReq.favorite,
        "gender": updateUserReq.gender,
      });
      return const Right('Update Data User Success');
    } catch (e) {
      return const Left('Something Wrong');
    }
  }
}
