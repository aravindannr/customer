import 'dart:convert';

CustomerModal customerModalFromJson(String str) =>
    CustomerModal.fromJson(json.decode(str));

String customerModalToJson(CustomerModal data) => json.encode(data.toJson());

class CustomerModal {
  String phNo;
  String uId;
  String cEmail;
  List<String> assignedDesigner;
  String cName;
  int nId;
  String pushToken;

  CustomerModal({
    required this.phNo,
    required this.uId,
    required this.cEmail,
    required this.assignedDesigner,
    required this.cName,
    required this.nId,
    required this.pushToken,
  });

  factory CustomerModal.fromJson(Map<String, dynamic> json) => CustomerModal(
      phNo: json["phNo"] ?? '',
      uId: json["uId"] ?? '',
      cEmail: json["cEmail"] ?? '',
      assignedDesigner: List<String>.from(json['assignedDesigner'] ?? []),
      cName: json['cName'] ?? '',
      nId: json['nId'] ?? 0,
      pushToken: json['pushToken'] ?? '');

  Map<String, dynamic> toJson() => {
        "phNo": phNo,
        "uId": uId,
        "cEmail": cEmail,
        "assignedDesigner": assignedDesigner,
        "cName": cName,
        "nId": nId,
        "pushToken": pushToken
      };
}
