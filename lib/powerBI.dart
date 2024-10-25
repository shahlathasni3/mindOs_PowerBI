// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PowerBIEmbedPage extends StatefulWidget {
//   final String embedUrl;
//   final String embedToken;
//   PowerBIEmbedPage({required this.embedUrl, required this.embedToken});
//
//   @override
//   _PowerBIEmbedPageState createState() => _PowerBIEmbedPageState();
// }
//
// class _PowerBIEmbedPageState extends State<PowerBIEmbedPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Power BI Report'),
//       ),
//       body: WebView(
//         initialUrl: widget.embedUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (controller) {
//           controller.evaluateJavascript(
//               """
//             var models = window['powerbi-client'].models;
//             var embedConfiguration = {
//               type: 'report',
//               tokenType: models.TokenType.Embed,
//               accessToken: '${widget.embedToken}',
//               embedUrl: '${widget.embedUrl}',
//               id: 'your-report-id',
//               settings: {
//                 filterPaneEnabled: false,
//                 navContentPaneEnabled: false
//               }
//             };
//             var report = powerbi.embed(document.getElementById('reportContainer'), embedConfiguration);
//             """
//           );
//         },
//       ),
//     );
//   }
// }






// // Prepare Data for Power BI
// Map<String, dynamic> prepareDataForPowerBI(Map<String, dynamic> userDetails) {
//   return {
//     "name": userDetails['name'],
//     "email": userDetails['email'],
//     "lastLogin": userDetails['lastLogin'].toString(),
//     "photoUrl": userDetails['photoUrl'],
//   };
// }


// Get models so you can use the TokenType enum.
// let models = window['powerbi-client'].models;
//
// let embedConfiguration = {
//   type: 'report',
//   id: '5dac7a4a-4452-46b3-99f6-a25915e0fe55',
//   embedUrl: 'https://app.powerbi.com/reportEmbed',
//   tokenType: models.TokenType.Embed,
//   accessToken: 'h4...rf'
// };
//
// let reportContainer = $('#reportContainer')[0];
// let report = powerbi.embed(reportContainer, embedConfiguration);