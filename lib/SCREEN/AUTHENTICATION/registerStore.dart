import 'dart:convert';
import 'dart:io';
import 'package:cartlistmurchant/PROVIDER/registrationProvider.dart';
import 'package:cartlistmurchant/WIDGETS/alertDialogWidget.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistCard.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class RegisterStore extends StatefulWidget {
  const RegisterStore({super.key});

  @override
  State<RegisterStore> createState() => _RegisterStoreState();
}

class _RegisterStoreState extends State<RegisterStore> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController shopName = TextEditingController();
  TextEditingController shopCity = TextEditingController();
  TextEditingController shopDescription = TextEditingController();

  File? imagePath;
  String? imageName;
  String? imageData;

  ImagePicker imagePicker = ImagePicker();

  Future<void> getImage() async {
    var getimagepath = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = File(getimagepath!.path);
      imageName = getimagepath.path.split("/").last;
      imageData = base64Encode(imagePath!.readAsBytesSync());
    });
  }

  @override
  void initState() {
    super.initState();
  }

  String? phoneNumber;

  String dropdownValue = 'Select shop type';
  List<String> drpItems = [
    "Hypermarket",
    "Supermarket",
    "Grocery",
    "Bakery",
    "Vegetable",
    "Fruits",
    "Pets and gardens"
  ];

  @override
  Widget build(BuildContext context) {
    final registerProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox(),
        leadingWidth: 0,
        backgroundColor: colorWhite,
        title: const Text(
          "Shop profile",
          style: TextStyle(color: colorPrimary, fontSize: 16),
        ),
        actions: [
          Row(
            children: [
              colorCube(),
              borderCube(),
              borderCube(),
            ],
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imagePath != null
                    ? Stack(
                        children: [
                          Container(
                            width: widgetSize.width,
                            height: 250,
                            child: Image.file(imagePath!),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 25,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                imagePath != null
                    ? const SizedBox()
                    : Stack(
                        children: [
                          Container(
                            width: widgetSize.width,
                            height: 250,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/store2.jpg',
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 25,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: shopName,
                  decoration: InputDecoration(
                    label: const Text("Shop name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Shop Name";
                    }
                  },
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      hint: Text(dropdownValue),
                      borderRadius: BorderRadius.circular(10),
                      elevation: 0,
                      underline: const SizedBox(),
                      isExpanded: true,
                      items: drpItems.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: (number) {
                    if (number!.completeNumber.isEmpty) {
                      return "Enter Shop Phone Number";
                    }
                  },
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    setState(() {
                      phoneNumber = phone.completeNumber;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: shopCity,
                  decoration: InputDecoration(
                    label: const Text("Pin Code"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Pin Code";
                    }
                  },
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Option"),
                ),
                TextFormField(
                  controller: shopDescription,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: widgetSize.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      if (imageName != null) {
                        registerProvider.setImage(imageData ?? "");
                        registerProvider.setImageName(imageName ?? "");
                        registerProvider.setShopName(shopName.text);
                        registerProvider.setShoptype(dropdownValue);
                        registerProvider.setPhoneNumber(phoneNumber.toString());
                        registerProvider.setCity(shopCity.text);
                        registerProvider.setDescription(shopDescription.text);
                        Navigator.pushNamed(context, '/workingStatus');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: scafoldMessageBox(
                                context: context,
                                message: 'Please Uplod Image'),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                              bottom: widgetSize.height / 2.5,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
