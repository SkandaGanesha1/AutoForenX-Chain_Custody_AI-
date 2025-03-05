import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class InspectionModeScreen extends StatefulWidget {
  const InspectionModeScreen({super.key});

  @override
  State<InspectionModeScreen> createState() => _InspectionModeScreenState();
}

class _InspectionModeScreenState extends State<InspectionModeScreen> {
  bool isEventLogExpanded = true;
  List<Map<String, dynamic>> eventLog = [
    {
      "time": "14:32:45",
      "event": "Started Recording",
      "icon": Iconsax.video_play,
      "color": Colors.green,
    },
    {
      "time": "14:33:12",
      "event": "Evidence Shard #472A Collected",
      "icon": Iconsax.document,
      "color": Colors.blue,
    },
    {
      "time": "14:33:45",
      "event": "Anomaly Detection Active",
      "icon": Iconsax.warning_2,
      "color": Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Live Status Indicators
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusIndicator("RECORDING", Colors.red),
                  _buildStatusIndicator("GPS LOCKED", Colors.green),
                  _buildStatusIndicator("SECURE", Colors.blue),
                ],
              ),
            ),

            // Main Card
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Case Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Case #AI-2024-0472",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.fingerprint,
                          color: Colors.blueAccent,
                          size: 28,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Active Inspection Mode",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Location & Timestamp
                    _buildMetadataRow("Location", "37.7749° N, 122.4194° W"),
                    _buildMetadataRow("Timestamp", "2024-02-20 14:32:45 UTC"),

                    const SizedBox(height: 15),

                    // Description Field
                    TextField(
                      style: GoogleFonts.poppins(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Add description or observations...",
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Event Log Header
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isEventLogExpanded = !isEventLogExpanded;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Event Log",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            isEventLogExpanded
                                ? Iconsax.arrow_up_1
                                : Iconsax.arrow_down_1,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Event Log List (Collapsible)
                    if (isEventLogExpanded)
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: eventLog.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                  leading: Icon(
                                    eventLog[index]["icon"],
                                    color: eventLog[index]["color"],
                                  ),
                                  title: Text(
                                    eventLog[index]["event"],
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    eventLog[index]["time"],
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                                .animate()
                                .fade(duration: 500.ms)
                                .slideY(begin: 0.2, end: 0);
                          },
                        ),
                      ),

                    const Spacer(),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Neural Handshake Simulation
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.fingerprint,
                                        color: Colors.blueAccent,
                                        size: 50,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Neural Handshake Required",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Place your fingerprint to confirm",
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          );
                        },
                        child: Text(
                          "Complete Inspection",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for status indicators
  Widget _buildStatusIndicator(String label, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  // Widget for metadata row
  Widget _buildMetadataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(color: Colors.grey)),
          Text(value, style: GoogleFonts.poppins(color: Colors.white)),
        ],
      ),
    );
  }
}
