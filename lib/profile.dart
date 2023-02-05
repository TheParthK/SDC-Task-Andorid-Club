import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdc_task_android_club_v2/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  String _userEmailid(){
      return user?.email??'';
  }

  bool signOutButtonPressed = false;

  void signOutReally(bool isSignOutButtonPressed){
    if(isSignOutButtonPressed){
      signOut();
    } else {
      null;
    }
  }

  String? userID;
  String? name;
  String? email;
  String? mobile;
  String? imgURL;
  String? joinDate;
  @override
  void initState() {
    super.initState();
    getData();

  }
  void getData() async{
    User? user = Auth().currentUser;
    // print(user?.email);
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    userID = await userDoc.get('id');
    name = await userDoc.get('name');
    email = await userDoc.get('email');
    mobile = await userDoc.get('mobile');
    imgURL = await userDoc.get('imgURL');
    joinDate = await userDoc.get('joinedAt');

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // String userUID = '@';
    // String userEmailID = _userEmailid();
    // if(userEmailID != ''){
    //   for(int i = 0 ; i < userEmailID.length ; i++){
    //     if(userEmailID[i] == '@'){
    //       break;
    //     } else {
    //       userUID += userEmailID[i];
    //     }
    //   }
    // }
    return Stack(
      children: [
        Scaffold(appBar: AppBar(toolbarHeight: 0, elevation: 0, backgroundColor: Colors.black,),),
        GestureDetector(
          onTap: () {
            setState(() {
              signOutButtonPressed = false;
            });
          },
          child: Scaffold(
            body: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 17, 17, 17),
                image: DecorationImage(image: NetworkImage(imgURL??'https://cdn.dribbble.com/users/759083/screenshots/14186576/media/2e14a1e8cd756c4aeefc0526a60bf1c3.png?compress=1&resize=400x300'), fit: BoxFit.cover)
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: Color.fromARGB(!signOutButtonPressed?129:200, 0, 0, 0)
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 12,),
                        SizedBox(
                          width: size.width/1.2,
                          height: size.width/1.2,
                          child: Center(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInSine,
                              width: !signOutButtonPressed? size.width/1.2:size.width/2,
                              height: !signOutButtonPressed? size.width/1.2:size.width/2,
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(image: NetworkImage(imgURL??'https://cdn.dribbble.com/users/759083/screenshots/14186576/media/2e14a1e8cd756c4aeefc0526a60bf1c3.png?compress=1&resize=400x300'), fit: BoxFit.cover)
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: signOutButtonPressed?100:size.width/1.12, height: 1, color: Colors.white,),
                        const SizedBox(height: 12,),
                        Text(name??'', style: const TextStyle(color: Colors.white, fontFamily: 'FatFace', fontSize: 28, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 6,),
                        Text('-${userID??''}-', style: const TextStyle(color: Colors.white, fontSize: 8, fontFamily: 'Ahom'),),
                        const SizedBox(height: 12,),
                        Text(email??'', style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Ahom'),),
                        const SizedBox(height: 12,),
                        Text('Joined Us on ${joinDate??''}', style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Ahom'),),
                        const SizedBox(height: 12,),
                        Text('Mobile: ${mobile??''}', style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Ahom'),),
                        const SizedBox(height: 12,),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: signOutButtonPressed?100:size.width/1.12, height: 1, color: Colors.white,),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: size.width/2 - 24,
                              child: Center(child: Text(signOutButtonPressed?'Long Press to\nSign Out':'', style: const TextStyle(color: Colors.white, fontSize: 12,),textAlign: TextAlign.center,)),
                              ),
                              const Expanded(child: SizedBox()),
                              GestureDetector(
                                onTapDown: (details) {
                                  setState(() {
                                    signOutButtonPressed = true;
                                  });
                                },
                                onLongPress: () {
                                  signOutReally(signOutButtonPressed);
                                },
                                child: AnimatedContainer(
                                  curve: Curves.linearToEaseOut,
                                  duration: const Duration(milliseconds:240),
                                  width: signOutButtonPressed?size.width/2:size.width/3,
                                  height: signOutButtonPressed?size.width/4:size.width/3,
                                  decoration: BoxDecoration(
                                    color: signOutButtonPressed?const Color.fromARGB(255, 255, 0, 0):const Color.fromARGB(255, 214, 14, 0),
                                    borderRadius: BorderRadius.all(Radius.circular(size.width/6))
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      CupertinoIcons.clear,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );  
  }
}