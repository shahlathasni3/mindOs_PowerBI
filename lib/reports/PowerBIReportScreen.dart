import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindos_2/homePage.dart';
import 'package:url_launcher/url_launcher.dart';

class PowerBIReportButton extends StatelessWidget {
  // final String url = 'https://app.powerbi.com/reportEmbed?reportId=aac35aba-c3a4-46ff-98c8-f102486cbee7&autoAuth=true&ctid=a84203e7-39a7-4808-ae0e-b3ae884790d0';
  // final String url = 'https://app.powerbi.com/reportEmbed?reportId=76bc3d38-377e-4ea4-9e71-a28d70318b18&autoAuth=true&ctid=a84203e7-39a7-4808-ae0e-b3ae884790d0';
  final String url = 'https://app.powerbi.com/reportEmbed?reportId=685f8d09-5083-4b43-8bc8-e01b4fb93b33&autoAuth=true&ctid=e5f26169-317c-4268-bc6c-11f2f561abaa';  // windows 11 powerbi. newe username.

  void _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _launchURL,
          child: Text('Open Power BI Report'),
        ),
        ElevatedButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
          child: Text('Back to Home'),
        ),
      ],
    );
  }
}

