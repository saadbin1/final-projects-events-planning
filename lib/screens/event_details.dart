import 'package:flutter/material.dart';
import '../models/event.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  EventDetails({required this.event});

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  double _opacity = 0.0;
  Offset _position = Offset(0, 0);
  double _scale = 1.0;

  String? _droppedImageUrl;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  String _getEventImage() {
    String eventName = widget.event.name.trim().toLowerCase();

    switch (eventName) {
      case 'wedding':
        return 'https://cdn.pixabay.com/photo/2019/12/19/09/07/deco-4705709_1280.jpg';
      case 'birthday party':
        return 'https://cdn.pixabay.com/photo/2017/08/08/09/01/eat-2610768_960_720.png';
      case 'sports':
        return 'https://cdn.pixabay.com/photo/2016/08/13/11/57/stadium-1590576_960_720.jpg';
      case 'graduation party':
        return 'https://cdn.pixabay.com/photo/2018/05/26/06/46/graduation-cap-3430714_640.jpg';
      default:
        return 'https://cdn.pixabay.com/photo/2019/12/19/09/07/deco-4705709_1280.jpg';
    }
  }

  List<String> _getGalleryImages() {
    String eventName = widget.event.name.trim().toLowerCase();

    switch (eventName) {
      case 'wedding':
        return [
          'https://cdn.pixabay.com/photo/2016/11/21/15/58/wedding-1846114_640.jpg',
          'https://cdn.pixabay.com/photo/2023/05/27/11/03/wedding-8021285_640.jpg',
          'https://cdn.pixabay.com/photo/2019/06/21/09/14/vintage-van-4288994_640.jpg',
        ];
      case 'birthday party':
        return [
          'https://cdn.pixabay.com/photo/2021/10/27/10/34/birthday-6746693_640.jpg',
          'https://cdn.pixabay.com/photo/2023/12/26/11/46/cake-8470012_640.jpg',
          'https://cdn.pixabay.com/photo/2016/10/31/19/04/balloons-1786430_640.jpg',
        ];
      case 'sports':
        return [
          'https://cdn.pixabay.com/photo/2016/11/22/23/49/cyclists-1851269_960_720.jpg',
          'https://cdn.pixabay.com/photo/2017/09/13/09/21/hockey-2744912_1280.jpg',
          'https://cdn.pixabay.com/photo/2022/02/16/04/15/cricketer-7015983_1280.jpg',
        ];
      case 'graduation party':
        return [
          'https://cdn.pixabay.com/photo/2018/01/03/12/33/graduation-3058263_640.jpg',
          'https://cdn.pixabay.com/photo/2018/04/15/18/02/books-3322275_1280.jpg',
          'https://cdn.pixabay.com/photo/2021/08/22/22/09/graduation-6566253_640.jpg',
        ];
      default:
        return [
          'https://cdn.pixabay.com/photo/2019/12/19/09/07/deco-4705709_1280.jpg',
          'https://cdn.pixabay.com/photo/2019/05/20/17/52/wedding-4217685_960_720.jpg',
          'https://cdn.pixabay.com/photo/2017/08/10/19/08/wedding-2616581_960_720.jpg',
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> galleryImages = _getGalleryImages();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(seconds: 1),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkResponse(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Event image tapped!')),
                      );
                    },
                    onDoubleTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Event image double-tapped!')),
                      );
                    },
                    child: Transform.scale(
                      scale: _scale,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_getEventImage()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.event.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date: ${widget.event.date}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Divider(),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      Chip(
                        label: Text('Location: ${widget.event.location}'),
                        avatar: Icon(Icons.location_on, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildServiceCard(Icons.cake, 'Cake', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cake service tapped!')),
                        );
                      }),
                      _buildServiceCard(Icons.music_note, 'Music', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Music service tapped!')),
                        );
                      }),
                      _buildServiceCard(Icons.local_florist, 'Flowers', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Flowers service tapped!')),
                        );
                      }),
                      _buildServiceCard(Icons.photo_camera, 'Photography', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Photography service tapped!')),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Vendors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      Chip(label: Text('Catering Co.')),
                      Chip(label: Text('DJ Service')),
                      Chip(label: Text('Florist')),
                      Chip(label: Text('Photographer')),
                      Chip(label: Text('Decorations')),
                      Chip(label: Text('Entertainment')),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Gallery', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: galleryImages.length,
                      itemBuilder: (context, index) {
                        return Draggable<String>(
                          data: galleryImages[index],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                print('Gallery image tapped: ${galleryImages[index]}');
                              },
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(galleryImages[index]),
                              ),
                            ),
                          ),
                          feedback: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(galleryImages[index]),
                          ),
                          childWhenDragging: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  DragTarget<String>(
                    onAccept: (data) {
                      setState(() {
                        _droppedImageUrl = data;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Image received!')),
                      );
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        height: 100,
                        color: Colors.blueAccent.withOpacity(0.1),
                        child: Center(
                          child: _droppedImageUrl == null
                              ? Text('Drag image here')
                              : Image.network(_droppedImageUrl!),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String serviceName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.deepPurple),
            SizedBox(height: 8),
            Text(serviceName, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
