import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:mpesa_test/secret/secret_loader.dart';
import 'package:mpesa_test/secret/secret_model.dart';

void main() {

  Future<Secret> secret = SecretLoader(secretPath: "secrets.json").load();


  //Mpesa setup for consumer key and secret
  MpesaFlutterPlugin.setConsumerKey('zvCBe6GmGFGDJjbXmGWhatcMwg2ntzOd');
  MpesaFlutterPlugin.setConsumerSecret('iPiAOCw99a6zOMQV');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Future<void> lipaNaMpesa() async {
    dynamic transactionInitialisation;

    String phoneNumber = phoneInputController.text;
    phoneNumber = phoneNumber.substring(1);


    try {
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: double.parse(priceInputController.text),
          partyA: "254"+phoneNumber,
          partyB: "174379",
          callBackURL: Uri(
            scheme: 'http',
            host: 'mpesa-requestbin.herokuapp.com',
            path: '/sno353sn',),
          accountReference: "Otieno Leon Hagai",
          phoneNumber: "254"+phoneInputController.text,
          baseUri: Uri(scheme: 'http', host: 'sandbox.safaricom.co.ke'),
          transactionDesc: "purchase",
          passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
      print("transaction result: "+ transactionInitialisation.toString());
      return transactionInitialisation;
    } catch (e) {
      print("Caught Exception" + e.toString());
    }
  }

  final TextEditingController phoneInputController = new TextEditingController();
  final TextEditingController priceInputController = new TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xFF481E4D)),
        home: Scaffold(appBar: AppBar(
          title: Text('Mpesa Payment Demo'),
          centerTitle: true,
        ),

            body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: phoneInputController,
                        decoration: InputDecoration(
                          hintText: '+254 712345678'
                        ),
                      ),
                      TextField(
                        controller: priceInputController,
                        decoration: InputDecoration(
                            hintText: 'price'
                        ),
                      ),
                      RaisedButton(
                          color: Color(0xFF481E4D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            lipaNaMpesa();
                          },
                          child: Text("Lipa na Mpesa",
                            style: TextStyle(color: Colors.white),
                          ),
                      ),
                    ],
                  ),
                ),
            ),
        ),
    );
  }
}
