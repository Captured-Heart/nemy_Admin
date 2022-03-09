import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nemycraft_admin/Auth/auth_methods.dart';

class DataBaseService {
  final String? uid;
  final String? nameController;
  final String? emailController;
  final String? numberController;
  final String? addressController;
  final String? genderController;
  final String? dobController;

  DataBaseService(
      {this.nameController,
      this.emailController,
      this.numberController,
      this.addressController,
      this.genderController,
      this.dobController,
      this.uid});
  AuthMethods authMethods = AuthMethods();

  final CollectionReference userSchedule =
      FirebaseFirestore.instance.collection('Schedule');

//CREATE DATABASE FOR FORM DETAILS
  Future setUserDetails(userMap) async {
    final uuid = await authMethods.getCurrentUID();
    final DocumentReference userDetails = FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection('Profile')
        .doc();
    return await userDetails.set(userMap);
  }

  Future setAdsDetails(adsMap) async {
    final uuid = await authMethods.getCurrentUID();
    final DocumentReference userDetails =
        FirebaseFirestore.instance.collection(uuid).doc('Ads Details');
    return await userDetails.set(adsMap);
  }
  Future setContactUsDetails(contactMap) async {
    final uuid = await authMethods.getCurrentUID();
    final DocumentReference userDetails =
        FirebaseFirestore.instance.collection(uuid).doc('Contact Us Details');
    return await userDetails.set(contactMap);
  }
  Future setFollowUsDetails(followMap) async {
    final uuid = await authMethods.getCurrentUID();
    final DocumentReference userDetails =
        FirebaseFirestore.instance.collection(uuid).doc('Social Media Urls');
    return await userDetails.set(followMap);
  }
  Future leftAboutUs(leftAboutUsMap) async {
    final uuid = await authMethods.getCurrentUID();
    final DocumentReference userDetails =
        FirebaseFirestore.instance.collection(uuid).doc('Left About Details');
    return await userDetails.set(leftAboutUsMap);
  }
   Future rightAboutUs(rightAboutUsMap) async {
    final uuid = await authMethods.getCurrentUID();
    final DocumentReference userDetails =
        FirebaseFirestore.instance.collection(uuid).doc('Right About Details');
    return await userDetails.set(rightAboutUsMap);
  }

//CREATE UPDATE FOR FORM DETAILS
  // Future updateUserDetails(userMap, String path) async {
  //   final uuid = await authMethods.getCurrentUID();
  //   final DocumentReference userDetails = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uuid)
  //       .collection('Profile')
  //       .doc(path);

  //   return await userDetails.update(userMap);
  // }

  Future setSlidingImages(userMap) async {
    final uuid = await authMethods.getCurrentUID();
    final DocumentReference userDetails =
        FirebaseFirestore.instance.collection(uuid).doc('Sliding Images');

    return await userDetails.set(userMap);
  }

//CREATE DATABASE FOR SCHEDULE
  Future updateUserSchedule(scheduleMap) async {
    return await userSchedule.add(scheduleMap);
  }

//TRYING TO RETURN SAVED SCHEDULE FILES FROM DATABASE
  Future returnScheduleDetails(sMap) async {
    return await userSchedule.get();
  }
}
