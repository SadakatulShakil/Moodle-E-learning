import 'package:flutter/material.dart';

class MessageRecentPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<MessageRecentPage> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {

    return Scaffold(
        body:  Center(child: Text('MessageRecentPage'))
    );
  }
}
