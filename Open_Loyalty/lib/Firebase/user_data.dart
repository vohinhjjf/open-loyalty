import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String id;
  String name;
  String sex;
  String birthday;
  String nationality;
  String cmd;
  String phone;
  String email;
  String loyaltyCardNumber;
  String location;

  UserData({
    required this.id,
    required this.name,
    required this.sex,
    required this.birthday,
    required this.nationality,
    required this.cmd,
    required this.phone,
    required this.email,
    required this.loyaltyCardNumber,
    required this.location,
  });

  Future<UserData?> getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = await collection.doc(user?.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      // You can then retrieve the value from the Map like this:

      UserData userData = new UserData(id: '', name: '', phone: '', email: '', birthday: '', sex: '', location: '', cmd: '', nationality: '', loyaltyCardNumber: '');
      userData.id = data['id'];
      userData.name = data['name'];
      userData.sex = data['sex'];
      userData.birthday = data['birthday'];
      userData.nationality = data['nationality'];
      userData.cmd = data['cmd'];
      userData.phone = data['number'];
      userData.email = data['email'];
      userData.loyaltyCardNumber = data['loyaltyCardNumber'];
      userData.location = data['location'];
      return userData;
    }
  }
}

