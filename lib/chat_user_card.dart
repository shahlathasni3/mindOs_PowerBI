import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindos_2/models/ChatUser.dart';

import 'ChatPage.dart';

class chat_user_card extends StatefulWidget {

  final ChatUser user;
  const chat_user_card({super.key,required this.user});

  @override
  State<chat_user_card> createState() => _chat_user_cardState();
}

class _chat_user_cardState extends State<chat_user_card> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage()));
        },
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: CachedNetworkImage(
                imageUrl: widget.user.image,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person),),
              ),
            ),
            // user name
            title: Text(widget.user.name,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700),),
          ),
      ),
    );
  }
}
