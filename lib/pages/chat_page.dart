import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
   ChatPage({Key? key , this.userName , this.email}) : super(key: key);
String ? email ;
String ? userName ;

// make reference to use it add and read messages
   CollectionReference messages = FirebaseFirestore.instance.collection(KMessagesCollections);
   TextEditingController controller = TextEditingController();

   final _controller = ScrollController();


   @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(

        stream: messages.orderBy(KsendAt , descending: true).snapshots(),
        builder:(context, snapshot) {
          if(snapshot.hasData){
            List<Message> messageList = [];
            for(int i =0 ; i < snapshot.data!.docs.length ; i++){
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));

            }
          // snapshop has all data for the collection

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: KprimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/chat.png',
                    height: 50,
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body:Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                      itemBuilder: (context, index) {
                    return messageList[index].id == email ?  ChatBubble(message: messageList[index]

                    ) : otherChatBubble(message: messageList[index] );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller:controller ,
                    onSubmitted: (data){
                      messages.add({
                        KMessage : data ,
                        KsendAt : DateTime.now(),
                        'id' : email,
                        'name' : userName,
                      });
                      controller.clear();
                      _controller.animateTo(
                          0,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.bounceInOut);
                    },
                    decoration: InputDecoration(
                        suffixIcon:  GestureDetector(
                          onTap: (){
                           messages.add({
                           KMessage : controller.text ,
                           KsendAt : DateTime.now(),
                           'id' : email,
                           'name' : userName,
                           });
                           controller.clear();
                           _controller.animateTo(
                           0,
                           duration: Duration(milliseconds: 1000),
                           curve: Curves.easeIn);
                            },

                          child: Icon(Icons.send ,
                            color: KprimaryColor,),
                        ),
                        hintText: 'Send Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: KprimaryColor
                            )
                        )
                    ),

                  ),
                ),
              ],
            ),

          );
        }else{
            return Container(child: Center(child: Image.asset('assets/images/93019-loading-18.gif')));
          }
        }
    );
  }
}
