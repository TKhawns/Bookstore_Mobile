// ignore_for_file: non_constant_identifier_names

class ResponeData {
//   {
//     "requestId": "1699935121635000",
//     "errorCode": 0,
//     "orderId": "1699935121635000",
//     "message": "Success",
//     "localMessage": "Thành công",
//     "requestType": "captureMoMoWallet",
//     "payUrl": "https://test-payment.momo.vn/v2/gateway/pay?t=TU9NT3wxNjk5OTM1MTIxNjM1MDAw&s=6bb1c09328b40e3d8819182ef562a929072f1762f75561277da8d19df47d8b0a",
//     "signature": "34467fb8d8b155b819e6d8b24941b768d1fd6985d2c95c306be3c208cb1a2451",
//     "qrCodeUrl": "momo://app?action=payWithApp&isScanQR=true&serviceType=qr&sid=TU9NT3wxNjk5OTM1MTIxNjM1MDAw&v=2.3",
//     "deeplink": "momo://app?action=payWithApp&isScanQR=false&serviceType=app&sid=TU9NT3wxNjk5OTM1MTIxNjM1MDAw&v=2.3",
//     "deeplinkWebInApp": "https://test-payment.momo.vn/gw_payment/waiting//momo//?type=webinapp&action=payment&requestId=1699935121635000&billId=1699935121635000&partnerCode=MOMO&partnerName=MoMo Payment&amount=15000&description=Payment Book&notifyUrl=localhost:8080/home&returnUrl=localhost:8080/home&code=momo&extraData=eyJzaWduYXR1cmUiOiIwMjdjMGNmZTBmNzBlNDNjZjEyMzQ5NDczZDk0OWYzNjMwMzYwM2Y2ZmNlZjhiZGYyZThmNDdjMjMzYjQ4OGVkIn0=&signature=027c0cfe0f70e43cf12349473d949f36303603f6fcef8bdf2e8f47c233b488ed"
// }
  String requestId;
  int errorCode;
  String orderId;
  String message;
  String localMessage;
  String requestType;
  String payUrl;
  String signature;
  String qrCodeUrl;
  String deeplink;
  String deeplinkWebInApp;

  ResponeData({
    required this.requestId,
    required this.errorCode,
    required this.orderId,
    required this.message,
    required this.localMessage,
    required this.requestType,
    required this.payUrl,
    required this.signature,
    required this.qrCodeUrl,
    required this.deeplink,
    required this.deeplinkWebInApp,
  });

  factory ResponeData.fromJson(Map<String, dynamic> map) {
    return ResponeData(
        requestId: map['requestId'],
        errorCode: map['errorCode'],
        orderId: map['orderId'],
        message: map['message'],
        localMessage: map['localMessage'],
        requestType: map['requestType'],
        payUrl: map['payUrl'],
        signature: map['signature'],
        qrCodeUrl: map['qrCodeUrl'],
        deeplink: map['deeplink'],
        deeplinkWebInApp: map['deeplinkWebInApp']);
  }
}
