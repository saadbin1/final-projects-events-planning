import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VendorList extends StatefulWidget {
  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  List<dynamic> vendors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVendors();
  }

  Future<void> _fetchVendors() async {
    try {
      final response = await http.get(Uri.parse('https://run.mocky.io/v3/2c3827cb-1b7a-4444-b0ab-e5f174b709a6'));
      if (response.statusCode == 200) {
        setState(() {
          vendors = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load vendors');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Vendors', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.deepPurple,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://cdn.pixabay.com/photo/2017/08/06/07/16/wedding-2589803_960_720.jpg',
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                if (isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          vendors[index]['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        subtitle: Text(
                          vendors[index]['service'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              childCount: isLoading ? 0 : vendors.length,
            ),
          ),
        ],
      ),
    );
  }
}
