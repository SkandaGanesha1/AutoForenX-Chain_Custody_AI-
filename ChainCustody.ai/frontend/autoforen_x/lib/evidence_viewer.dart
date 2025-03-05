import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EvidenceViewerScreen extends StatefulWidget {
  @override
  _EvidenceViewerScreenState createState() => _EvidenceViewerScreenState();
}

class _EvidenceViewerScreenState extends State<EvidenceViewerScreen> {
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Evidence Viewer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(child: isGridView ? _buildGridView() : _buildListView()),
          _buildMetadataPanel(),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildFilterChip('Photos', Colors.blue.shade100),
              _buildFilterChip('Videos', Colors.green.shade100),
              _buildFilterChip('Documents', Colors.orange.shade100),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () => setState(() => isGridView = false),
              ),
              IconButton(
                icon: Icon(Icons.grid_view),
                onPressed: () => setState(() => isGridView = true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(label: Text(label), backgroundColor: color),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Icon(Icons.image, color: Colors.blue, size: 40)),
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(Icons.image, color: Colors.blue),
            title: Text('Evidence ${index + 1}'),
            subtitle: Text('Details about the evidence'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }

  Widget _buildMetadataPanel() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evidence Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text('Hash Value: 2fd4e1c67a2d28fced849ee1bb76e7391b'),
          Text('Last Modified: June 15, 2023 14:30'),
        ],
      ),
    );
  }
}
