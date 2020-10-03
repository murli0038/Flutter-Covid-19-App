import 'dart:async';
import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:covid_19/Detail.dart';
import 'package:intl/intl.dart';
import 'package:covid_19/info_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
// import 'package:lottie/lottie.dart';
import 'MyHeader.dart';
import 'constant.dart';
import 'package:covid_19/Counter.dart';
import 'package:country_calling_code_picker/picker.dart';

void main() {
  runApp(MyApp());
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4486DA),
      body: Center(
          // child: Lottie.asset('assets/animation/covid.zip',
          //     fit: BoxFit.fill),
          ),
    );
    // return Container(
    //   color: Colors.red,
    //   alignment: Alignment.center,
    // );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(body1: TextStyle(color: kBodyTextColor))),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  Country newCountry;
  HomeScreen({this.newCountry});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;

  String countryName = "India";
  // String countryImage = "flag/India.png";
  Country _selectedCountry;
  var date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCountry();
    setState(() {
      getTime(countryName);
      getTime(countryName);
    });
    // getTime(countryName);
    // getTime(countryName);
    date = DateFormat.yMMMd().format(new DateTime.now());
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    getTime(countryName);
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
      getTime(countryName);
    });
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
      countryName = _selectedCountry.name;
      // countryImage = _selectedCountry.flag;
    });
  }

  void _onPressedShowDialog() async {
    final country = await showCountryPickerDialog(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
        countryName = _selectedCountry.name;
        // countryImage = _selectedCountry.flag;
        // print(_selectedCountry.flag);
        getTime(countryName);
      });
    }
  }

  int infected;
  int death;
  int recovered;

  Future<void> getTime(String con) async {
    try {
      Response responce =
          await get("https://corona.lmao.ninja/v2/countries/$con");
      Map myData = jsonDecode(responce.body);
      // print(myData);

      setState(() {
        infected = myData["todayCases"];
        death = myData["todayDeaths"];
        recovered = myData["todayRecovered"];
      });

      // print(myData);
      // String dateTime = myData["datetime"];
      // String offset = myData["utc_offset"].substring(1, 3);

      // print(dateTime);
      // print(offset);

      // DateTime now = DateTime.parse(dateTime);
      // now = now.add(Duration(hours: int.parse(offset)));

      //set the time
      // isDayTime = now.hour > 6 && now.hour < 10 ? true : false;
      // time = DateFormat.jm().format(now);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              offset: offset,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  Expanded(
                      child: GestureDetector(
                    onTap: _onPressedShowDialog,
                    child: Text(
                      countryName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Detail(
                      conName: countryName,
                    );
                  }),
                );
              },
              child: Text(
                "Go for Information >>",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text: "Newest update $date",
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      // Text(
                      //   "See details",
                      //   style: TextStyle(
                      //     color: kPrimaryColor,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          colour: kInfectedColor,
                          number: infected,
                          title: "Infected",
                        ),
                        Counter(
                          colour: kDeathColor,
                          number: death,
                          title: "Deaths",
                        ),
                        Counter(
                          colour: kRecovercolor,
                          number: recovered,
                          title: "Recovered",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextstyle,
                      ),
                      // Text(
                      //   "See details",
                      //   style: TextStyle(
                      //     color: kPrimaryColor,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Country'),
      ),
      body: Container(
        child: CountryPickerWidget(
          showSeparator: false,
          onSelected: (country) => Navigator.pop(context, country),
          // onSelected: (country) => Navigator.push(context, MaterialPageRoute(builder:(context){
          //   return HomeScreen(
          //     newCountry: country,
          //   );}
          // ),)
        ),
      ),
    );
  }
}
