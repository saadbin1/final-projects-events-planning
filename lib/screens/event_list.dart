import 'package:flutter/material.dart';
import '../models/event.dart';
import 'event_details.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> with TickerProviderStateMixin {
  final List<Event> events = [
    Event(id: '1', name: 'Wedding', date: '8 September 2024', location: 'Venue Grand Marquee, Islamabad'),
    Event(id: '2', name: 'Birthday Party', date: '15 September 2024', location: 'Venue Crown Palace, RWP'),
    Event(id: '3', name: 'Sports', date: '20 October 2024', location: 'Venue islamabad sports Complex, Sector C ISB'),
    Event(id: '4', name: 'Graduation Party', date: '2 October 2024', location: 'Venue Taj Mahal, Texilla'),

  ];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  List<AnimationController> _eventAnimControllers = [];
  List<Animation<double>> _eventFadeAnimations = [];

  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );


    for (int i = 0; i < events.length; i++) {
      AnimationController eventController = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
      )..forward();
      _eventAnimControllers.add(eventController);
      _eventFadeAnimations.add(Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: eventController,
          curve: Interval(0.0 + (i * 0.2), 1.0, curve: Curves.easeInOut),
        ),
      ));
    }
  }

  @override
  void dispose() {
    for (var controller in _eventAnimControllers) {
      controller.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
            NetworkImage('https://cdn.pixabay.com/photo/2017/08/06/07/16/wedding-2589803_960_720.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetails(event: events[index]),
                  ),
                );
              },
              child: FadeTransition(
                opacity: _eventFadeAnimations[index],
                child: AnimatedCrossFade(
                  firstChild: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(events[index].name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    ),
                  ),
                  secondChild: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Tap for details', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  crossFadeState: CrossFadeState.showFirst,
                  duration: Duration(seconds: 4),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
