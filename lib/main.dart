import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3_app/controller/app_controller.dart';
import 'package:sqlite3_app/services/db_data/db_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBData.db.initdb();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ctr(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Provider.of<ctr>(context, listen: true).studentList.isEmpty
              ? const CircularProgressIndicator()
              : Text(
                  Provider.of<ctr>(context).studentList.toString(),
                ),
        ),
      ),
    );
  }
}
