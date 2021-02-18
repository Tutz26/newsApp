import 'package:flutter/material.dart';
import 'package:newsapp/pages/tabs_page.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:newsapp/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new NewsService())
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: TabsPage()
      ),
    );
  }
}
