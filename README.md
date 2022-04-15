# Zalo eKYC Flutter Document

A Flutter SDK for Android and iOS allowing access to the service **Zalo eKYC**.
|             | Android | iOS     |
|-------------|---------|---------|
| **Support** | SDK 21+ | iOS 10+ |


## Open class

1. ZaloEKYC
2. ZeKYCCallback
3. ZeKYCConfig

## 1. ZaloEKYC Class

#### Function Initialize
```dart
Future<void> initialize(ZeKYCConfig) async
```
-   Create an instance of  class `ZaloEKYC` and validate the `ZeKYCConfig` field.
-   Throws a `Exception` if the initialization fails.

####  Function  GenerateSessionID

```dart
Future<String> generateSessionID() async
```

-  Generate session id
- Before using a  `generateSessionID` a call to `initialize` must complete.
-  Throws a `Exception` if the initialization fails.

####  Function StartEKYC

```dart
Future<void> startEKYC(BuildContext context, String mSession, ZeKYCCallback zeKYCCallback) async
```

-   Start full flow eKYC

> SelfieCheckInstruction -> SelfieCheck -> DocumentCheckInstruction-> FrontSideDocumentCheck -> [BackSideDocumentCheck] -> Finish.


####  Function StartLiveness

```dart
Future<void> startLiveness(BuildContext context, String mSession, ZeKYCCallback zeKYCCallback) async
```

-   Start flow selfie check

> SelfieCheckInstruction -> SelfieCheck.

####  Function StartOCR

```dart
Future<void> startOCR(BuildContext context, String mSession, ZeKYCCallback zeKYCCallback) async
```

-  Start flow document check

> DocumentCheckInstruction -> FrontSideDocumentCheck -> [BackSideDocumentCheck].

#### Function getFaceMatchingResult

```dart
Future<void> getFaceMatchingResult(String mSession, ZeKYCCallback zeKYCCallback) async{}
```

-  Get face matching result

####  Function getSocialCheckResult

```dart
Future<void> getSocialCheckResult(String mSession, ZeKYCCallback zeKYCCallback) async{}
```

-  Get social check result


## 2. ZeKYCCallback

The results of eKYC flow execution or other requests will be returned through this class.

####  Function onUserCancel
```dart
Function() onUserCancel
```
- Callback invoked when the user actively exits the ekyc flow.

####  Function onFinish
```dart
Function(String? jsonString) onFinish
```
- Callback invoked when the end of an ekyc process, the results of getFaceMatchingResult and getSocialCheckResult will be returned here.

####  Function onError
```dart
Function(ZeKYCStep step, String jsonString, {Uint8List? image}) onError
```
-	Callback for whenever the current step has error.
-	enum `ZeKYCStep step`: error step.
-	`String jsonString`:  error description.
-	`Uint8List? image`: error image.

####  Function onSuccess
```dart
Function(ZeKYCStep step, String jsonString, {Uint8List? image}) onSuccess
```
-	Callback invoked when completing a step.
-	enum `ZeKYCStep step`: completed.
-	`String jsonString`: json result.
-	`Uint8List? image`: result image.

## 3. ZeKYCConfig Class

#### Option field
-  `String` **apiKey**: (required): Zalo provides partners when integration.
-   `String` **privateKey**: (required): using to decrypt data return from API. Both Server and Client own their key pair: public key & private key.

> 	 - Public key: provide for the other side to encrypt data. 
> 	 - Private key: keep secretly to decrypt data


-   `List<String>` **iDType**:  (required): Type ID be used.
> - idcard
> - driver_license
> - passport

-  `Boolean` **enableFraudIDCheck** (Optional, default = `true`): Check fraud of the ID photo or not.
-  `Boolean` **enableLivenessCheck** (Optional, default = `true`): Check fraud selfie photo or not.
-  `Boolean` **enableSocialCheck** (Optional, default = `false`): Whether use social check feature or not.
-  `CameraType` **defaultCameraSideForID** (Optional): Type of camera used in OCR check.
>  -   front
>  -   back (default)

-  `CameraType` **defaultCameraSideForLiveness** (Enum, Optional): Type of camera used in selfie check.
>  -   front (default)
>  -   back
