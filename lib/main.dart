import 'package:flutter/material.dart';
import 'package:flutter_app_chopper/data/post_api_service.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => PostApiService.create(),
      dispose: (_,PostApiService service) => service.client.dispose(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home:HomePage(),
      ),
    );
  }
}
