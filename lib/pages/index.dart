import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:astronomy_calendar/themes/color.dart';
import 'package:http/http.dart' as http;

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List events = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "https://space-agent.herokuapp.com/";
    var response = await http.get(url);
    // print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        events = items;
        isLoading = false;
      });
    } else {
      events = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All sky events"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (events.contains(null) || events.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(primary),
      ));
    }
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return getCard(events[index], index);
        });
  }

  Widget getCard(item, index) {
    var event = item['event_' + (index + 1).toString()];
    var eventTitle = event['title'];
    var detail = event['details'];
    var eventDate = event['date'];
    var imgTheme = event['img_link'];
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Text(
                          eventTitle + "\n " + eventDate,
                          style: TextStyle(fontSize: 17),
                          overflow: TextOverflow.fade,
                        )),
                    Text(
                      detail.toString(),
                      style: TextStyle(color: Colors.grey),
                      overflow: TextOverflow.fade,
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
}
