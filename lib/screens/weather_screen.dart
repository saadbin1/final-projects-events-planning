import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/weather_service.dart';
import '../models/user_preferences.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with SingleTickerProviderStateMixin {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;
  String cityName = 'London';
  late UserPreferences userPreferences = UserPreferences(preferredCity: 'London');

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  Future<void> _loadUserPreferences() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (snapshot.exists) {
        setState(() {
          userPreferences = UserPreferences.fromMap(snapshot.data() as Map<String, dynamic>);
          cityName = userPreferences.preferredCity;
        });
      }
    }
    _loadWeather();
  }

  Future<void> _updateUserPreferences(String newCity) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'preferredCity': newCity,
      });
      setState(() {
        userPreferences.preferredCity = newCity;
        cityName = newCity;
      });
      _loadWeather();
    }
  }

  Future<void> _loadWeather() async {
    try {
      final data = await _weatherService.fetchWeather(cityName);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch weather data')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather', style: textTheme.displayMedium),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://cdn.pixabay.com/photo/2016/02/05/19/52/birds-1181869_640.jpg',
              fit: BoxFit.cover,
            ),
          ),
          FadeTransition(
            opacity: _animation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Perfect Weather Plan!',
                    style: textTheme.displayLarge?.copyWith(color: Colors.purple),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Plan your Events with confidence – check the weather before you decide!.',
                    style: textTheme.bodyLarge?.copyWith(color: Colors.purple),
                  ),
                  SizedBox(height: 30),
                  _weatherData == null
                      ? CircularProgressIndicator()
                      : ScaleTransition(
                    scale: _animation,
                    child: Column(
                      children: [
                        Text(
                          'Weather in ${_weatherData!['name']}',
                          style: textTheme.displayMedium?.copyWith(color: Colors.purple),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Temperature: ${_weatherData!['main']['temp']}°C',
                          style: textTheme.bodyLarge?.copyWith(color: Colors.purple),
                        ),
                        Text(
                          'Condition: ${_weatherData!['weather'][0]['description']}',
                          style: textTheme.bodyMedium?.copyWith(color: Colors.purple),
                        ),
                        SizedBox(height: 100),
                        Text(
                          'Your Preferred City: ${userPreferences.preferredCity}',
                          style: textTheme.bodyLarge?.copyWith(color: Colors.purple),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async {
                            String? newCity = await _showCityInputDialog();
                            if (newCity != null && newCity.isNotEmpty) {
                              await _updateUserPreferences(newCity);
                            }
                          },
                          child: Text('Change Preferred City'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loadWeather,
                    child: Text('Refresh Weather'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showCityInputDialog() async {
    String? newCity;
    TextEditingController cityController = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Preferred City'),
          content: TextField(
            controller: cityController,
            decoration: InputDecoration(hintText: "City Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                newCity = cityController.text;
                Navigator.of(context).pop(newCity);
              },
            ),
          ],
        );
      },
    );
    return newCity;
  }
}
