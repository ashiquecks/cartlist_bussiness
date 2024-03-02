import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getProfile.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_POST/createShop.dart';
import 'package:cartlistmurchant/SHAREPREF/cartlistSharepref.dart';
import 'package:cartlistmurchant/WIDGETS/alertDialogWidget.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistCard.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController userMail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox(),
        leadingWidth: 0,
        backgroundColor: colorWhite,
        title: const Text(
          "User Registration",
          style: TextStyle(color: colorPrimary, fontSize: 16),
        ),
        actions: [
          Row(
            children: [
              borderCube(),
              borderCube(),
              colorCube(),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/splash_logo.png'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: userMail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    label: const Text("email address"),
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
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    label: const Text("Password"),
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
                TextFormField(
                  controller: rePassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    label: const Text("Re Enter Password"),
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
                SizedBox(
                  width: widgetSize.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: scafoldMessageBoxLoading(context: context),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 2.5,
                          ),
                        ),
                      );

                      if (password.text == rePassword.text) {
                        final response = await registerStore(
                            context: context,
                            userMail: userMail.text,
                            password: password.text);
                        if (response.data!.success == 'true' ||
                            response.data == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              content: scafoldMessageBox(
                                  context: context,
                                  message: response.data!.message),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                bottom: widgetSize.height / 2.5,
                              ),
                            ),
                          );
                          final profileResponse = await getProfile(
                              context: context, userMail: userMail.text);

                          if (profileResponse.data!.success == 'true' ||
                              profileResponse.data == null) {
                            setStoreCredentials(
                              shopID: profileResponse.data!.data.storeId,
                              shopName: profileResponse.data!.data.storeName,
                              shopType: profileResponse.data!.data.storeType,
                              storePhone: profileResponse.data!.data.storePhone,
                              storeImage: profileResponse.data!.data.storeImage,
                              city: profileResponse.data!.data.city,
                              description:
                                  profileResponse.data!.data.description,
                              homeDelevery:
                                  profileResponse.data!.data.homeDelevery,
                              openTime: profileResponse.data!.data.openTime,
                              closeTime: profileResponse.data!.data.closeTime,
                              leaveDays: profileResponse.data!.data.leaveDays,
                              latitude: profileResponse.data!.data.latitude,
                              longitude: profileResponse.data!.data.longitude,
                              location: profileResponse.data!.data.location,
                              searchRadius:
                                  profileResponse.data!.data.searchRadius,
                              userMail: profileResponse.data!.data.userMail,
                              password: profileResponse.data!.data.password,
                              three: profileResponse.data!.data.status,
                              newUser: true,
                            );

                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, '/homeNavigation');
                          } else {
                            print("empty profile data");
                          }
                        } else {
                          print("not compleet");
                        }
                      } else {
                        print("password not match");
                      }
                    },
                    child: const Text('Submit'),
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
