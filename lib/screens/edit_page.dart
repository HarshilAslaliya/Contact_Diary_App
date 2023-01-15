import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../models/globals.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  GlobalKey<FormState> contackKey = GlobalKey<FormState>();

  final TextEditingController _fncontrollar = TextEditingController();
  final TextEditingController _lncontrollar = TextEditingController();
  final TextEditingController _pncontrollar = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();

  String? firstname;
  String? lastname;
  String? phonenumber;
  String? email;
  File? image;

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    dynamic h1 = ModalRoute.of(context)!.settings.arguments;

    _fncontrollar.text = h1.firstname;
    _lncontrollar.text = h1.lastname;
    _pncontrollar.text = h1.phonenumber;
    _emailcontroller.text = h1.email;
    return Scaffold(
      backgroundColor:
          Globals.themeMode ? const Color(0xff181818) : Colors.white,
      appBar: AppBar(
        backgroundColor:
            Globals.themeMode ? const Color(0xff212121) : Colors.white,
        title: Text("Edit Contact",
            style: GoogleFonts.nerkoOne(
              letterSpacing: 1.5,
              textStyle: TextStyle(
                color: Globals.themeMode ? Colors.white : Colors.black,
                fontSize: 40,
              ),
            )),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            size: 30,
            color: (Globals.themeMode) ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();

            _fncontrollar.clear();
            _lncontrollar.clear();
            _pncontrollar.clear();
            _emailcontroller.clear();

            setState(() {
              firstname = "";
              lastname = "";
              phonenumber = "";
              email = "";
            });
          },
        ),
        actions: [
          const SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {
                if (contackKey.currentState!.validate()) {
                  contackKey.currentState!.save();

                  Contact c1 = Contact(
                    firstname: firstname,
                    lastname: lastname,
                    phonenumber: phonenumber,
                    email: email,
                    image: image,
                  );

                  int i = Globals.allcontacts.indexOf(h1);

                  Globals.allcontacts[i] = (c1);

                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('home', (route) => false);
                }
              },
              icon: Icon(
                Icons.check,
                size: 30,
                color: (Globals.themeMode) ? Colors.white : Colors.black,
              )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.4,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage:
                    (image != null) ? FileImage(image!) : null,
                    backgroundColor: Colors.grey,
                    radius: 50,
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Text(
                        (image != null) ? "" : "ADD",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.55, 0.7),
                  child: FloatingActionButton(
                    backgroundColor: Globals.themeMode
                        ? Colors.teal.shade300
                        : Colors.blue,
                    mini: true,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Globals.themeMode
                                ? const Color(0xff212121)
                                : Colors.white,
                            title: Text(
                              'Choose Gallery or Camera?',
                              style: TextStyle(
                                  color: Globals.themeMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Globals.themeMode
                                      ? Colors.teal.shade300
                                      : Colors.blueAccent, // backg foreground
                                ),
                                onPressed: () async {
                                  XFile? pickedPhoto = await _picker
                                      .pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    image = File(pickedPhoto!.path);
                                  });
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                },
                                child: const Text("ALBUMS"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Globals.themeMode
                                      ? Colors.teal.shade300
                                      : Colors.blueAccent, // backg foreground
                                ),
                                onPressed: () async {
                                  XFile? pickedFile = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    image = File(pickedFile!.path);
                                  });
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                },
                                child: const Text("CAMERA"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: contackKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "First Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Globals.themeMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _fncontrollar,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Your First Name...';
                        }
                        return null;
                      },
                      onSaved: (val1) {
                        setState(() {
                          firstname = val1;
                        });
                      },
                      style: TextStyle(
                          fontSize: 20,
                          color: Globals.themeMode ? Colors.white : Colors.black),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Globals.themeMode ? Colors.white : Colors.black,
                              width: 1.7),
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "First Name",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Globals.themeMode
                                ? Colors.white54
                                : Colors.black26),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Globals.themeMode ? Colors.white : Colors.black,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Last Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Globals.themeMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _lncontrollar,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Your First Name...';
                        }
                        return null;
                      },
                      onSaved: (val1) {
                        setState(() {
                          lastname = val1;
                        });
                      },
                      style: TextStyle(
                          fontSize: 20,
                          color: Globals.themeMode ? Colors.white : Colors.black),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Globals.themeMode ? Colors.white : Colors.black,
                              width: 1.7),
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Last Name",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Globals.themeMode
                                ? Colors.white54
                                : Colors.black26),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Globals.themeMode ? Colors.white : Colors.black,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Globals.themeMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _pncontrollar,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Your First Name...';
                        }
                        return null;
                      },
                      onSaved: (val1) {
                        setState(() {
                          phonenumber = val1;
                        });
                      },
                      style: TextStyle(
                          fontSize: 20,
                          color: Globals.themeMode ? Colors.white : Colors.black),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Globals.themeMode ? Colors.white : Colors.black,
                              width: 1.7),
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "+91 0000000000",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Globals.themeMode
                                ? Colors.white54
                                : Colors.black26),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Globals.themeMode ? Colors.white : Colors.black,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Globals.themeMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _emailcontroller,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Your First Name...';
                        }
                        return null;
                      },
                      onSaved: (val1) {
                        setState(() {
                          email = val1;
                        });
                      },
                      style: TextStyle(
                          fontSize: 20,
                          color: Globals.themeMode ? Colors.white : Colors.black),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Globals.themeMode ? Colors.white : Colors.black,
                              width: 1.7),
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "abc@example",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Globals.themeMode
                                ? Colors.white54
                                : Colors.black26),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Globals.themeMode ? Colors.white : Colors.black,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
