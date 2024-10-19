import 'package:covid_tracker_app/Services/stats_services.dart';
import 'package:covid_tracker_app/view/country_details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  TextEditingController searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    WorldStatsServices worldStatsServices=WorldStatsServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchcontroller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  hintText: 'search countries here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: worldStatsServices.countriesListApi(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return ListView.builder(
                          itemCount: 4,
                            itemBuilder: (context,index){
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white70,
                                    ),
                                    title: Container(height: 10,width: 50,color: Colors.white,),
                                    subtitle: Container(height: 10,width: 60,color: Colors.white,),
                                  ));
                            },);
                      }else{
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                            itemBuilder: (context,index){
                              String name=snapshot.data![index]['country'].toString();
                              if(searchcontroller.text.isEmpty){
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDeatilsScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'].toString(),
                                        name: snapshot.data![index]['country'].toString(),
                                        totalCases: snapshot.data![index]['todayCases'],
                                        totalDeaths: snapshot.data![index]['todayDeaths'],
                                        totalRecoveries: snapshot.data![index]['recovered'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        todayRecovries: snapshot.data![index]['todayRecovered'],
                                        test: snapshot.data![index]['tests'],
                                    )));
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(snapshot.data![index]['countryInfo']['flag'].toString()),
                                    ),
                                    title: Text(snapshot.data![index]['country'].toString(),style: const TextStyle(fontWeight: FontWeight.w900),),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  ),
                                );
                              }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDeatilsScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'].toString(),
                                      name: snapshot.data![index]['country'].toString(),
                                      totalCases: snapshot.data![index]['todayCases'],
                                      totalDeaths: snapshot.data![index]['todayDeaths'],
                                      totalRecoveries: snapshot.data![index]['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['critical'],
                                      todayRecovries: snapshot.data![index]['todayRecovered'],
                                      test: snapshot.data![index]['tests'],
                                    )));
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(snapshot.data![index]['countryInfo']['flag'].toString()),
                                    ),
                                    title: Text(snapshot.data![index]['country'].toString(),style: const TextStyle(fontWeight: FontWeight.w900),),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  ),
                                );
                              }else{
                                return Container(
                                );
                              }
                            });
                      }
                    },),),
          ],
        ),
      ),
      );
  }
}
