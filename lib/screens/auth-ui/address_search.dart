// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../services/geoapify_service.dart';

class AddressSearchScreen extends StatefulWidget {
  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  List<String> addressSuggestions = [];
  TextEditingController controller = TextEditingController();

  void fetchSuggestions(String query) async {
    if (query.length > 2) {
      // Avoid unnecessary API calls
      List<String> results = await GeoapifyService.getPlaceSuggestions(query);
      setState(() {
        addressSuggestions = results;
      });
    } else {
      setState(() {
        addressSuggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Address Search")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: fetchSuggestions,
              decoration: InputDecoration(
                labelText: "Enter Address",
                border: OutlineInputBorder(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: addressSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(addressSuggestions[index]),
                    onTap: () {
                      controller.text = addressSuggestions[index];
                      setState(() {
                        addressSuggestions = [];
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
