import 'dart:io';

class Contact {
  final String? firstname;
  final String? lastname;
  final String? phonenumber;
  final String? email;
  final File? image;

  Contact({
    required this.firstname,
    required this.lastname,
    required this.phonenumber,
    required this.email,
    required this.image,
  });
}

class Globals {
  static bool themeMode = false;
  static List<Contact> allcontacts = [];

  static String? firstname;
  static String? lastname;
  static String? phonenumber;
  static String? email;
  static File? image;
}
