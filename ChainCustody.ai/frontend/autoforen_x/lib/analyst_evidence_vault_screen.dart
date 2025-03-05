import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalystEvidenceVaultScreen extends StatefulWidget {
  @override
  _AnalystEvidenceVaultScreenState createState() =>
      _AnalystEvidenceVaultScreenState();
}

class _AnalystEvidenceVaultScreenState
    extends State<AnalystEvidenceVaultScreen> {
  String selectedMode = "2D View";
  bool isAIProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Evidence Vault",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            _buildAIAnalysisTools(),
            SizedBox(height: 20),
            _buildEvidenceViewer(),
            SizedBox(height: 20),
            _buildCollaborationTools(),
          ],
        ),
      ),
    );
  }

  Widget _buildModeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: Text("2D View"),
          selected: selectedMode == "2D View",
          onSelected: (selected) {
            if (selected) {
              setState(() {
                selectedMode = "2D View";
              });
            }
          },
        ),
        SizedBox(width: 10),
        ChoiceChip(
          label: Text("3D View"),
          selected: selectedMode == "3D View",
          onSelected: (selected) {
            if (selected) {
              setState(() {
                selectedMode = "3D View";
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Search Evidence"),
            TextField(
              decoration: InputDecoration(
                hintText: "Search by Case ID, Type, or Date",
                prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 500.ms);
  }

  Widget _buildAIAnalysisTools() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("AI Analysis Tools"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  "Scan for Anomalies",
                  FontAwesomeIcons.robot,
                  () {
                    setState(() => isAIProcessing = !isAIProcessing);
                  },
                ),
                _buildActionButton(
                  "Generate Report",
                  FontAwesomeIcons.fileAlt,
                  () {},
                ),
              ],
            ),
            if (isAIProcessing)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    ).animate().fade(duration: 500.ms);
  }

  Widget _buildEvidenceViewer() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Evidence Viewer"),
            Text(
              "Case #2024-0231",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 10),
            _buildModeSelector(),
          ],
        ),
      ),
    ).animate().slideY(duration: 500.ms);
  }

  Widget _buildCollaborationTools() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Real-Time Collaboration"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton("Share Evidence", Icons.share, () {}),
                _buildActionButton("Live Chat", Icons.chat, () {}),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton("Voice Chat", Icons.mic, () {}),
                _buildActionButton("Annotate", Icons.edit, () {}),
              ],
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 500.ms);
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
