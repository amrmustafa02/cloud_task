import 'package:cloud_task/services/firebase_service.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(
              15,
            )),
      ),
      body: FutureBuilder(
        future: FirebaseService.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var docs = snapshot.data;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
                return;
              },
              child: Column(
                children: [
                  Text(
                    "Number Of Notifications: ${docs!.length}",
                    style: getTextStyle().copyWith(color: Colors.black),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title -> ${docs[index].data()["title"]}",
                                style: getTextStyle(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Body -> ${docs[index].data()["body"]}",
                                style: getTextStyle(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Data -> ${docs[index].data()["data"].toString()}",
                                style: getTextStyle(),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: docs!.length,
                    ),
                  ),
                ],
              ),
            );
          }

          return SizedBox.fromSize();
        },
      ),
    );
  }

 TextStyle getTextStyle() => const TextStyle(color: Colors.white, fontSize: 18);
}
