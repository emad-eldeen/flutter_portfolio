import 'package:flutter/material.dart';
import 'package:portfolio/common/theme.dart';
import 'package:portfolio/main_view.dart';
import 'package:portfolio/models/active_page.dart';
import 'package:portfolio/nav_panel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: appTheme,
      home: ChangeNotifierProvider(
        create: (context) => ActivePage(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // on page change
    controller.addListener(() {
      // get page index
      int? pageIndex = controller.page?.round();
      // get ActivePage object
      var activePage = context.read<ActivePage>();
      activePage.index = pageIndex;
    });
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: NavPanel(
                controller: controller,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: MainView(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
