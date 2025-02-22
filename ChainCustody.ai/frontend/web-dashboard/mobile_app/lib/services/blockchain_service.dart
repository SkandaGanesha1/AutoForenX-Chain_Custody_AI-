import 'package:http/http.dart' as http;

class BlockchainService {
  static const String baseUrl = 'http://your-backend-api.com';

  Future<String> collectEvidence(String hash, String location) async {
    var response = await http.post(
      Uri.parse('$baseUrl/collect-evidence'),
      body: {'hash': hash, 'location': location},
    );
    if (response.statusCode == 201) {
      return json.decode(response.body)['evidence_id'];
    } else {
      throw Exception('Failed to collect evidence.');
    }
  }
}