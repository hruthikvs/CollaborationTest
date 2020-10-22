import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class launchurl extends StatelessWidget {




  void _showMail(){
    _launch('mailto:cpshsr10@gmail.com');

  }
  

  void _showPhone() {
    _launch('tel:9620150366');
  }

  void _launch(String urlString) async{
    if(await canLaunch(urlString)) {
      await launch(urlString);
    }
      else{
        print('wrong string');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hi'),),
      body: Container(

        child: Column(
          children: <Widget>[
            FlatButton(
              color: Colors.red,


                onPressed: _showMail,child: Text('mail'),),

            FlatButton(onPressed: _showPhone,child: Text('phone'),),
        
          ],
        ),
      ),
    );
  }
}
