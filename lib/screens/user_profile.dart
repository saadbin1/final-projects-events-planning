import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProfile extends StatefulWidget {
  final User user;

  UserProfile({required this.user});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> with TickerProviderStateMixin {
  bool _isImageLoaded = false;
  bool _showAboutMe = false;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();


    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..forward();

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));


    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isImageLoaded = true;
        _showAboutMe = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.user.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://cdn.pixabay.com/photo/2017/08/06/07/16/wedding-2589803_960_720.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),

              AnimatedCrossFade(
                duration: Duration(seconds: 1),
                firstChild: CircularProgressIndicator(),
                secondChild: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfyOa5OP-T-puERaQ9iEM5M_KVslF14IS0wA&s'),
                ),
                crossFadeState: _isImageLoaded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
              SizedBox(height: 30),


              FadeTransition(
                opacity: _opacityAnimation,
                child: Text('Name: ${widget.user.name}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
              ),
              SizedBox(height: 8),
              FadeTransition(
                opacity: _opacityAnimation,
                child: Text('Email: ${widget.user.email}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink)),
              ),
              SizedBox(height: 20),


              AnimatedOpacity(
                duration: Duration(seconds: 2),
                opacity: _showAboutMe ? 1.0 : 0.0,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('About Me', style: TextStyle(fontSize: 19.5, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                      SizedBox(height: 8),
                      Text(
                        'I am a passionate Event Planner with a strong background in event management and a keen eye for detail. I am committed to delivering exceptional experiences for clients and guests.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Skills:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      SizedBox(height: 8),
                      Text('Event Planning, Budgeting, Vendor Management, Team Coordination',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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
