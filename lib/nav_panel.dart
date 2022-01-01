import 'package:flutter/material.dart';
import 'package:portfolio/common/page_transition.dart';
import 'package:portfolio/models/active_page.dart';
import 'package:provider/provider.dart';

class NavPanel extends StatelessWidget {
  const NavPanel({Key? key, required this.controller}) : super(key: key);
  static const List<String> entries = <String>['AAAA', 'BBBBBB', 'CCCCCCC'];
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: entries.map((item) {
            final itemIndex = entries.indexOf(item);
            return NavItem(
              sectionName: item,
              sectionIndex: itemIndex,
              controller: controller,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.sectionName,
    required this.sectionIndex,
    required this.controller,
  }) : super(key: key);
  final String sectionName;
  final int sectionIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // on click, go to page
            controller.animateToPage(
              sectionIndex,
              duration: PageTransition.duration,
              curve: PageTransition.curve,
            );
          },
          child: Text(
            sectionName,
            // check if it is the current active section
            style: context.watch<ActivePage>().index == sectionIndex
                ? Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Theme.of(context).primaryColor)
                : Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
