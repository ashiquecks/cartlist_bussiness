import 'dart:async';

import 'package:cartlistmurchant/FUNCTION/apiCallback.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getAppCredentials.dart';
import 'package:cartlistmurchant/SHAREPREF/cartlistSharepref.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userMail;

  void getSharePrefData() async {
    if (buildVersion == accessBuildVersion) {
      if (await getUser() == false) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, '/storeLogin');
        });
      } else {
        getSharePref();
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, '/homeNavigation');
        });
      }
    } else {
      Navigator.pushNamed(context, '/updateApp');
    }
  }

  String? profileID;

  void getSharePref() {
    setState(() {
      profileID = preferences!.getString("ShopID");
    });
    getOrderResponse(
      context: context,
      profileID: profileID.toString(),
    );
    getConfirmOrderResponse(profileID: profileID.toString(), context: context);
    getDeliverOrderResponse(profileID: profileID.toString(), context: context);
  }

  getAppCred() async {
    var response = await CartlistCredential.getCartlistCredentials();
    if (response.isSuccessful!) {
      print(response.data!.appData.version);
      setState(() {
        accessBuildVersion = response.data!.appData.mVersion;
      });
      getSharePrefData();
    } else if (response.message ==
        "Unable to reach the internet! Ple ase try again in  a minutes or two") {
      Navigator.pushNamed(context, '/lossConnection');
    } else {}
  }

  String buildVersion = '0.0.2'; // WARNING CHEANGE CARE FULLY
  String? accessBuildVersion;

  @override
  void initState() {
    super.initState();
    getAppCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: Image.asset('assets/images/splash_logo.png'),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              "Build version:$buildVersion",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
