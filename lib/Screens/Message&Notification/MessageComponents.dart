import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/ApiModel/allChatsHolderResponse.dart';
import 'package:radda_moodle_learning/Screens/Message&Notification/contact_components.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/operations.dart';

class MessageComponents extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<MessageComponents> {
  List<Map<String, dynamic>> categoryList = [
    {"name": "All chats"},
    {"name": "Group"},
    {"name": "Private"},
    {"name": "Contacts"},
  ];
  NetworkCall networkCall = NetworkCall();
  List<Conversations> chatHolderList = [];
  bool selectedCat = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getSharedData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E95),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.height / 9,
        transform: Matrix4.translationValues(0, 10, 1),
        decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25))),
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/rectangle_bg.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,top: 5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Messages", style: GoogleFonts.comfortaa(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white
                    ),),
                  ),
                )
            ),
            Container(
              height: 120,
              color: Colors.blue.shade100,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 8, right: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(categoryList.length,
                                  (index) => CategoryCard(
                                  text: categoryList[index]['name'],
                                  press: () {
                                    selectedCat = true;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactComponents(chatHolderList)));
                                    debugPrint('>>>>>>>>>>  '+categoryList[index]['name']+ ' is clicked !');
                                  }
                              )
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 8, right: 18),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        //controller: searchCtrl,
                        textInputAction: TextInputAction.go,
                        maxLines: 1,
                        minLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.blueAccent,),
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'search',
                          hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: ListView.builder(
                      itemCount: chatHolderList.length,
                      itemBuilder: (context, index) {
                        final mChatData = chatHolderList[index];

                        return buildChatHolderList(mChatData);
                      })),
            ),
            SizedBox(height: 12,)
          ],
        ),
      ),
    );
  }
  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('TOKEN')!;
    String userid = prefs.getString('userId')!;
    setState(() {
      getChatHolders(token, userid);
    });
  }

  void getChatHolders(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final chatHolderData =
    await networkCall.ChatHolderListCall(token, userId);
    if (chatHolderData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';

      chatHolderList = chatHolderData.conversations!;
      //print('data_count1 ' + chatHolderData.first.toString());
      CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
      setState(() {
        //getAllCourses(token, userId);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }
  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0 //message font size
    );
  }

  Widget buildChatHolderList(mChatData) => GestureDetector(
      onTap: () {
        /// do click item task
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CourseDetailsPage(mCourseData)));
      },
      child: Visibility(
        visible: mChatData.name.toString() == "" && !mChatData.isfavourite?false:true,
        child: Card(
          color: !mChatData.isread?Colors.grey.shade200:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    FadeInImage.assetNetwork(
                        placeholder: 'assets/images/chat_head.jpg',
                        image:  'https://www.pngkit.com/png/full/44-443934_post-navigation-people-icon-grey.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover),

                    Visibility(
                      visible: mChatData.isfavourite?true:false,
                        child: Icon(Icons.star, color: Colors.deepOrange,))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(mChatData.name.toString()==''?'--':mChatData.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.comfortaa(
                                  color: mChatData.isread?Colors.black:Colors.blueAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text( mChatData.subname.toString(),
                                style: GoogleFonts.comfortaa(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Visibility(
                              visible: !mChatData.isread?true:false,
                              child: Icon(Icons.info_rounded, color: Colors.blueAccent,))
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(
                          children: [
                            Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(mChatData.members.length>0?mChatData.members.first.fullname.toString()+':':'', style: TextStyle(color: mChatData.isread?Colors.black:Colors.blueAccent),),
          ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.8,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Html(data: mChatData.messages.length>0?mChatData.messages.first.text.toString():''),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
  );

}
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE7EAEC),
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Text(text!, textAlign: TextAlign.center,style: GoogleFonts.comfortaa(
                color: const Color(0xFF01A9B8)) ),
            ),
          ],
        ),
      ),
    );
  }
}

