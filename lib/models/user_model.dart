import 'dart:convert';

class FirebaseUserModel {
  String fullName;
  String email;
  String phone;
  String uid;
  FirebaseUserModel({
    this.fullName,
    this.email,
    this.phone,
    this.uid,
  });

  FirebaseUserModel copyWith({
    String fullName,
    String email,
    String phone,
    String uid,
  }) {
    return FirebaseUserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'uid': uid,
    };
  }

  factory FirebaseUserModel.fromMap(Map<String, dynamic> map) {
    return FirebaseUserModel(
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseUserModel.fromJson(String source) =>
      FirebaseUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FirebaseUserModel(fullName: $fullName, email: $email, phone: $phone, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FirebaseUserModel &&
        other.fullName == fullName &&
        other.email == email &&
        other.phone == phone &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^ email.hashCode ^ phone.hashCode ^ uid.hashCode;
  }
}
