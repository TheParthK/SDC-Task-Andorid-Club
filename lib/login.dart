import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';
import 'button.dart';
import 'inputFeilds.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();


  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  String generateUserID(String email){
    String userID = '@';
    for(int i = 0 ; i < email.length ; i++){
      if(email[i] == '@'){
        break;
      } else {
        userID += email[i];
      }
    }
    return userID;
  }

  Future<void> signInWithEmailAndPassword() async{
    try{
      await Auth()
      .signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );
    } on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    DateTime date = DateTime.now();
    String formattedDate = '${date.day}/${date.month}/${date.year}';

    try {

        await Auth()
        .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
        );
        final User? user = Auth().currentUser;
        
        final uid = user?.uid;

        FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id': uid,
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'mobile': _mobileController.text.trim(),
        'imgURL' : _imageController.text,
        'joinedAt': formattedDate
        });
    } on FirebaseAuthException catch (e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  

  void displayErrorMessage(){
    if(errorMessage != null && errorMessage != ''){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage!))
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double inputWidth = size.width/1.15;
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            // color: Color.fromARGB(255, 117, 93, 131),
            image: DecorationImage(
              image: NetworkImage('https://i.pinimg.com/originals/46/d7/00/46d700704c0ae473389c1bfb49501fd3.gif')
              // image: AssetImage('assets/bg1.png')
              ,fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Color.fromARGB(43, 0, 0, 0), BlendMode.darken),
            ),
            gradient: SweepGradient(
              startAngle: 0,
              endAngle: 3,
              center: Alignment.center,
              tileMode: TileMode.mirror,
              colors: [
                Color.fromARGB(255, 25, 87, 244),
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 255, 0, 0),
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 255, 213, 0)
              ]
            )
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: isKeyboardVisible?MainAxisAlignment.start:MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: size.width-16,
                    height: size.height/(isLogin?1.5:1.1409),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          decoration:  BoxDecoration(
                            color: const Color.fromARGB(52, 255, 255, 255),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(width: 0.7, color: const Color.fromARGB(255, 255, 255, 255))
                          ),
                          width: size.width,
                          child: Column(
                            children: [
                              !isKeyboardVisible?
                              Expanded(
                                child: Row(
                                  children:  [
                                    const SizedBox(width: 12,),
                                    Text(
                                      !isLogin?'Create Your Profile!':'Welcome Back!',
                                      style: TextStyle(fontFamily: 'FatFace', fontSize: size.height/27,
                                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  ],
                                )
                              ):const SizedBox(),
  
                              !isKeyboardVisible?
                              Container(
                                height: 1,
                                width: size.width-40,
                                color: Colors.white,
                              ):const SizedBox(),

                              Expanded(
                                flex: isLogin?6:9,
                                child: Column(
                                  children:[
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        const SizedBox(width: 15,),
                                        AnimatedTextKit(
                                          repeatForever: true,
                                          isRepeatingAnimation: true,
                                          animatedTexts: [
                                          TypewriterAnimatedText(!isLogin?'Hey There!,':'How Have You Been?', textStyle: const TextStyle(fontFamily: 'FatFace', fontSize: 18,backgroundColor: Color.fromARGB(255, 245, 245, 245),), speed: const Duration(milliseconds: 100)),
                                          TypewriterAnimatedText(!isLogin?'Can I Get Some Information?':'Type in Your Credentials!', textStyle: const TextStyle(fontFamily: 'FatFace', fontSize: 18,backgroundColor: Color.fromARGB(255, 245, 245, 245),),speed: const Duration(milliseconds: 100)),
                                        ])
                                      ],
                                    ),
                                    SizedBox(height: isKeyboardVisible?12:0,),
                                    isKeyboardVisible?
                                    Container(
                                      height: 1,
                                      width: size.width-40,
                                      color: Colors.white,
                                    ):const SizedBox(),
                                    
                                    !isLogin?Column(
                                      children: [
                                    SizedBox(height: !isKeyboardVisible?12:0,),
                                    const SizedBox(height: 12,),
                                    CustomInputFeilds(hintText: 'Name', width: inputWidth, editingController: _nameController,),
                                    const SizedBox(height: 12,),
                                    CustomInputFeilds(hintText: 'Mobile', width: inputWidth, editingController: _mobileController,),
                                    const SizedBox(height: 12,),
                                    CustomInputFeilds(hintText: 'Paste an image URL', width: inputWidth, editingController: _imageController,),
                                      ],
                                    ):const SizedBox(),
                                    const SizedBox(height: 12,),
                                    CustomInputFeilds(width: inputWidth, hintText: 'Email', editingController: _emailController,),
                                    const SizedBox(height: 12,),
                                    CustomInputFeilds(width: inputWidth, hintText: isLogin?'Password':"Set a Password", editingController: _passwordController,),
                                    const SizedBox(height: 10,),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isLogin = !isLogin;
                                          _emailController.clear();
                                          _passwordController.clear();
                                        });
                                      },
                                      child: SizedBox(
                                        // color: Colors.white,
                                        height: 20,
                                        child: Text(isLogin?'New Here?':'Login instead', style: const TextStyle(color: Colors.white, fontSize: 10),)),
                                    ),
            
                                    Expanded(child: Container(color: Colors.transparent,child: const Center(child: Text('-by Parth Kalia for SDC Task Android Club-', style: TextStyle(fontSize: 10, color: Colors.white),)),)),
            
                                    CustomButton(size: size, buttonAction: (){
                                      isLogin?signInWithEmailAndPassword():createUserWithEmailAndPassword();
                                      displayErrorMessage();
                                    }),
                                    const SizedBox(height: 12),
                                    ]
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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