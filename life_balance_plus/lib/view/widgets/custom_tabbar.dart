import 'package:flutter/material.dart';

class CustomTabbar extends StatelessWidget {
  final List<String> tabNames;
  final List<Widget> pages;
  const CustomTabbar({
    super.key,
    required this.pages,
    required this.tabNames,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabNames.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white38,
                  indicatorColor: Colors.white54,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white30,
                    ),
                    insets: EdgeInsets.symmetric(vertical: 10),
                  ),
                  labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        // fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  unselectedLabelStyle:
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                            letterSpacing: 1.5,
                          ),
                  tabs: tabNames.map((name) => Tab(text: name)).toList()),
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
      ),
    );
  }
}
