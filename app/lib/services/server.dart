import 'package:http/http.dart' as http;
import 'dart:convert';

class Server {
  static const String baseUrl =
      'https://estetica-de-lucca-server-jebn1.kinsta.app';

  static Future<Map<String, dynamic>?> getAvailableHours() async {
    final endpoint = '/available-hours';
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}


// Sample response for available hours
// {
// "2024-03-20": [
// {
// "from": "2024-03-20T09:00:00Z",
// "to": "2024-03-20T09:15:00Z"
// },
// {
// "from": "2024-03-20T09:15:00Z",
// "to": "2024-03-20T09:30:00Z"
// },
// {
// "from": "2024-03-20T09:30:00Z",
// "to": "2024-03-20T09:45:00Z"
// },
// {
// "from": "2024-03-20T09:45:00Z",
// "to": "2024-03-20T10:00:00Z"
// },
// {
// "from": "2024-03-20T14:00:00Z",
// "to": "2024-03-20T14:15:00Z"
// },
// {
// "from": "2024-03-20T14:15:00Z",
// "to": "2024-03-20T14:30:00Z"
// },
// {
// "from": "2024-03-20T14:30:00Z",
// "to": "2024-03-20T14:45:00Z"
// },
// {
// "from": "2024-03-20T14:45:00Z",
// "to": "2024-03-20T15:00:00Z"
// }
// ],
// "2024-03-21": [
// {
// "from": "2024-03-21T10:00:00Z",
// "to": "2024-03-21T10:15:00Z"
// },
// {
// "from": "2024-03-21T10:15:00Z",
// "to": "2024-03-21T10:30:00Z"
// },
// {
// "from": "2024-03-21T10:30:00Z",
// "to": "2024-03-21T10:45:00Z"
// },
// {
// "from": "2024-03-21T10:45:00Z",
// "to": "2024-03-21T11:00:00Z"
// },
// {
// "from": "2024-03-21T15:00:00Z",
// "to": "2024-03-21T15:15:00Z"
// },
// {
// "from": "2024-03-21T15:15:00Z",
// "to": "2024-03-21T15:30:00Z"
// },
// {
// "from": "2024-03-21T15:30:00Z",
// "to": "2024-03-21T15:45:00Z"
// },
// {
// "from": "2024-03-21T15:45:00Z",
// "to": "2024-03-21T16:00:00Z"
// }
// ]
// }