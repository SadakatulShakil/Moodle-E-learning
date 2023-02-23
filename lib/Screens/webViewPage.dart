import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Helper/colors_class.dart';

class WebViewPage extends StatefulWidget {
  String? url;
  String? title;
  WebViewPage(this.url, this.title);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  late WebViewController _controller;
  late FutureBuilder<WebViewController> _controller1;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      print("hhhhhhhhhhhhhhhh"+widget.url.toString());
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PrimaryColor,
        title: Text(widget.title.toString(),
            style: GoogleFonts.comfortaa(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (_controller) {
              this._controller = _controller;

            },
            onPageFinished: (finish) {

              _controller.runJavascriptReturningResult("document.getElementsByClassName('inner_page_breadcrumb ccn_breadcrumb_default  ccn-clip-lx2  ccn-caps-capitalize  ccn-breadcrumb-title-v  ccn-breadcrumb-trail-v ')[0].style.display='none'");
              _controller.runJavascriptReturningResult("document.getElementsByClassName('mobile-menu')[0].style.display='none'");
              _controller.runJavascriptReturningResult("document.getElementsByClassName('footer_one  ')[0].style.display='none'");
              _controller.runJavascriptReturningResult("document.getElementsByClassName('footer_middle_area p0  ')[0].style.display='none'");
              _controller.runJavascriptReturningResult("document.getElementsByClassName('footer_bottom_area pt25 pb25  ')[0].style.display='none'");
              _controller.runJavascriptReturningResult("document.getElementsByClassName('mt-3')[0].style.display='none'");
              _controller.runJavascriptReturningResult("document.getElementsByClassName('tdu btn-fpswd float-right')[0].style.display='none'");
              _controller.runJavascriptReturningResult("document.getElementsByClassName('mt-5 mb-5 activity-navigation')[0].style.display='none'");
              isLoading = false;
              setState(() {
              });
            },
          ),
          Container(
            color: PrimaryColor,
            width: MediaQuery.of(context).size.width,
            height: 100,
              child: Align(
                alignment: Alignment.center,
                  child: Text('To verify content \n Login your account again', style: GoogleFonts.nunito(fontSize: 25, color:Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))),
          isLoading ? Center( child: CircularProgressIndicator(),)
              : Stack(),
        ],
      ),
    );
  }

}
