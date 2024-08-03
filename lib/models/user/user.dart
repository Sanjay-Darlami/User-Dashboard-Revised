import 'package:demo_revised_project/models/user/address.dart';
import 'package:demo_revised_project/models/user/company.dart';

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  Company? company;

  User(this.id, this.name, this.username, this.email, this.address, this.phone,
      this.company);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'address': address?.toJson(),
      'phone': phone,
      'company': company?.toJson(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['name'],
      json['username'],
      json['email'],
      json['address'] != null ? Address.fromJson(json['address']) : null,
      json['phone'],
      json['company'] != null ? Company.fromJson(json['company']) : null,
    );
  }

  User copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    Address? address,
    String? phone,
    Company? company,
  }) {
    return User(
      id ?? this.id,
      name ?? this.name,
      username ?? this.username,
      email ?? this.email,
      address ?? this.address,
      phone ?? this.phone,
      company ?? this.company,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, username: $username, email: $email)';
  }
}
