import 'package:famdoc_user/screens/edit_profile.dart';
import 'package:famdoc_user/screens/home_screen.dart';
import 'package:famdoc_user/user_screen_helper/profile_list_item.dart';
import 'package:flutter/material.dart';
import 'package:famdoc_user/constants.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile-screen';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kAppPrimaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [const Color(0xffbce6eb), const Color(0xFF26A69A)],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 400),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    animation:
                                    CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.elasticInOut);
                                    return ScaleTransition(
                                      alignment: Alignment.topLeft,
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return HomeScreen();
                                  },
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: AvatarImage(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //SocialIcons(),
                  SizedBox(height: 30),
                  Text(
                    'chromicle',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '@amFOSS',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Mobile App Developer and Open source enthusiastic',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  ProfileListItems(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData icon;

  const AppBarButton({this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kAppPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: kLightBlack,
              offset: Offset(1, 1),
              blurRadius: 10,
            ),
            BoxShadow(
              color: kWhite,
              offset: Offset(-1, -1),
              blurRadius: 10,
            ),
          ]),
      child: Icon(
        icon,
        color: fCL,
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(2),
      //decoration: avatarDecoration,
      child: Container(
        //decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('images/user.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            child: ProfileListItem(
              icon: Icons.verified_user,
              text: 'Edit Profile',
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 400),
                    transitionsBuilder:
                        (context, animation, animationTime, child) {
                      CurvedAnimation(
                          parent: animation, curve: Curves.easeInToLinear);
                      return ScaleTransition(
                        alignment: Alignment.centerRight,
                        scale: animation,
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, animationTime) {
                      return EditProfileScreen();
                    },
                  ));
            },
          ),
          ProfileListItem(
            icon: Icons.connect_without_contact,
            text: 'Connections',
          ),
          ProfileListItem(
            icon: Icons.attach_money,
            text: 'Purchase History',
          ),
          ProfileListItem(
            icon: Icons.question_answer_outlined,
            text: 'Help & Support',
          ),
          ProfileListItem(
            icon: Icons.settings,
            text: 'Settings',
          ),
          ProfileListItem(
            icon: Icons.logout,
            text: 'Logout',
            hasNavigation: false,
          ),
        ],
      ),
    );
  }
}
