import 'package:covid_tracker_app/Models/world_states_model.dart';
import 'package:covid_tracker_app/Services/stats_services.dart';
import 'package:covid_tracker_app/view/countries.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Reusable Widgets/reusable_row.dart';

class WorldStatScreen extends StatefulWidget {
  const WorldStatScreen({super.key});

  @override
  State<WorldStatScreen> createState() => _WorldStatScreenState();
}

class _WorldStatScreenState extends State<WorldStatScreen> with TickerProviderStateMixin{

  late final AnimationController _controller=AnimationController(
    duration:const Duration(seconds: 3),
    vsync: this
  );

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList=[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];

  @override
  Widget build(BuildContext context) {
    WorldStatsServices worldStatsServices=WorldStatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
            FutureBuilder(
                future: worldStatsServices.fetchWorldStats(),
                builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                        child: SpinKitFadingCircle(
                          controller: _controller,
                          color: Colors.white,
                          size: 50.0,
                        )
                    );
                  }else{
                    return Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*.01,),
                        PieChart(
                          dataMap:  {
                            'total':double.parse(snapshot.data!.cases.toString()),
                            'recovered':double.parse(snapshot.data!.recovered.toString()),
                            'deaths':double.parse(snapshot.data!.deaths.toString()),
                          },
                          animationDuration:const Duration(milliseconds: 1200),
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width/3,

                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.03),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                ReusableRow(title: 'Actives', value: snapshot.data!.active.toString()),
                                ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString())
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountryScreen(),),);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height*.07,
                            width: MediaQuery.of(context).size.width/1.1,
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text("Track Countries",style: TextStyle(fontWeight: FontWeight.w900),),),
                          ),
                        )
                      ],
                    );
                  }
                })
            ],
          ),
        ),
      ),
    );
  }
}



