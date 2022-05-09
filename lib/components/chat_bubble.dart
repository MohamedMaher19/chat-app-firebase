import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({Key? key , required this.message}) : super(key: key);
  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(left: 20 ,right: 16, top: 17, bottom: 17),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),),
          color: KprimaryColor,

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(

              (message.name) ,
              style: TextStyle(
              color: Colors.yellow,
            ),),
            SizedBox(height: 10,),
            Text(
              message.message ,
              style: TextStyle(
              color: Colors.white,

            ),),
          ],
        ),
      ),
    );
  }
}

class otherChatBubble extends StatelessWidget {
  otherChatBubble({Key? key , required this.message}) : super(key: key);
  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 20 ,right: 16, top: 17, bottom: 17),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),),
          color: Colors.teal,

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            Text(
              (message.name ) , style: TextStyle(
              color: Colors.orange,
            ),),
            SizedBox(height: 10,),
            Text(message.message , style: TextStyle(
              color: Colors.white,
            ),),
          ],
        ),
      ),
    );
  }
}
