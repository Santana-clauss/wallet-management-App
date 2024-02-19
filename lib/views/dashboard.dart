import 'package:flutter/material.dart';

void main() {
  runApp(FarmerPortalApp());

}

class FarmerPortalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmer Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FarmerDashboard(),
    );
  }
}

class FarmerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Portal'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return ['Edit Profile', 'Settings', 'Logout'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                // Navigate to dashboard
              },
            ),
            ListTile(
              title: Text('My Profile'),
              onTap: () {
                // Navigate to profile
              },
            ),
            ListTile(
              title: Text('List Produce'),
              onTap: () {
                // Navigate to list produce
              },
            ),
          ],
        ),
      ),
      body: FarmerOverview(),
    );
  }
}

class FarmerOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Total Produce Listed: 10'),
          Text('Messages Unread: 2'),
          Text('Recent Activity: ...'),
          // Add more widgets for overview
        ],
      ),
    );
  }
}
