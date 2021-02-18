import 'dart:convert';

import 'package:intl/intl.dart';

CaseModel caseModelFromJson(String str) => CaseModel.fromJson(json.decode(str));

String caseModelToJson(CaseModel data) => json.encode(data.toJson());

class CaseModel {
  CaseModel({
    this.caseId,
    this.policyNumber,
    this.investigation,
    this.insuredName,
    this.insuredDod,
    this.insuredDob,
    this.sumAssured,
    this.intimationType,
    this.location,
    this.caseStatus,
    this.nomineeName,
    this.nomineeContactNumber,
    this.nomineeAddress,
    this.insuredAddress,
    this.caseDescription,
    this.longitude,
    this.latitude,
    this.pdf1FilePath,
    this.pdf2FilePath,
    this.pdf3FilePath,
    this.audioFilePath,
    this.videoFilePath,
    this.signatureFilePath,
    this.capturedDate,
    this.createdBy,
    this.createdDate,
    this.updatedDate,
    this.updatedBy,
  });

  int caseId;
  String policyNumber;
  Investigation investigation;
  String insuredName;
  DateTime insuredDod;
  DateTime insuredDob;
  double sumAssured;
  String intimationType;
  Location location;
  String caseStatus;
  String nomineeName;
  String nomineeContactNumber;
  String nomineeAddress;
  String insuredAddress;
  String caseDescription;
  String longitude;
  String latitude;
  String pdf1FilePath;
  String pdf2FilePath;
  String pdf3FilePath;
  String audioFilePath;
  String videoFilePath;
  String signatureFilePath;
  String capturedDate;
  String createdBy;
  DateTime createdDate;
  DateTime updatedDate;
  String updatedBy;

  factory CaseModel.fromJson(Map<String, dynamic> json) => CaseModel(
    caseId: json["caseId"],
    policyNumber: json["policyNumber"],
    investigation: Investigation.fromJson(json["investigation"]),
    insuredName: json["insuredName"],
    insuredDod: DateFormat('yyyy-MM-ddThh:mm:ss.000+00:00').parse(json["insuredDOD"]),
    insuredDob: DateFormat('yyyy-MM-ddThh:mm:ss.000+00:00').parse(json["insuredDOB"]),
    sumAssured: json["sumAssured"],
    intimationType: json["intimationType"],
    location: Location.fromJson(json["location"]),
    caseStatus: json["caseStatus"],
    nomineeName: json["nominee_Name"],
    nomineeContactNumber: json["nominee_ContactNumber"],
    nomineeAddress: json["nominee_address"],
    insuredAddress: json["insured_address"],
    caseDescription: json["case_description"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    pdf1FilePath: json["pdf1FilePath"],
    pdf2FilePath: json["pdf2FilePath"],
    pdf3FilePath: json["pdf3FilePath"],
    audioFilePath: json["audioFilePath"],
    videoFilePath: json["videoFilePath"],
    signatureFilePath: json["signatureFilePath"],
    capturedDate: json["capturedDate"],
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    updatedDate: DateTime.parse(json["updatedDate"]),
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "caseId": caseId,
    "policyNumber": policyNumber,
    "investigation": investigation.toJson(),
    "insuredName": insuredName,
    "insuredDOD": insuredDod.toIso8601String(),
    "insuredDOB": insuredDob.toIso8601String(),
    "sumAssured": sumAssured,
    "intimationType": intimationType,
    "location": location.toJson(),
    "caseStatus": caseStatus,
    "nominee_Name": nomineeName,
    "nominee_ContactNumber": nomineeContactNumber,
    "nominee_address": nomineeAddress,
    "insured_address": insuredAddress,
    "case_description": caseDescription,
    "longitude": longitude,
    "latitude": latitude,
    "pdf1FilePath": pdf1FilePath,
    "pdf2FilePath": pdf2FilePath,
    "pdf3FilePath": pdf3FilePath,
    "audioFilePath": audioFilePath,
    "videoFilePath": videoFilePath,
    "signatureFilePath": signatureFilePath,
    "capturedDate": capturedDate,
    "createdBy": createdBy,
    "createdDate": createdDate.toIso8601String(),
    "updatedDate": updatedDate.toIso8601String(),
    "updatedBy": updatedBy,
  };
}

class Investigation {
  Investigation({
    this.investigationType,
  });

  String investigationType;

  factory Investigation.fromJson(Map<String, dynamic> json) => Investigation(
    investigationType: json["investigationType"],
  );

  Map<String, dynamic> toJson() => {
    "investigationType": investigationType,
  };
}

class Location {
  Location({
    this.city,
    this.state,
    this.zone,
  });

  String city;
  String state;
  String zone;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    city: json["city"],
    state: json["state"],
    zone: json["zone"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "state": state,
    "zone": zone,
  };
}