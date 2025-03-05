import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class EvidenceVaultScreen extends StatefulWidget {
  @override
  _EvidenceVaultScreenState createState() => _EvidenceVaultScreenState();
}

class _EvidenceVaultScreenState extends State<EvidenceVaultScreen> {
  bool isGridView = true;
  bool isListening = false;
  TextEditingController searchController = TextEditingController();
  late stt.SpeechToText _speech;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  void startVoiceSearch() async {
    if (!isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              searchController.text = result.recognizedWords;
              isListening = false;
            });
          },
        );
      }
    } else {
      _speech.stop();
      setState(() => isListening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Evidence Vault",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 15),
            _buildViewToggle(),
            Expanded(child: isGridView ? _buildGridView() : _buildListView()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Search evidence...",
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        suffixIcon: GestureDetector(
          onTap: startVoiceSearch,
          child: Icon(
            isListening ? Icons.mic : Icons.mic_none,
            color: isListening ? Colors.red : Colors.grey,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ).animate().fade(duration: 500.ms);
  }

  Widget _buildViewToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Evidence Collection",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: Icon(
            isGridView ? Icons.grid_view : Icons.list,
            color: Colors.white,
          ),
          onPressed: toggleView,
        ),
      ],
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return _evidenceCard(index);
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return _evidenceCard(index, isList: true);
      },
    );
  }

  Widget _evidenceCard(int index, {bool isList = false}) {
    List<Color> statusColors = [Colors.green, Colors.yellow, Colors.red];
    return Card(
      color: Colors.grey[900],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: statusColors[index % 3],
                  radius: 6,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Evidence #A-${7249 + index}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (String value) {
                    // Handle actions like Share, Edit, Export, Delete
                  },
                  itemBuilder:
                      (BuildContext context) => [
                        PopupMenuItem(value: "Share", child: Text("Share")),
                        PopupMenuItem(value: "Edit", child: Text("Edit")),
                        PopupMenuItem(value: "Export", child: Text("Export")),
                        PopupMenuItem(value: "Delete", child: Text("Delete")),
                      ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Collected on Oct 15, 2023 at 14:30",
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.share, color: Colors.blue),
                Icon(Icons.edit, color: Colors.orange),
                Icon(Icons.file_download, color: Colors.green),
                Icon(Icons.delete, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
