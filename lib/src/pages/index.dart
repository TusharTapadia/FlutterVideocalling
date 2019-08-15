import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';
import 'package:flare_flutter/flare_actor.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new IndexState();
  }
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textfield is validated to have error
  bool _validateError = false;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
        body: Center(
          child : Stack(
        // fit: StackFit.expand,
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
         Container(
           padding: EdgeInsets.only(top: 30
            ),
            child: FlareActor(
              "assets/earthlogin.flr",
              alignment: Alignment.center,
              fit: BoxFit.cover,
              animation: "Preview2",
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 400
            ),
            alignment: Alignment.center,
            width: 200,
            child: ListView(
              children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: TextField(
                      controller: _channelController,
                      decoration: InputDecoration(
                          errorText: _validateError
                              ? "Channel ID Incorrect"
                              : null,
                          border: InputBorder.none,
                          labelText: 'Channel ID',
                          prefixIcon: Icon(Icons.account_circle),
                          ),
                    ),
          ),
           Container(
            child: RaisedButton(
                              
                              onPressed: () => onJoin(),
                              child: Text("Join Call"),
                              color: Colors.black,
                              textColor: Colors.white,
                   ),
          ),
              ]
            )
          ),
        ],
      )
      ),
      );
  }

  onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty && _channelController.text =='ZeZe') {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new CallPage(
                    channelName: _channelController.text,
                  )));
    }
    else
    {
       _validateError = true;
    }
  }

  _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);
  }
}
