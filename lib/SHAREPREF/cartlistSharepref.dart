import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

setStoreCredentials({
  required String shopID,
  required String shopName,
  required String shopType,
  required String storePhone,
  required String storeImage,
  required String city,
  required String description,
  required String homeDelevery,
  required String openTime,
  required String closeTime,
  required String leaveDays,
  required String latitude,
  required String longitude,
  required String location,
  required String searchRadius,
  required String userMail,
  required String password,
  required String three,
  required bool newUser,
}) async {
  preferences = await SharedPreferences.getInstance();

  preferences!.setString("ShopID", shopID);
  preferences!.setString("ShopName", shopName);
  preferences!.setString("ShopType", shopType);

  preferences!.setString("ShopPhone", storePhone);
  preferences!.setString("ShopImage", storeImage);
  preferences!.setString("ShopCity", city);

  preferences!.setString("Description", description);
  preferences!.setString("HomeDelivery", homeDelevery);
  preferences!.setString("OpenTime", openTime);
  preferences!.setString("CloseTime", closeTime);

  preferences!.setString("LeaveDays", leaveDays);
  preferences!.setString("Latitude", latitude);
  preferences!.setString("Longitude", longitude);
  preferences!.setString("Location", location);

  preferences!.setString("SearchDays", searchRadius);
  preferences!.setString("UserMail", userMail);
  preferences!.setString("Password", password);
  preferences!.setString("Three", three);

  preferences!.setBool("NewUser", newUser);
}

getUser() async {
  preferences = await SharedPreferences.getInstance();
  bool userStatus = preferences!.getBool("NewUser") ?? false;
  return userStatus;
}
