import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({Key? key , this.hintText , this.onChange , this.obSecure = false , this.prefIcon , this.suffIcon}) : super(key: key);
  String ? hintText;
  Function(String)? onChange;
  bool ? obSecure ;
   IconData?  prefIcon ;
   IconData ? suffIcon ;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(

      obscureText:obSecure !,
      validator: (data){
        if(data!.isEmpty){
          return 'Field is required';
        }

      },
      style: TextStyle(
        color: Colors.white
      ),
      onChanged:onChange ,
      decoration: InputDecoration(
        suffixIcon:(
           Icon(suffIcon)),
        hintText:hintText ,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(),


          )
      ),
    );
  }
}
