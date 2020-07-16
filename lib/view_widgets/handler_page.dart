import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:random_video_app/view_widgets/get_started_home.dart';
import 'package:permission_handler/permission_handler.dart';

class HandlerPage extends StatefulWidget {

  @override
  _HandlerPageState createState() => _HandlerPageState();
}
const String testDevice ="MobileId";
//    'BFD202A824FC834E9DFCFCC73D56BE2C';
//    '1550DA0608A9A6FAAE919AA8D0E8404B';
class _HandlerPageState extends State<HandlerPage> {

  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
//    keywords: <String>['Game', 'Mario'],
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false, // or MobileAdGender.female, MobileAdGender.unknown
//    testDevices: <String>[],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId:
//        'ca-app-pub-4447765961172076/8085662634',
        BannerAd.testAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId:
//        'ca-app-pub-4447765961172076/1302145325',
        InterstitialAd.testAdUnitId,
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId:
//    'ca-app-pub-4447765961172076~2866686040');
    BannerAd.testAdUnitId);
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();

    super.initState();
  }

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Random Video Chat'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Expanded(
//                      child: TextField(
//                        controller: _channelController,
//                        decoration: InputDecoration(
//                          errorText:
//                          _validateError ? 'Channel name is mandatory' : null,
//                          border: UnderlineInputBorder(
//                            borderSide: BorderSide(width: 1),
//                          ),
//                          hintText: 'Channel name',
//                        ),
//                      ))
//                ],
//              ),
              Column(
                children: [
                  ListTile(
                    title: Text(ClientRole.Broadcaster.toString()),
                    leading: Radio(
                      value: ClientRole.Broadcaster,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(ClientRole.Audience.toString()),
                    leading: Radio(
                      value: ClientRole.Audience,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            onPressed: onJoin,
                            child: Text('Join'),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            onPressed: (){
                              createInterstitialAd()
                                ..load()
                                ..show(
//                                  anchorType: AnchorType.bottom,
//                                  anchorOffset: 0.0,
//                                  horizontalCenterOffset: 0.0,
                                );
                            },
                            child: Text('Click Ads'),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {

    // update input validation
    setState(() {
      // show firebase admob result=====>>>>>
//      _channelController.text.isEmpty
//          ? _validateError = true
//          : _validateError = false;
    });
//    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            channelName: "abc",
            role: _role,
          ),
        ),
      );
//    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
