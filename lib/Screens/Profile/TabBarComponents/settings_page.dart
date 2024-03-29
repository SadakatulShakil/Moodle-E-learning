import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiCall/HttpNetworkCall.dart';
import '../../../Helper/operations.dart';
import '../../forget_password_page.dart';

class ProfileSettingsPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<ProfileSettingsPage> {
  NetworkCall networkCall = NetworkCall();
  List<dynamic> profileInfoList = [];
  List<dynamic> courseList = [];
  String name ='';
  String firstName ='';
  String surName ='';
  String email ='';
  String city ='';
  String language ='';
  String startDate ='';
  String lastDate ='';
  List <String> languageList = [
    'English',
    'Bangla'
  ];
  List <String> cityList = [
    'Dhaka',
    'Faridpur',
    'Gazipur',
    'Gopalganj',
    'Jamalpur',
    'Kishoreganj',
    'Madaripur',
    'Manikganj',
    'Munshiganj',
    'Mymensingh',
    'Narayanganj',
    'Narsingdi',
    'Netrokona',
    'Rajbari',
    'Shariatpur',
    'Sherpur',
    'Tangail',
    'Bogura',
    'Joypurhat',
    'Naogaon',
    'Natore',
    'Nawabganj',
    'Pabna',
    'Rajshahi',
    'Sirajgonj',
    'Dinajpur',
    'Gaibandha',
    'Kurigram',
    'Lalmonirhat',
    'Nilphamari',
    'Panchagarh',
    'Rangpur',
    'Thakurgaon',
    'Barguna',
    'Barishal',
    'Bhola',
    'Jhalokati',
    'Patuakhali',
    'Pirojpur',
    'Bandarban',
    'Brahmanbaria',
    'Chandpur',
    'Chattogram',
    'Cumilla',
    'Coxs Bazar',
    'Feni',
    'Khagrachari',
    'Lakshmipur',
    'Noakhali',
    'Rangamati',
    'Habiganj',
    'Maulvibazar',
    'Sunamganj',
    'Sylhet',
    'Bagerhat',
    'Chuadanga',
    'Jashore',
    'Jhenaidah',
    'Khulna',
    'Kushtia',
    'Magura',
    'Meherpur',
    'Narail',
    'Satkhira',
  ];
  List <String> countryList = [
    'Bangladesh',
    'India'
  ];
  String? _selectedLanguage;
  String? _selectedCity;
  String _selectedCountry = 'Bangladesh';
  bool generalVisibility = false;
  bool changePasswordVisibility = false;
  bool _passwordVisible =false;

  final firstNameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedData();
  }


  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFF1F1FA),
        body:  SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  print('---------------- '+ 'clicked');
                  changePasswordVisibility = false;
                  generalVisibility?generalVisibility = false:generalVisibility = true;
                  setState(() {});
                },
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 18, bottom: 12),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("General",
                                style: GoogleFonts.nanumGothic(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0, top: 5),
                          child: SvgPicture.asset("assets/vectors/arrow_down.svg"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: generalVisibility? true:false,
                child: Column(
                  children: [
                    SizedBox(height: 18,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text("First name",
                            style: GoogleFonts.nanumGothic(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextField(
                        controller: firstNameController..text = firstName,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                            hintText: 'Enter first name',hintStyle: GoogleFonts.nanumGothic(
                          color: Colors.black,
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text("Last name",
                            style: GoogleFonts.nanumGothic(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextField(
                        controller: surnameController..text = surName,
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                            hintText: 'Enter last name',hintStyle: GoogleFonts.nanumGothic(
                          color: Colors.black,
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text("Email address",
                            style: GoogleFonts.nanumGothic(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextField(
                        controller: emailController..text = email,
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                            hintText: 'Enter email address',hintStyle: GoogleFonts.nanumGothic(
                          color: Colors.black,
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Text("City/town",
                            style: GoogleFonts.nanumGothic(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextField(
                        controller: city == 'null'?(cityController..text = ""):(cityController..text = city),
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                            hintText: 'Enter city',hintStyle: GoogleFonts.nanumGothic(
                          color: Colors.black,
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Text("Country",
                            style: GoogleFonts.nanumGothic(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child:DropdownButton<String>(
                          // Not necessary for Option 1
                          hint: Text('Bangladesh',
                            style: GoogleFonts.nanumGothic(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          value: _selectedCountry,
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            _selectedCountry = newValue!;
                            setState(() {});
                          },
                          items: countryList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: GoogleFonts.nanumGothic(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,)),
                            );
                          })
                              .toList(),
                        ),
                      ),
                    ),

                    SizedBox(height: 25,),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: InkWell(
                        onTap: (){
                          print('check settings  '+ firstNameController.text.toString());
                          OpenDialog();
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width:350,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: PrimaryColor
                            ),
                            child: Center(
                              child: Text("Save changes", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Visibility(
              //   visible: generalVisibility? false:true,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 12.0, right: 12),
              //     child: Divider(thickness: 1,),
              //   ),
              // ),
              SizedBox(height: 8,),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPasswordPage()));
                  print('---------------- '+ 'clicked');
                  setState(() {});
                },
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 18, bottom: 12),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Change password",
                                style: GoogleFonts.nanumGothic(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28,)
            ],
          ),
        )
    );
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('TOKEN')!;
    String userid = prefs.getString('userId')!;
    Future.wait([getSiteInfo(token, userid), getProfileInfo(token, userid), getAllCourses(token, userid)]);
  }

  Future getSiteInfo(String token, String userid) async{
    //CommonOperation.showProgressDialog(context, "loading", true);
    final userDetailsData = await networkCall.UserDetailsCall(token);
    if(userDetailsData != null){
      print('hospital data'+ userDetailsData.firstname.toString());
      surName = userDetailsData.lastname.toString();
      firstName = userDetailsData.firstname.toString();
      setState(() {});

    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }

  }

  Future getProfileInfo(String token, String userId) async {
    //CommonOperation.showProgressDialog(context, "loading", true);
    final profileInfoData =
    await networkCall.ProfileInfoCall(token, userId);
    if (profileInfoData != null) {
      profileInfoList = profileInfoData;
      name = profileInfoList[0].fullname.toString();
      email = profileInfoList[0].email.toString();
      _selectedLanguage = profileInfoList[0].lang.toString()=='en'?'English':'Bangla';
      city = profileInfoList[0].city.toString();
      print('data_count1 ' + profileInfoList.first.toString());
      setState(() {});
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
  Future getAllCourses(String token, String userId) async {
    //CommonOperation.showProgressDialog(context, "loading", true);
    final userCoursesData =
    await networkCall.UserCoursesListCall(token, userId);
    if (userCoursesData != null) {
      courseList = userCoursesData;
      print('data_count1 ' + courseList[0].fullname.toString());
      setState(() {});
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  OpenDialog() {
    print(',,,,,,,,,,,,,,,,,,,,,');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert !'),
            content: Container(
              height: 120.0, // Change as per your requirement
              width: MediaQuery.of(context).size.width/3,
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Text('Are you sure to update the information? '),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCalenderEventPage()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width:120,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: Text("Cancel", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCalenderEventPage()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width:120,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: SecondaryColor,
                        ),
                        child: Center(
                          child: Text("Ok", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
