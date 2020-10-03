import 'dart:convert';

import 'package:covid_19/Counter.dart';
import 'package:covid_19/MyHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'constant.dart';

class Detail extends StatefulWidget
{
  String conName;

  Detail({Key key, this.conName}) : super(key: key);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail>
{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getInformation(widget.conName);
    });
  }

  String cases = "Loading...";
  String todayCases = "Loading...";
  String deaths = "Loading...";
  String todayDeaths = "Loading...";
  String recovered = "Loading...";
  String todayRecovered = "Loading...";
  String active = "Loading...";
  String critical = "Loading...";
  String casesPerOneMillion = "Loading...";
  String deathsPerOneMillion = "Loading...";
  String tests = "Loading...";
  String testsPerOneMillion = "Loading...";
  String population = "Loading...";
  String oneCasePerPeople = "Loading...";
  String oneDeathPerPeople = "Loading...";
  String oneTestPerPeople = "Loading...";
  String activePerOneMillion = "Loading...";
  String recoveredPerOneMillion = "Loading...";
  String criticalPerOneMillion = "Loading...";
  String continent = "Loading...";
  String flag = "Loading...";
  double offset = 0;

  Future<void> getInformation(String con) async {
    try {
      Response responce =
      await get("https://corona.lmao.ninja/v2/countries/$con");
      Map fetchData = jsonDecode(responce.body);
      print(fetchData);

      setState(()
      {
        flag = fetchData["countryInfo"]["flag"];
        cases = fetchData["cases"].toString();
        todayCases = fetchData["todayCases"].toString();
        deaths = fetchData["deaths"].toString();
        todayDeaths = fetchData["todayDeaths"].toString();
        recovered = fetchData["recovered"].toString();
        todayRecovered = fetchData["todayRecovered"].toString();
        active = fetchData["active"].toString();
        critical = fetchData["critical"].toString();
        casesPerOneMillion = fetchData["casesPerOneMillion"].toString();
        deathsPerOneMillion = fetchData["deathsPerOneMillion"].toString();
        tests = fetchData["tests"].toString();
        testsPerOneMillion = fetchData["testsPerOneMillion"].toString();
        population = fetchData["population"].toString();
        continent = fetchData["continent"].toString();
        oneCasePerPeople = fetchData["oneCasePerPeople"].toString();
        oneDeathPerPeople = fetchData["oneDeathPerPeople"].toString();
        oneTestPerPeople = fetchData["oneTestPerPeople"].toString();
        activePerOneMillion = fetchData["activePerOneMillion"].toString();
        recoveredPerOneMillion = fetchData["recoveredPerOneMillion"].toString();
        criticalPerOneMillion = fetchData["criticalPerOneMillion"].toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  padding: EdgeInsets.only(left: 40, top: 50, right: 20),
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF4486DA),
                        Color(0xFF11249),
                      ],
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/virus.png"),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: Colors.white,
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
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Country",
                                // style: TextStyle(
                                //     fontWeight: FontWeight.w400,
                                //     fontSize: 30,
                                //     color: Colors.white
                                // ),
                                style: kSubTextStyle,
                              ),
                              Text(
                                widget.conName.substring(0,5),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.white
                                ),
                                // style: kHeadingTextStyle,
                              )
                            ],
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.redAccent,
                            backgroundImage: NetworkImage(flag)
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   // padding: EdgeInsets.all(10),
                    //   // margin: EdgeInsets.all(10),
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //     color: Colors.red,
                    //     borderRadius: BorderRadius.circular(20)
                    //   ),
                    //   child: Container(
                    //     margin: EdgeInsets.only(right: 10),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(20)
                    //     ),
                    //   ),
                    //
                    // ),
                    DetailCard(Label: "Total Cases", numbers: "$cases",),
                    DetailCard(Label: "Deaths",numbers: "$deaths",),
                    DetailCard(Label: "Today Deaths",numbers: "$todayDeaths",),
                    DetailCard(Label: "Recovered",numbers: "$recovered",),
                    DetailCard(Label: "Today Recovered", numbers: "$todayRecovered",),
                    DetailCard(Label: "Active",numbers: "$active",),
                    DetailCard(Label: "Critical", numbers: "$critical",),
                    DetailCard(Label: "casesPerOneMillion", numbers: "$casesPerOneMillion",),
                    DetailCard(Label: "deathsPerOneMillion", numbers: "$deathsPerOneMillion",),
                    DetailCard(Label: "tests", numbers: "$tests",),
                    DetailCard(Label: "testsPerOneMillion", numbers: "$testsPerOneMillion",),
                    DetailCard(Label: "population", numbers: "$population",),
                    DetailCard(Label: "continent", numbers: "$continent",),
                    DetailCard(Label: "oneCasePerPeople", numbers: "$oneCasePerPeople",),
                    DetailCard(Label: "oneDeathPerPeople", numbers: "$oneDeathPerPeople",),
                    DetailCard(Label: "oneTestPerPeople", numbers: "$oneTestPerPeople",),
                    DetailCard(Label: "activePerOneMillion", numbers: "$activePerOneMillion",),
                    DetailCard(Label: "recoveredPerOneMillion", numbers: "$recoveredPerOneMillion",),
                    DetailCard(Label: "criticalPerOneMillion", numbers: "$criticalPerOneMillion",),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({
    Key key,
    @required this.numbers, this.Label,
  }) : super(key: key);

  final String numbers;
  final String Label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 0,left: 10,right: 10,bottom: 10),
      decoration: BoxDecoration(
        // border: Border(
        //   left: BorderSide(
        //       color: Color.fromRGBO(255, 167, 38, 1),
        //       width: 5),
        //   right: BorderSide(
        //       width: .5,
        //       color: Color.fromRGBO(116, 102, 102, .5)),
        //   top: BorderSide(
        //       width: .5,
        //       color: Color.fromRGBO(116, 102, 102, .5)),
        //   bottom: BorderSide(
        //       width: .5,
        //       color: Color.fromRGBO(116, 102, 102, .5)),
        //
        // ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Label,
            style: kSubTextStyle,
          ),
          Text(
            "$numbers",
            style: kHeadingTextStyle,
          )
        ],
      ),
    );
  }
}




