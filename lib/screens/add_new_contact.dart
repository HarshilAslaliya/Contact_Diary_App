import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../models/globals.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final ImagePicker _picker = ImagePicker();

  GlobalKey<FormState> contactkey = GlobalKey<FormState>();

  TextEditingController firstname1 = TextEditingController();
  TextEditingController lastname1 = TextEditingController();
  TextEditingController phonenumber1 = TextEditingController();
  TextEditingController email1 = TextEditingController();

  String? firstname;
  String? lastname;
  String? phonenumber;
  String? email;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Globals.themeMode ? const Color(0xff181818) : Colors.white,
      appBar: AppBar(
        backgroundColor:
            Globals.themeMode ? const Color(0xff212121) : Colors.white,
        title: Text("ADD",
            style: GoogleFonts.nerkoOne(
              textStyle: TextStyle(
                color: Globals.themeMode ? Colors.white : Colors.black,
                fontSize: 40,
              ),
            )),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            size: 30,
          ),
          color: (Globals.themeMode == true) ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                if (contactkey.currentState!.validate()) {
                  contactkey.currentState!.save();
                  Contact c1 = Contact(
                    firstname: firstname,
                    lastname: lastname,
                    phonenumber: phonenumber,
                    email: email,
                    image: image,
                  );
                  setState(() {
                    Globals.allcontacts.add(c1);
                  });
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'home', (route) => false);
                }
              },
              icon: Icon(
                Icons.check,
                color:
                    (Globals.themeMode == true) ? Colors.white : Colors.black,
                size: 30,
              )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
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
              key: contactkey,
              child: Container(
                padding: const EdgeInsets.all(20),
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
                        color: (Globals.themeMode == true)
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: firstname1,
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
                          color:
                              Globals.themeMode ? Colors.white : Colors.black),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color:
                              Globals.themeMode ? Colors.white : Colors.black,
                        )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Globals.themeMode
                                  ? Colors.white
                                  : Colors.black,
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
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Last Name",
                      style: TextStyle(
                        fontSize: 20,
                        color: (Globals.themeMode == true)
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: lastname1,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Your Last Name...';
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
                          color:
                              Globals.themeMode ? Colors.white : Colors.black),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Globals.themeMode
                                  ? Colors.white
                                  : Colors.black,
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
                          color:
                              Globals.themeMode ? Colors.white : Colors.black,
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
                        color: (Globals.themeMode == true)
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: phonenumber1,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Your Phone Number...';
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
                          color:
                              Globals.themeMode ? Colors.white : Colors.black),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Globals.themeMode
                                  ? Colors.white
                                  : Colors.black,
                              width: 1.7),
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "+91 9765432102",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Globals.themeMode
                                ? Colors.white54
                                : Colors.black26),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color:
                              Globals.themeMode ? Colors.white : Colors.black,
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
                        color: (Globals.themeMode == true)
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: email1,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Enter Your Email...';
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
                          color:
                              Globals.themeMode ? Colors.white : Colors.black),
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Globals.themeMode
                                  ? Colors.white
                                  : Colors.black,
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
                          color:
                              Globals.themeMode ? Colors.white : Colors.black,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
