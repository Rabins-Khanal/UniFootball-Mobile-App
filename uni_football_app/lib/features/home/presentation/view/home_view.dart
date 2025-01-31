import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Static data for news and standings
    final List<String> news = [
      "Breaking News: Football season starts!",
      "Latest Match Results: Team A vs Team B",
      "Player Transfer Update: Big moves happening!"
    ];

    final List<Map<String, String>> standings = [
      {"team": "Team A", "points": "45"},
      {"team": "Team B", "points": "40"},
      {"team": "Team C", "points": "35"},
      {"team": "Team D", "points": "30"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('UniFootball'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout code (optional)
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
                Tab(icon: Icon(Icons.book), text: 'News'),
                Tab(icon: Icon(Icons.group), text: 'Standings'),
                Tab(icon: Icon(Icons.account_circle), text: 'Account'),
              ],
              labelColor: Colors.cyan,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDashboard(news),
                  _buildNewsSection(news),
                  _buildStandingsSection(standings),
                  _buildAccountSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard(List<String> news) {
    // Reusing the same content as the news section
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                news[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.cyan,
              ),
              onTap: () {
                // Handle news tap, maybe navigate to detailed view
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsSection(List<String> news) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                news[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.cyan,
              ),
              onTap: () {
                // Handle news tap, maybe navigate to detailed view
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildStandingsSection(List<Map<String, String>> standings) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: standings.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                "${standings[index]['team']} - ${standings[index]['points']} Points",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.star,
                color: index < 3 ? Colors.cyan : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAccountSection() {
    return Center(
      child: Text(
        "Account Settings",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
      ),
    );
  }
}
