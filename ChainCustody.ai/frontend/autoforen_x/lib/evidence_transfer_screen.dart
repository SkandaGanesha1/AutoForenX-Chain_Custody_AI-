import 'package:flutter/material.dart';
import 'ai_forensic_analysis_screen.dart'; // Import AI Analysis Screen

class EvidenceTransferScreen extends StatefulWidget {
  @override
  _EvidenceTransferScreenState createState() => _EvidenceTransferScreenState();
}

class _EvidenceTransferScreenState extends State<EvidenceTransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evidence Transfer"),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.help_outline), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipient Selection
              Text(
                "Select Recipient",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by name, ID, or role",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              SizedBox(height: 15),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple[100],
                  child: Icon(Icons.person, color: Colors.black),
                ),
                title: Text("Det. Sarah Johnson"),
                subtitle: Text("Digital Forensics • ID: 847392"),
                trailing: Icon(Icons.verified, color: Colors.green),
              ),
              SizedBox(height: 20),

              // Biometric Authentication
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Authentication Required",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Icon(Icons.fingerprint, size: 50, color: Colors.blue),
                    SizedBox(height: 10),
                    Text("Biometric Verification"),
                    Text(
                      "Place your finger on the sensor",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Smart Contract Details
              Text(
                "Smart Contract Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Case ID",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("EVC-2024-0238"),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Blockchain Hash",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("0x4f5a...9b3e"),
                        ],
                      ),
                      SizedBox(height: 10),
                      CheckboxListTile(
                        value: true,
                        onChanged: (value) {},
                        title: Text("I agree to the transfer terms"),
                      ),
                      SizedBox(height: 10),

                      // ✅ Updated Button to Redirect
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to AI Forensic Analysis Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AIForensicAnalysisScreen(),
                            ),
                          );
                        },
                        child: Text("Confirm & Execute"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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
      ),
    );
  }
}
