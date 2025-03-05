import 'package:flutter/material.dart';

class AIForensicAnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Forensic Analysis'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [IconButton(icon: Icon(Icons.help_outline), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAIAnalysisResults(),
            SizedBox(height: 20),
            _buildEvidenceTimeline(),
          ],
        ),
      ),
    );
  }

  Widget _buildAIAnalysisResults() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AI Analysis Results',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Chip(
                label: Text(
                  'Processing...',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Metadata Tampering Detected',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '92% confidence score',
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 20),
                Container(height: 100, color: Colors.grey[300]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenceTimeline() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evidence Timeline',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildTimelineEvent(
            Icons.file_present,
            'File Creation',
            '2024-02-15 14:30 UTC',
            Colors.orange,
          ),
          _buildTimelineEvent(
            Icons.edit,
            'Modification Detected',
            '2024-02-15 15:45 UTC',
            Colors.purple,
            isAlert: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineEvent(
    IconData icon,
    String title,
    String timestamp,
    Color color, {
    bool isAlert = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10),
          Expanded(
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(timestamp, style: TextStyle(color: Colors.grey)),
          if (isAlert) Icon(Icons.warning, color: Colors.red),
        ],
      ),
    );
  }
}
