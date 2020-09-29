import 'package:flutter/material.dart';
import 'package:clearnursing/screens/pages/google-sign-in.dart';
import 'package:clearnursing/screens/pages/login-page.dart';
import 'package:clearnursing/screens/pages/about-developer.dart';
import 'package:clearnursing/screens/pages/feature-request.dart';
import 'package:clearnursing/widgets/messaging-widget.dart';
import 'package:package_info/package_info.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;

    // Other data you can get:
    //
    // 	String appName = packageInfo.appName;
    // 	String packageName = packageInfo.packageName;
    //	String buildNumber = packageInfo.buildNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
          primaryColor: Theme.of(context).highlightColor,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                UserProfileInfo(),
                const SizedBox(height: 20.0),
                ThemeInfo(),
                ProfileCategoryInfo(),
                // PracticeRemiderPreference(),
                ListTile(
                  title: Text("Application Version"),
                  subtitle: FutureBuilder(
                      future:
                          getVersionNumber(), // The async function we wrote earlier that will be providing the data i.e vers. no
                      builder: getApplicationVersion // The widget using the data
                      ),
                  trailing: Icon(
                    Icons.system_update_alt,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () {},
                ),
                AboutAppInfo(),
                RequestFeature(),
                LogoutTile(),
                SizedBox(height: 200, child: MessagingWidget())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getApplicationVersion(BuildContext context,
                            AsyncSnapshot<String> snapshot) =>
                        Text(
                          snapshot.hasData
                              ? snapshot.data
                              : "Loading version",
                        );
}

class LogoutTile extends StatelessWidget {
  const LogoutTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Logout"),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Logout"),
                content: Text("Are you sure you want to log out?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Logout'),
                    onPressed: () {
                      signOutGoogle();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }), ModalRoute.withName('/'));
                    },
                  ),
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}

class AboutAppInfo extends StatelessWidget {
  const AboutAppInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("About"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutDeveloper()),
        );
      },
    );
  }
}

class RequestFeature extends StatelessWidget {
  const RequestFeature({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Request a Feature"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeatureRequest()),
        );
      },
    );
  }
}

class PracticeRemiderPreference extends StatelessWidget {
  const PracticeRemiderPreference({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text("Practice reminder"),
      subtitle: Text(
        "Off",
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      value: false,
      onChanged: (val) {},
    );
  }
}

class ProfileCategoryInfo extends StatelessWidget {
  const ProfileCategoryInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Profile Category"),
      subtitle: Text(
        "Learner",
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).accentColor,
      ),
      onTap: () {},
    );
  }
}

class ThemeInfo extends StatelessWidget {
  const ThemeInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Theme"),
      subtitle: Text(
        "System Default",
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).accentColor,
      ),
      onTap: () {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Theme automatically changes according to your device\'s dark mode settings.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Theme.of(context).highlightColor,
        ));
      },
    );
  }
}

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageUrl != null
                  ? NetworkImage(
                      imageUrl,
                    )
                  : Image(
                      image: AssetImage(
                        'assets/google.png',
                      ),
                      fit: BoxFit.cover,
                    ),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: Theme.of(context).highlightColor,
              width: 2.0,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
