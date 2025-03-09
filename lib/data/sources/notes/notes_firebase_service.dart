import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_koesnadi/data/model/notes/notes.dart';
import 'package:test_koesnadi/domain/entities/notes/notes.dart';

abstract class NotesFirebaseService {
  Future<Either> getNotes();
  Future<Either> createNotes(NotesModel addNotesReq);
  Future<Either> deleteNotes(String uidNote);
  Future<Either> editNotes(NotesEntity updateNoteReq);
}

class NotesFirebaseServiceImpl extends NotesFirebaseService {
  @override
  Future<Either> getNotes() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance
          .collection("User")
          .doc(user!.uid)
          .collection('Notes')
          .get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left("Error get data, please try again later");
    }
  }

  @override
  Future<Either> createNotes(NotesModel addNotesReq) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      DocumentReference docref = await FirebaseFirestore.instance
          .collection('User')
          .doc(user!.uid)
          .collection('Notes')
          .add(addNotesReq.toMap());
      String code = docref.id;
      await docref.update({
        "code": code,
      });
      return const Right('Add note was successfully');
    } catch (e) {
      return const Left('Please try again.');
    }
  }

  @override
  Future<Either> deleteNotes(String uidNote) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      CollectionReference users = FirebaseFirestore.instance
          .collection('User')
          .doc(user!.uid)
          .collection('Notes');
      QuerySnapshot querySnapshot =
          await users.where('code', isEqualTo: uidNote).get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      return const Right('Delete Data News Success');
    } catch (e) {
      return const Left('Something Wrong');
    }
  }

  @override
  Future<Either> editNotes(NotesEntity updateNoteReq) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      CollectionReference users = FirebaseFirestore.instance
          .collection('User')
          .doc(user!.uid)
          .collection('Notes');
      QuerySnapshot querySnapshot =
          await users.where('code', isEqualTo: updateNoteReq.code).get();
      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs[0].id;
        await users.doc(docId).update({
          "content": updateNoteReq.content,
          "title": updateNoteReq.title,
        });
        return right('Update Data Notes Success');
      }
      return const Right('Update Data Notes Success');
    } catch (e) {
      return const Left('Something Wrong');
    }
  }
}
