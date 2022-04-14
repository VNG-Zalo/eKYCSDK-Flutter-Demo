import 'dart:typed_data';

import 'package:flutter/src/widgets/framework.dart';

class ZeKYCConfig{

  static ZeKYCConfig defaultConfig({required String apiKey, required String privateKey, required List<String> iDType}) {
    return ZeKYCConfig();
  }

}

class ZeKYCSDK{

  Future<void> initialize(ZeKYCConfig mainConfig) async{}

  Future<String> generateSessionID() async{
    return 'dummy string';
  }

  Future<void> startOCR(BuildContext context, String mSession, ZeKYCCallback zeKYCCallback) async{}

  Future<void> startEKYC(BuildContext context, String mSession, ZeKYCCallback zeKYCCallback) async{}

  Future<void> startLiveness(BuildContext context, String mSession, ZeKYCCallback zeKYCCallback) async{}

  Future<void> getFaceMatchingResult(String mSession, ZeKYCCallback zeKYCCallback) async{}

  Future<void> getSocialCheckResult(String mSession, ZeKYCCallback zeKYCCallback) async{}

  void setUserPhoneNumber(String s) {}

}

enum ZeKYCStep{
  selfie,
  frontDocument,
  backDocument,
  faceMatching,
  socialCheck
}

class ZeKYCCallback{
  late Function() onUserCancel;
  late Function(String? jsonString) onFinish;
  late Function(ZeKYCStep step, String jsonString, {Uint8List? image}) onError;
  late Function(ZeKYCStep step, String jsonString, {Uint8List? image}) onSuccess;

  ZeKYCCallback({
    required this.onUserCancel,
    required this.onFinish,
    required this.onError,
    required this.onSuccess
  });
}


