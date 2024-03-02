import 'package:cartlistmurchant/PROVIDER/registrationProvider.dart';
import 'package:cartlistmurchant/SHAREPREF/cartlistSharepref.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistCard.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistText.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profileImage;
  String? profileName;
  String? profilePhone;
  String? profileID;
  String? profileEmail;
  String? description;
  String? opening;
  String? closing;
  String? leavedays;
  String? shopType;
  String? city;
  String? status;

  void getSharePrefData() {
    setState(() {
      profileImage = preferences!.getString("ShopImage");
      profileName = preferences!.getString("ShopName");
      profilePhone = preferences!.getString("ShopPhone");
      profileID = preferences!.getString("ShopID");

      profileEmail = preferences!.getString("UserMail");
      description = preferences!.getString("Description");
      opening = preferences!.getString("OpenTime");
      closing = preferences!.getString("CloseTime");

      leavedays = preferences!.getString("LeaveDays");
      shopType = preferences!.getString("ShopType");
      city = preferences!.getString("ShopCity");
      status = preferences!.getString("Three");
    });
  }

  @override
  void initState() {
    super.initState();
    getSharePrefData();
  }

  @override
  Widget build(BuildContext context) {
    var registerProvider = Provider.of<RegistrationProvider>(context);
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          shopProfileCardHead(
            context: context,
            storeImage:
                "http://18.183.210.225/cartlistapp_api/store/post_data/$profileImage",
            storeName: profileName.toString(),
            storeType: shopType.toString(),
            storeId: profileID.toString(),
          ),
          Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.call,
                    color: colorPrimary,
                  ),
                  title: Text(profilePhone.toString()),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.mail,
                    color: colorPrimary,
                  ),
                  title: Text(profileEmail.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(border: Border.all()),
                        child: normalTextWithPadding(
                            labelText: "Opening $opening"),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(border: Border.all()),
                        child: normalTextWithPadding(
                            labelText: "Closing $closing"),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.location_pin,
                      ),
                      label: const Text(
                        "3 mi",
                        style: TextStyle(color: colorBlack),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/images/delevery.png",
                        width: 50,
                      ),
                      label: const Text(
                        "Home Delivery available",
                        style: TextStyle(color: colorBlack),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 5),
                  child:
                      normalTextWithPadding(labelText: description.toString()),
                ),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    TextButton(
                      child: const Text(
                        "Leave Days",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      onPressed: () {},
                    ),
                    normalTextWithPadding(labelText: leavedays.toString()),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
