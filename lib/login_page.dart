import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);

  FacebookUSerData? facebookUSerData;

  void getFacebookProfile() async {
    // await FacebookAuth.instance.login(
    //   // permissions: ['public_profile', 'email',],
    // ).then((value) {
    //   print(value.status);
    //   if (value.status == LoginStatus.success) {
    //     // you are logged
    //     final AccessToken accessToken = value.accessToken!;
    //   } else {
    //     print(value.status);
    //     print(value.message);
    //   }
    // }).catchError((error) {
    //   print(error.toString());
    // });

    await FacebookAuth.instance.getUserData().then((value) {
      print(value.toString());
      facebookUSerData = FacebookUSerData.fromJson(value);
      print('parsed');
      print(facebookUSerData!.name);
      print(facebookUSerData!.email);
      print(facebookUSerData!.pictureData.url);
      print(facebookUSerData!.id);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FaceBook Auth',style: Theme.of(context).textTheme.headline6!.copyWith(
          color: Colors.white,
        ),),
      ),
      body: Center(
        child: IconButton(
          onPressed: () {
            getFacebookProfile();
          },
          icon: const Icon(
            Icons.facebook_rounded,
            size: 30,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class FacebookUSerData {
  late final String name;
  late final String email;
  late final String id;
  late final PictureData pictureData;

  FacebookUSerData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    id = json['id'];
    pictureData = PictureData.fromJson(json['picture']['data']);
  }
}

class PictureData {
  late final String url;

  PictureData.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}
