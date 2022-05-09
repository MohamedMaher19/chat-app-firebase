import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helpers/show_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String ? userName;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();


  bool isLoading = false ;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KprimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Yala Chat',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/63029-chatting-couple-animation.gif',
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        'Register',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    suffIcon: Icons.person,
                    hintText: 'User Name',
                    onChange: (data) {
                      userName = data;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    suffIcon: Icons.email,
                    hintText: 'Email',
                    onChange: (data) {
                      email = data;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    suffIcon: Icons.password,
                    onChange: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () async {
                      if(formKey.currentState!.validate()) {
                        isLoading = true ;
                        setState(() {

                        });
                        try {
                          await registerUser();
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatPage(userName:userName , email: email,);
                          }));

                          // Navigator.pushNamed(context, 'ChatPage' , arguments:email , );
                          // Navigator.pushNamed(context, 'ChatPage' , arguments:userName , );

                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context, 'weak password');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                'The account already exists for that email');
                          }

                        } catch (e) {
                          showSnackBar(context, 'there is an error');
                        }isLoading = false;
                        setState(() {

                        });
                      }
                    },
                    text: 'Register',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account ?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          ' LOG IN',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }


  Future<void> registerUser() async {

      var auth = FirebaseAuth.instance;
      UserCredential user =
      await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      print(user.user!.email);

  }
}

