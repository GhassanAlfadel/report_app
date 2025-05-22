import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:report_app/widgets/report_model.dart';
import 'package:intl/intl.dart';

class ReportProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _mainDoc = 'reports';

  List<ReportModel> _reports = [];

  List<ReportModel> get reports => _reports;

  // Stream<List<ReportModel>> fetchReports(String collection) {
  //   _reports = [];
  //   User? user = FirebaseAuth.instance.currentUser;
  //   String uid = user!.uid;
  //   print(uid);
  //   return _firestore
  //       .collection('reports')
  //       .doc(_mainDoc)
  //       .collection(collection)
  //       .snapshots()
  //       .map((snapshot) {
  //     for (var doc in snapshot.docs) {
  //       if (doc["userId"].toString() == uid) {
  //         reports.add(ReportModel.fromMap(doc.data()));
  //       }
  //     }
  //     return _reports;
  //   });
  // }
  Stream<List<ReportModel>> fetchReports(String collection) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user?.uid ?? '';

    return _firestore
        .collection('reports')
        .doc(_mainDoc)
        .collection(collection)
        .snapshots()
        .map((snapshot) {
      final List<ReportModel> reports = [];

      for (var doc in snapshot.docs) {
        if (doc["userId"].toString() == uid) {
          final report = ReportModel.fromMap(doc.data());
          reports.add(report);
        }
      }

      return reports.reversed.toList();
    });
  }

//  Stream <List<ReportModel>> fetchElectricReports(String collection, String devision) {
//     User? user = FirebaseAuth.instance.currentUser;
//     String uid = user!.uid;
//     print(uid);
//     _firestore
//         .collection('reports')
//         .doc(_mainDoc)
//         .collection(collection)
//         .snapshots()
//         .map((snapshot) => snapshot.docs.map((doc) {
//               if (doc["devision"].toString().isEmpty) {
//                 return;
//               } else if (doc["devision"].toString() == devision) {
//                 _reports.add(ReportModel.fromMap(doc as Map<String, dynamic>));
//               }
//             }));

//   }

  Stream<List<ReportModel>> fetchElectricReports(
      String collection, String devision) {
    _reports = [];
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    print(uid);

    return _firestore
        .collection('reports')
        .doc(_mainDoc)
        .collection(collection)
        .snapshots()
        .map((snapshot) {
      for (var doc in snapshot.docs) {
        if (doc["userId"].toString() == uid &&
            doc.data().containsKey("devision")) {
          if (doc["devision"].toString() == devision &&
              doc["devision"].toString().isNotEmpty) {
            reports.add(ReportModel.fromMap(doc.data()));
          }
        }
      }
      return _reports;
    });
  }

  Future<void> addReport(ReportModel report, String collection) async {
    try {
      final ref =
          _firestore.collection('reports').doc(_mainDoc).collection(collection);
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;

      await ref.add({
        "collection": collection,
        'name': report.name,
        'location': report.location,
        'status': report.status,
        "userId": uid,
        "devision": report.devison,
        "type": report.type,
        "time": formatTime(DateTime.parse(report.time))
      });
    } catch (e) {
      print('Error adding report: $e');
    }
  }

  // Future<void> removeReport(int index, String collection) async {
  //   try {
  //     if (index < _reportDocIds.length) {
  //       final ref = _firestore
  //           .collection('reports')
  //           .doc(_mainDoc)
  //           .collection(collection);

  //       await ref.doc(_reportDocIds[index]).delete();
  //       fetchReports(collection);
  //     }
  //   } catch (e) {
  //     print('Error removing report: $e');
  //   }
  // }

  String formatTime(DateTime time) {
    final formattedDate = DateFormat('d-MMMM-y', 'ar').format(time);

    const westernToArabicDigits = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    return formattedDate.split('').map((char) {
      return westernToArabicDigits[char] ?? char;
    }).join();
  }
}
