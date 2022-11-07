import 'package:flutter/material.dart';

class MessageOlderPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<MessageOlderPage> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {

    return Scaffold(
        body:  Center(child: Text('MessageOlderPage'))
    );
  }
}
