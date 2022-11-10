import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/ApiModel/allChatsHolderResponse.dart';
import 'package:radda_moodle_learning/Helper/CustomScaffold.dart';
import 'package:radda_moodle_learning/Screens/category_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';

class ContactComponents extends StatefulWidget {
  List<Conversations> chatHolderList;
  ContactComponents(this.chatHolderList);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<ContactComponents> {
  List<dynamic> categoryList = [];
  List<dynamic> subCategoryList = [];
  String token = '';
  double value = 0;
  NetworkCall networkCall = NetworkCall();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(0, 5, 1),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0E0E95),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Contacts',
              style: GoogleFonts.comfortaa(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          centerTitle: false,
        ),
        backgroundColor: const Color(0xFF0E0E95),
        body: Column(
          children: <Widget>[
            Container(
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
                children: [
                  Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/rectangle_bg.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: [
                        SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFFE7EAEC),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  Text('Your contacts', textAlign: TextAlign.center,style: GoogleFonts.comfortaa(
                                  color: const Color(0xFF01A9B8)) ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFFE7EAEC),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  Text('Requests', textAlign: TextAlign.center,style: GoogleFonts.comfortaa(
                                  color: const Color(0xFF01A9B8)) ),
                            ),
                          ],
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
                  SizedBox(height: 10,),
                  Expanded(
                    child: Padding(
                        padding:
                        const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: ListView.builder(
                            itemCount: widget.chatHolderList.length,
                            itemBuilder: (context, index) {
                              final mChatData = widget.chatHolderList[index];

                              return buildChatHolderList(mChatData);
                            })),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    setState(() {
    });
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
        visible: mChatData.subname !=null?mChatData.members.length>0?mChatData.members.first.iscontact?true:false:false:false,
        child: Card(
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(mChatData.members.length>0?mChatData.members.first.fullname.toString():'Not found',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.comfortaa(
                                      color: mChatData.isread?Colors.black:Colors.blueAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Icon(Icons.more_vert, color: Colors.black,)
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text( mChatData.subname.toString(),
                            style: GoogleFonts.comfortaa(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
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
