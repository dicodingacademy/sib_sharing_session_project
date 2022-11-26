import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../page/detail_page.dart';
import '../page/home_page.dart';
import '../provider/detail_notifier.dart';
import '../provider/home_notifier.dart';
import 'package:provider/provider.dart';

import 'service/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ApiService apiService = ApiService(
    Client(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeNotifier(apiService)),
        ChangeNotifierProvider(create: (_) => DetailNotifier(apiService)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MyHomePage.route,
        routes: {
          MyHomePage.route: (_) => const MyHomePage(),
          DetailPage.route: (context) => DetailPage(
                argument: ModalRoute.of(context)!.settings.arguments
                    as DetailPageArgument,
              ),
        },
      ),
    );
  }
}
