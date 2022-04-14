import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:zalo_ekyc/zalo_ekyc.dart';
import 'dummy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'eKYC SDK Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late ZeKYCConfig _zeKYCConfig;
  late ZeKYCCallback _zeKYCCallback;
  late ZeKYCSDK _zeKYCSDK;
  String _mSession = '';

  ///The API key associated with your account to authenticate requests.
  final String _apiKey = 'xxxxxxxxxxxxxxxx';

  /// The Private key is used to decrypt data from server.
  final String _privateKey = 'xxxxxxxxxxxxxx...xxxxxxxxxxxxxx';

  @override
  void initState() {
    super.initState();
    //Create eKYC config with default optional
    _zeKYCConfig = ZeKYCConfig.defaultConfig(
        apiKey: _apiKey, privateKey: _privateKey, iDType: ['idcard', 'driver_license', 'passport']);

    _zeKYCCallback = ZeKYCCallback(
      onUserCancel: () {
        // TODO: Handle this case.
      },
      onFinish: (jsonString) {
        // TODO: Handle this case.
      },
      onError: (step, jsonString, {image}) {
        switch (step) {
          case ZeKYCStep.selfie:
            // TODO: Handle this case.
            break;
          case ZeKYCStep.frontDocument:
            // TODO: Handle this case.
            break;
          case ZeKYCStep.backDocument:
            // TODO: Handle this case.
            break;
          case ZeKYCStep.faceMatching:
            // TODO: Handle this case.
            break;
          case ZeKYCStep.socialCheck:
            // TODO: Handle this case.
            break;
        }
      },
      onSuccess: (step, jsonString, {image}) {
        switch (step) {
          case ZeKYCStep.selfie:
            // TODO: Handle this case.
            break;
          case ZeKYCStep.frontDocument:
            // TODO: Handle this case.
            break;
          case ZeKYCStep.backDocument:
            // TODO: Handle this case.
            break;
          case ZeKYCStep.faceMatching:
            // TODO: Handle this case.
            break;
          case ZeKYCStep.socialCheck:
            // TODO: Handle this case.
            break;
        }
      },
    );
  }

  /// Create an instance of SDK and validate the config field.
  ///
  /// Throws a Exception if the initialization fails.
  Future<void> _initSDK() async {
    _zeKYCSDK = ZeKYCSDK();
    await _zeKYCSDK.initialize(_zeKYCConfig);
  }

  ///Generate session id
  ///
  ///Before using a [ZeKYCSDK.generateSessionID] a call to [ZeKYCSDK.initialize] must complete.
  void _generateSessionID() async{
    await _initSDK();
    _mSession = await _zeKYCSDK.generateSessionID();
  }

  ///Start full flow eKYC
  ///
  /// SelfieCheckInstruction -> SelfieCheck -> DocumentCheckInstruction
  /// -> FrontSideDocumentCheck -> [[BackSideDocumentCheck]] -> Finish.
  void _startFullFlowEKYC(){
    if (_mSession.isNotEmpty) {
      _zeKYCSDK.startEKYC(context, _mSession, _zeKYCCallback);
    }
  }

  ///Start flow document check
  ///
  ///DocumentCheckInstruction -> FrontSideDocumentCheck -> [[BackSideDocumentCheck]].
  void _startDocumentCheck(){
    if (_mSession.isNotEmpty) {
      _zeKYCSDK.startOCR(context, _mSession, _zeKYCCallback);
    }
  }

  ///Start flow selfie check
  ///
  ///SelfieCheckInstruction -> SelfieCheck.
  void _startSelfieCheck(){
    if (_mSession.isNotEmpty) {
      // _zeKYCSDK.setUserPhoneNumber("0123456789"); -> If use social check
      _zeKYCSDK.startLiveness(context, _mSession, _zeKYCCallback);
    }
  }

  ///Get face matching result
  void _getFaceMatchingResult(){
    if (_mSession.isNotEmpty) {
      _zeKYCSDK.getFaceMatchingResult(_mSession, _zeKYCCallback);
    }
  }

  ///Get social check result
  void _getSocialCheckResult(){
    if (_mSession.isNotEmpty) {
      _zeKYCSDK.getSocialCheckResult(_mSession, _zeKYCCallback);
    }
  }

  Widget optionButton(String buttonMessage, Function action){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: Theme.of(context).buttonTheme.height,
        child: OutlinedButton(
          onPressed: () => action,
          child: Text(buttonMessage),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              optionButton('Generate session', _generateSessionID),
              optionButton('Start full flow eKYC', _startFullFlowEKYC),
              optionButton('Start selfie check', _startSelfieCheck),
              optionButton('Start document check', _startDocumentCheck),
              optionButton('Get Face matching result', _getFaceMatchingResult),
              optionButton('Get Social Check result', _getSocialCheckResult),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
