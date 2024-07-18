import 'package:flutter/material.dart';
import 'package:foodie/features/home%20tab/widgets/my__order_tile.dart';

class MyOrdersPage extends StatefulWidget {
  static const routeName = '/my-orders-page';
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

TabBar get _tabBar => const TabBar(
      tabs: [
        Tab(
          child: Text('Upcoming Orders'),
        ),
        Tab(
          child: Text('History'),
        ),
      ],
    );

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Orders'),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              child: _tabBar,
            ),
          ),
        ),
        body: const Column(
          children: [
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  UpcomingOrders(),
                  History(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingOrders extends StatelessWidget {
  const UpcomingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          MyOrderTile(orderStatus: 'On the way'),
          MyOrderTile(orderStatus: 'Preparing'),
          MyOrderTile(orderStatus: 'Preparing'),
        ],
      ),
    );
  }
}

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          MyOrderTile(orderStatus: 'Delivered'),
          MyOrderTile(orderStatus: 'Delivered'),
          MyOrderTile(orderStatus: 'Delivered'),
        ],
      ),
    );
  }
}
