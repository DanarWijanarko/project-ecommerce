// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/_functions.dart';
import 'package:project_ecommerce/functions/auth_services.dart';
import 'package:project_ecommerce/components/button_custom.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';
import 'package:project_ecommerce/components/profile_information.dart';

class MySettingPage extends StatefulWidget {
  const MySettingPage({super.key});

  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  void handleSignOutBtn() async { 
    final result = await AuthServices().signout();
    AuthServices.handleSignOutResult(result, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture Start
            StreamBuilder(
              stream: FirestoreService().fecthDataFromSpecificDoc(
                'users',
                AuthServices().getCurrentUserUID(),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data;
                  if (user == null) {
                    return Center(
                      child: Text(
                        "No Data!",
                        style: TextStyle(color: black, fontSize: 20),
                      ),
                    );
                  }
                  return Container(
                    width: 180,
                    height: 180,
                    margin: const EdgeInsets.only(top: 25, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180),
                      color: bgGrey,
                      image: user.imgUrl != 'null'
                          ? DecorationImage(
                              image: NetworkImage(user.imgUrl),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image:
                                  AssetImage('assets/images/blank-profile.png'),
                              fit: BoxFit.cover,
                            ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: black.withOpacity(0.3),
                          offset: const Offset(0.5, 1.5),
                        )
                      ],
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 180,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            // Profile Picture End

            // Profile Detail Start
            StreamBuilder(
              stream: FirestoreService().fecthDataFromSpecificDoc(
                'users',
                AuthServices().getCurrentUserUID(),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data;
                  if (user == null) {
                    return Center(
                      child: Text(
                        "No Data!",
                        style: TextStyle(color: black, fontSize: 20),
                      ),
                    );
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[400]!,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        MyProfileInformation(
                          title: user.username == 'null'
                              ? 'Username not Set'
                              : user.username.toCapitalized(),
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        MyProfileInformation(
                          title: user.email == 'null'
                              ? 'Email not Set'
                              : user.email,
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 15),
                        MyProfileInformation(
                          title: user.address == 'null'
                              ? 'Address not Set'
                              : user.address,
                          icon: Icons.location_on,
                        ),
                        const SizedBox(height: 15),
                        MyProfileInformation(
                          title: user.phone == 'null'
                              ? 'Phone not Set'
                              : user.phone,
                          icon: Icons.phone,
                        ),
                        const SizedBox(height: 15),
                        MyProfileInformation(
                          title: user.birthDate == 'null'
                              ? 'Birth Date not Set'
                              : user.birthDate,
                          icon: Icons.date_range,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 362,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            // Profile Detail End

            const SizedBox(height: 15),

            // Edit Profile Button Start
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: MyButtonCustom(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
                bgColor: black,
                bgRadius: 15,
                onTapColor: textGrey,
                onTapRadius: 15,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            // Edit Profile Button End

            const SizedBox(height: 15),

            // Sign Out Start
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: MyButtonCustom(
                onPressed: handleSignOutBtn,
                bgColor: Colors.transparent,
                bgRadius: 15,
                onTapColor: textGrey,
                onTapRadius: 15,
                border: true,
                borderColor: red,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: red,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            // Sign Out End
          ],
        ),
      ),
    );
  }
}
