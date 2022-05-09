
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helpers/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false ;
  String? email;
  String ? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:KprimaryColor,
        body:Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60,),
                  Text('Yala Chat' , style: TextStyle(
                    fontFamily:'Pacifico',
                    color: Colors.white,
                    fontSize: 30,
                  ),),
                  SizedBox(height: 20,),
                  Container(
                      height:200 ,
                      width:300 ,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20 ),
                      ),
                      child: Image.asset('assets/images/NEW.gif' , )),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Text('Login' ,
                        textAlign: TextAlign.left
                        , style: TextStyle(
                          fontWeight: FontWeight.bold,
                        color: Colors.white,
                          fontFamily:'Pacifico',

                          fontSize: 25,
                      ),),
                    ],
                  ),
                  SizedBox(height: 20,),

                  CustomTextField(
                    suffIcon: Icons.person,

                    onChange: (data) {
                      userName = data;
                    },
                    hintText: 'User Name',

                  ),
                  SizedBox(height: 15,),

                  CustomTextField(
                    suffIcon: Icons.email,

                    onChange: (data) {
                      email = data;
                    },
                    hintText: 'Email',

                  ),
                  SizedBox(height: 15,),

                  CustomTextField(
                    suffIcon: Icons.password,
                    obSecure: true,
                    onChange: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(height: 15,),

                  CustomButton(
                    onTap: () async {
                      if(formKey.currentState!.validate()) {
                        isLoading = true ;
                        setState(() {

                        });
                        try {
                          await LoginUser();
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatPage(userName:userName , email: email,);
                          }));

                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context, 'user-not-found');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,
                                'Wrong password provided for that user');
                          }

                        } catch (e) {
                          showSnackBar(context, 'there is an error');
                        }
                        isLoading = false;
                        setState(() {

                        });
                      }else{}
                    },
                    text: 'Login',
                  ),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('don\'t have an account ?' , style: TextStyle(
                        color: Colors.white,
                      ),),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, 'RegisterPage');
                        },
                        child: Text(' REGISTER' , style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),

                    ],
                  )


                ],
              ),
            ),
          ),
        ) ,

      ),
    );
  }


  Future<void> LoginUser() async {

    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);

      print(user.user!.email);

  }
}
