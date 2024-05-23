import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference alumni =
      FirebaseFirestore.instance.collection('alumni');

  final CollectionReference stats =
      FirebaseFirestore.instance.collection('alumni_by_year');

  final CollectionReference empStats =
      FirebaseFirestore.instance.collection('employment_status');

  final CollectionReference degreeStats =
      FirebaseFirestore.instance.collection('degree_stats');

  Future addAlumnus(
    String email,
    String firstName,
    String lastName,
    String degree,
    int yearGraduated,
    String sex,
    bool employmentStatus,
    String middleName,
    String dateOfBirth,
    String occupation, {
    String? question_1,
    String? question_2,
    String? question_3,
    String? question_4,
    String? question_5,
    String? question_6,
  }) {
    setSearchParam(String firstName, String lastName) {
      String name = '$firstName $lastName';
      List<String> caseSearchList = [];
      String temp = '';

      for (int i = 0; i < name.length; i++) {
        temp += name[i];
        caseSearchList.add(temp.toLowerCase());
      }

      name = '$lastName $firstName';
      for (int i = 0; i < name.length; i++) {
        temp += name[i];
        caseSearchList.add(temp.toLowerCase());
      }

      return caseSearchList;
    }

    return alumni.add({
      'email': email,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'sex': sex,
      'degree': degree,
      'year_graduated': yearGraduated,
      'employment_status': employmentStatus,
      'occupation': occupation,
      'searchable_name': setSearchParam(firstName, lastName),
      'question_1': question_1,
      'question_2': question_2,
      'question_3': question_3,
      'question_4': question_4,
      'question_5': question_5,
      'question_6': question_6,
    });
  }

  Future updateResponse(
    String docID,
    String? question_1,
    String? question_2,
    String? question_3,
    String? question_4,
    String? question_5,
    String? question_6,
  ) {
    return alumni.doc(docID).update({
      'question_1': question_1,
      'question_2': question_2,
      'question_3': question_3,
      'question_4': question_4,
      'question_5': question_5,
      'question_6': question_6,
    });
  }
}
