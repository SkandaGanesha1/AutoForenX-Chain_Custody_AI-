import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class EvidenceUploadScreen extends StatefulWidget {
  @override
  _EvidenceUploadScreenState createState() => _EvidenceUploadScreenState();
}

class _EvidenceUploadScreenState extends State<EvidenceUploadScreen> {
  File? _file;
  String? _location;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  String computeFileHash(File file) {
    var bytes = file.readAsBytesSync();
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _uploadEvidence() async {
    if (_file == null || _location == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a file and enter location.")),
      );
      return;
    }

    String fileHash = computeFileHash(_file!);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://your-backend-api.com/collect-evidence'),
    );
    request.files.add(await http.MultipartFile.fromPath('file', _file!.path));
    request.fields['location'] = _location!;
    request.fields['hash'] = fileHash;

    var response = await request.send();
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Evidence uploaded successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload evidence.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Evidence")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text(_file == null ? "Select File" : "File Selected"),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: "Location"),
              onChanged: (value) => _location = value,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadEvidence,
              child: Text("Upload Evidence"),
            ),
          ],
        ),
      ),
    );
  }
}