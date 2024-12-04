import 'screens/news_list.dart';
import 'screens/weather_screen.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCATugUluAHrN-k3W6YB0xGs0s2Rjf9sDU",
      authDomain: "event-planning-app-b431d.firebaseapp.com",
      databaseURL: "https://event-planning-app-b431d-default-rtdb.firebaseio.com",
      projectId: "event-planning-app-b431d",
      storageBucket: "event-planning-app-b431d.firebasestorage.app",
      messagingSenderId: "318568747388",
      appId: "1:318568747388:web:4abb06f48bf924bb22d4f9",
    ),
  );
  runApp(EventPlanningApp());
}

class EventPlanningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Planning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, ),
        ),
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/main': (context) => MainScreen(),
        '/events': (context) => EventList(),
        '/profile': (context) => UserProfile(
          user: User(id: '1', name: 'Saad', email: 'ms3088989@gmail.com'),
        ),
        '/vendors': (context) => VendorList(),
        '/news': (context) => NewsList(),
        '/weather': (context) => WeatherScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Event Planning App'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Events', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
              Tab(child: Text('Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
              Tab(child: Text('Vendors', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
              Tab(child: Text('News', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Navigation', style: TextStyle(color: Colors.white, fontSize: 20)),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
              ),
              ListTile(
                title: Text('Events'),
                onTap: () {
                  Navigator.pushNamed(context, '/events');
                },
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                title: Text('Vendors'),
                onTap: () {
                  Navigator.pushNamed(context, '/vendors');
                },
              ),
              ListTile(
                title: Text('News'),
                onTap: () {
                  Navigator.pushNamed(context, '/news');
                },
              ),
              ListTile(
                title: Text('Weather'),
                onTap: () {
                  Navigator.pushNamed(context, '/weather');
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EventList(),
            UserProfile(user: User(id: '1', name: 'Saad', email: 'ms3088989@gmail.com')),
            VendorList(),
            NewsList(),
          ],
        ),
      ),
    );
  }
}
