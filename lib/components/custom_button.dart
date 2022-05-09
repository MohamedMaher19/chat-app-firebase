import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({Key? key , this.text , this.onTap}) : super(key: key);

  String? text ;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height:60 ,
        width:double.infinity ,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(text! , style: TextStyle(
          // fontWeight: FontWeight.bold,
          fontFamily:'Pacifico',
          fontSize: 25,


        ),)),

      ),
    );
  }
}
