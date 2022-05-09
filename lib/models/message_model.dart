

import 'package:chat_app/constants/constants.dart';

class Message {

  final String message ;
  final String id ;
  final String  name ;

  Message(this.message, this.id , this.name);

  factory Message.fromJson(jsonData){

    return Message(jsonData[KMessage] , jsonData['id'] , jsonData['name'] );
  }

}