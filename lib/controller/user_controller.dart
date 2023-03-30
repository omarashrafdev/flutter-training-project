import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../model/user_model.dart';

class UserController extends RxController {
  RxString email = ''.obs;
  RxString name = ''.obs;
  RxString phone = ''.obs;
  var city = ''.obs;
  RxMap<String, dynamic> data = <String, dynamic>{}.obs;

  login(String localEmail) {
    email = localEmail.obs;
  }

  register(
      {required String localEmail,
      required String localName,
      required String localPhone}) {
    email = localEmail.obs;
    name = localName.obs;
    phone = localPhone.obs;
  }

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   ).then((value){
  //     print(value.user?.email);
  //     print(value.user?.uid);
  //   }).catchError((error){
  //   });
  // }

  // void userRegister({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String password,
  // }) {
  //   print('firebase');
  //   FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   )
  //       .then((value) {
  //     print(value.user?.email);
  //     print(value.user?.uid);
  //     userCreateInDatabase(
  //       uId:value.user!.uid,
  //       email: email,
  //       phone: phone,
  //       name: name,
  //     );
  //   }).catchError((error) {
  //   });
  // }
  // UserModel? userModel;
  // RxList list= [].obs ;
  // void getModel(){
  //   List<UserModel> data2=[];
  //   list=data2.obs;
  // }

  // Future<void> userCreateInDatabase ({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String uId,
  // }) async {
  //   UserModel model =  UserModel(
  //     email: email,
  //     phone: phone,
  //     name: name,
  //     uId: uId,
  //   ).obs.value;
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uId)
  //       .set(model.toMap())
  //       .then((value) {

  //   }).catchError((error) {
  //   });
  // }

  getCity(String city) {
    this.city = city.obs;
  }
}
