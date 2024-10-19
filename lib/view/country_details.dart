import 'package:covid_tracker_app/view/world_stats.dart';
import 'package:flutter/material.dart';

import '../Reusable Widgets/reusable_row.dart';

class CountryDeatilsScreen extends StatefulWidget {
  String image,name;
  int totalCases,totalDeaths,totalRecoveries,active,critical,todayRecovries,test;
   CountryDeatilsScreen({
     super.key,
     required this.image,
     required this.name,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecoveries,
     required this.active,
     required this.critical,
     required this.todayRecovries,
     required this.test,
   });

  @override
  State<CountryDeatilsScreen> createState() => _CountryDeatilsScreenState();
}

class _CountryDeatilsScreenState extends State<CountryDeatilsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name,style: const TextStyle(fontWeight: FontWeight.w900),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.06 ,
                      ),
                      ReusableRow(title: 'Test', value: widget.test.toString()),
                      ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReusableRow(title: 'Recovered', value: widget.totalRecoveries.toString()),
                      ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(title: 'Today Recovries', value: widget.todayRecovries.toString()),
                    ],
                  ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(widget.image),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
