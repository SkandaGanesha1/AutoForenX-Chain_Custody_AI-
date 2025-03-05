import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'inspection_mode_screen.dart'; // Import Inspection Mode Screen
import 'evidence_vault_screen.dart'; // Import Evidence Vault Screen

class OfficerDashboardScreen extends StatefulWidget {
  @override
  _OfficerDashboardScreenState createState() => _OfficerDashboardScreenState();
}

class _OfficerDashboardScreenState extends State<OfficerDashboardScreen> {
  late VideoPlayerController _videoController;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
      )
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuickActions(),
              SizedBox(height: 20),
              _buildLiveVideoFeed(),
              SizedBox(height: 20),
              _buildMapView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  /// App Bar with Profile & Notifications
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        "TaskMaster Pro",
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.redAccent),
          onPressed: () {},
        ),
        SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.person, color: Colors.white),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  /// Quick Actions Section
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ).animate().fade(duration: 500.ms).moveX(begin: -20),
        SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _quickActionCard("Start Inspection", Icons.search, Colors.blue, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InspectionModeScreen()),
              );
            }),
            _quickActionCard(
              "Upload Evidence",
              Icons.upload,
              Colors.green,
              () {},
            ),
            _quickActionCard("View Evidence", Icons.folder, Colors.orange, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EvidenceVaultScreen()),
              );
            }),
            _quickActionCard(
              "Transfer Custody",
              Icons.compare_arrows,
              Colors.teal,
              () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Live Video Feed Section
  Widget _buildLiveVideoFeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Live Video Feed",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Stack(
          children: [
            _videoController.value.isInitialized
                ? AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                )
                : Container(
                  height: 180,
                  color: Colors.black12,
                  child: Center(child: CircularProgressIndicator()),
                ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(
                  isRecording ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: toggleRecording,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Global Map View Section
  Widget _buildMapView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Global Map View",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: FlutterMap(
            options: MapOptions(
              initialCenter: latLng.LatLng(37.7749, -122.4194),
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: latLng.LatLng(37.7749, -122.4194),
                    width: 40.0,
                    height: 40.0,
                    child: Icon(Icons.location_on, size: 40, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EvidenceVaultScreen()),
          );
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: "Evidence Vault",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "Logs"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
