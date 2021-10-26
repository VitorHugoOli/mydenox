import 'dart:convert';

List<Person> personFromJson(String str) =>
    List<Person>.from(json.decode(str).map((x) => Person.fromJson(x)));

String personToJson(List<Person> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Person {
  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.documentCpf,
    required this.phone,
    required this.phoneMobile,
    required this.state,
    required this.stateDate,
    required this.active,
    required this.createDate,
    required this.mailMarketing,
    required this.allowGeolocation,
    required this.invitationStatus,
    required this.fingerPrintPosition,
    required this.roles,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.lastPositionStatus,
    required this.dateLastLogin,
    required this.technical,
    required this.recover,
    required this.birthDate,
    required this.photoId,
    required this.fingerPrintCoercion,
    required this.emailNotifications,
  });

  final int id;
  final String name;
  final String email;
  final String? documentCpf;
  final String? phone;
  final String? phoneMobile;
  final int? state;
  final int? stateDate;
  final int active;
  final int createDate;
  final int mailMarketing;
  final int allowGeolocation;
  final InvitationStatus invitationStatus;
  final List<int> fingerPrintPosition;
  final Roles? roles;
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final int? lastPositionStatus;
  final int? dateLastLogin;
  final bool technical;
  final bool recover;
  final String? birthDate;
  final String? photoId;
  final int? fingerPrintCoercion;
  final EmailNotifications? emailNotifications;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        documentCpf: json["documentCpf"],
        phone: json["phone"],
        phoneMobile: json["phoneMobile"],
        state: json["state"],
        stateDate: json["stateDate"],
        active: json["active"],
        createDate: json["createDate"],
        mailMarketing: json["mailMarketing"],
        allowGeolocation: json["allowGeolocation"],
        invitationStatus: invitationStatusValues.map[json["invitationStatus"]]!,
        fingerPrintPosition:
            List<int>.from(json["fingerPrintPosition"].map((x) => x)),
        roles: json["roles"] == null ? null : Roles.fromJson(json["roles"]),
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        accuracy: json["accuracy"]?.toDouble(),
        lastPositionStatus: json["lastPositionStatus"],
        dateLastLogin: json["dateLastLogin"],
        technical: json["technical"],
        recover: json["recover"],
        birthDate: json["birthDate"],
        photoId: json["photoId"],
        fingerPrintCoercion: json["fingerPrintCoercion"],
        emailNotifications: json["emailNotifications"] == null
            ? null
            : EmailNotifications.fromJson(json["emailNotifications"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "documentCpf": documentCpf,
        "phone": phone,
        "phoneMobile": phoneMobile,
        "state": state,
        "stateDate": stateDate,
        "active": active,
        "createDate": createDate,
        "mailMarketing": mailMarketing,
        "allowGeolocation": allowGeolocation,
        "invitationStatus": invitationStatusValues.reverse[invitationStatus],
        "fingerPrintPosition":
            List<dynamic>.from(fingerPrintPosition.map((x) => x)),
        "roles": roles?.toJson(),
        "latitude": latitude,
        "longitude": longitude,
        "accuracy": accuracy,
        "lastPositionStatus": lastPositionStatus,
        "dateLastLogin": dateLastLogin,
        "technical": technical,
        "recover": recover,
        "birthDate": birthDate,
        "photoId": photoId,
        "fingerPrintCoercion": fingerPrintCoercion,
        "emailNotifications": emailNotifications?.toJson(),
      };
}

class EmailNotifications {
  EmailNotifications({
    required this.gsmNoSignal,
    required this.zigbeeConnection,
    required this.fingerprintNotAssociated,
    required this.pendingAccessRequest,
    required this.cameraSdcardFailure,
    required this.centralOffline,
    required this.deviceLowBattery,
    required this.cameraExceedPrivateModeLimit,
    required this.usingBattery,
  });

  final bool gsmNoSignal;
  final bool zigbeeConnection;
  final bool fingerprintNotAssociated;
  final bool pendingAccessRequest;
  final bool cameraSdcardFailure;
  final bool centralOffline;
  final bool deviceLowBattery;
  final bool cameraExceedPrivateModeLimit;
  final bool usingBattery;

  factory EmailNotifications.fromJson(Map<String, dynamic> json) =>
      EmailNotifications(
        gsmNoSignal: json["GSM_NO_SIGNAL"],
        zigbeeConnection: json["ZIGBEE_CONNECTION"],
        fingerprintNotAssociated: json["FINGERPRINT_NOT_ASSOCIATED"],
        pendingAccessRequest: json["PENDING_ACCESS_REQUEST"],
        cameraSdcardFailure: json["CAMERA_SDCARD_FAILURE"],
        centralOffline: json["CENTRAL_OFFLINE"],
        deviceLowBattery: json["DEVICE_LOW_BATTERY"],
        cameraExceedPrivateModeLimit: json["CAMERA_EXCEED_PRIVATE_MODE_LIMIT"],
        usingBattery: json["USING_BATTERY"],
      );

  Map<String, dynamic> toJson() => {
        "GSM_NO_SIGNAL": gsmNoSignal,
        "ZIGBEE_CONNECTION": zigbeeConnection,
        "FINGERPRINT_NOT_ASSOCIATED": fingerprintNotAssociated,
        "PENDING_ACCESS_REQUEST": pendingAccessRequest,
        "CAMERA_SDCARD_FAILURE": cameraSdcardFailure,
        "CENTRAL_OFFLINE": centralOffline,
        "DEVICE_LOW_BATTERY": deviceLowBattery,
        "CAMERA_EXCEED_PRIVATE_MODE_LIMIT": cameraExceedPrivateModeLimit,
        "USING_BATTERY": usingBattery,
      };
}

enum InvitationStatus { A }

final invitationStatusValues = EnumValues({"A": InvitationStatus.A});

class Roles {
  Roles({
    required this.administrator,
    required this.cameraRead,
    required this.automationWrite,
    required this.alarmFingerprint,
    required this.peopleWrite,
    required this.securityWrite,
    required this.configurationWrite,
    required this.peopleRead,
    required this.owner,
  });

  final bool administrator;
  final bool cameraRead;
  final bool automationWrite;
  final bool alarmFingerprint;
  final bool peopleWrite;
  final bool securityWrite;
  final bool configurationWrite;
  final bool peopleRead;
  final bool owner;

  factory Roles.fromJson(Map<String, dynamic> json) => Roles(
        administrator: json["ADMINISTRATOR"] ?? false,
        cameraRead: json["CAMERA_READ"] ?? false,
        automationWrite: json["AUTOMATION_WRITE"] ?? false,
        alarmFingerprint: json["ALARM_FINGERPRINT"] ?? false,
        peopleWrite: json["PEOPLE_WRITE"] ?? false,
        securityWrite: json["SECURITY_WRITE"] ?? false,
        configurationWrite: json["CONFIGURATION_WRITE"] ?? false,
        peopleRead: json["PEOPLE_READ"] ?? false,
        owner: json["OWNER"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "ADMINISTRATOR": administrator,
        "CAMERA_READ": cameraRead,
        "AUTOMATION_WRITE": automationWrite,
        "ALARM_FINGERPRINT": alarmFingerprint,
        "PEOPLE_WRITE": peopleWrite,
        "SECURITY_WRITE": securityWrite,
        "CONFIGURATION_WRITE":
            configurationWrite,
        "PEOPLE_READ": peopleRead,
        "OWNER": owner,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> ?reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap ??= map.map((k, v) => MapEntry(v, k));
  }
}
