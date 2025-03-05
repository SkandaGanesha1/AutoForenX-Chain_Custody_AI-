import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class JudgeDashboardScreen extends StatefulWidget {
  const JudgeDashboardScreen({Key? key}) : super(key: key);

  @override
  _JudgeDashboardScreenState createState() => _JudgeDashboardScreenState();
}

class _JudgeDashboardScreenState extends State<JudgeDashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(LucideIcons.user, color: Colors.black),
            ),
            Text(
              "Judge Dashboard",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(LucideIcons.bell, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Actions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildQuickAction("View Evidence", LucideIcons.fileText),
                _buildQuickAction("Courtroom Mode", LucideIcons.gavel),
                _buildQuickAction("Access Logs", LucideIcons.clipboardList),
                _buildQuickAction("Case Archive", LucideIcons.archive),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Trial Calendar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildTrialCard("Trial #4567", "March 10, 2025", "High Priority"),
            _buildTrialCard("Trial #7890", "March 15, 2025", "Medium Priority"),
            SizedBox(height: 20),
            Text(
              "Holographic Preview",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildHolographicPreview(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.folder),
            label: "Evidence Vault",
          ),
          BottomNavigationBarItem(icon: Icon(LucideIcons.list), label: "Logs"),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrialCard(String title, String date, String priority) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(LucideIcons.calendar, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Date: $date\nPriority: $priority"),
        trailing: Icon(LucideIcons.chevronRight, color: Colors.grey),
      ),
    );
  }

  Widget _buildHolographicPreview() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          "Holographic Preview",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: JudgeDashboardScreen()));
}
