import 'package:flutter/material.dart';
import '../page/detail_page.dart';
import '../page/home_page.dart';
import '../provider/detail_notifier.dart';
import '../provider/home_notifier.dart';
import 'package:provider/provider.dart';

import 'service/asset_service.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  final AssetService assetService = AssetService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeNotifier(assetService)),
        ChangeNotifierProvider(create: (_) => DetailNotifier(assetService)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        /// navigation and route
        initialRoute: MyHomePage.route,
        routes: {
          MyHomePage.route: (_) => const MyHomePage(),
          DetailPage.route: (context) => DetailPage(
                argument: ModalRoute.of(context)!.settings.arguments as DetailPageArgument,
              ),
        },
      ),
    );
  }
}
