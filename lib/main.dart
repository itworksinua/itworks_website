import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences? prefs;
  bool isLoggeedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginInfo();
  }

  void checkLoginInfo() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggeedIn = prefs?.getBool('isLoggedIn') ?? false;
    });
  }

  Widget regularUI() {
    return Center(
      child: SizedBox(
        height: 150,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logout logic here
                  prefs?.setBool('isLoggedIn', false);
                  setState(() {
                    isLoggeedIn = false;
                  });
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginUI() {
    return Center(
      child: SizedBox(
        height: 150,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add login logic here
                  prefs?.setBool('isLoggedIn', true);
                  setState(() {
                    isLoggeedIn = true;
                  });
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate to Forgot Password screen
                  prefs?.setBool('isLoggedIn', false);
                  setState(() {
                    isLoggeedIn = true;
                  });
                },
                child: Text('Forgot Password?'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate to Registration screen
                },
                child: Text('Don’t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              prefs?.setBool('isLoggedIn', false);
              setState(() {
                isLoggeedIn = false;
              });
            },
          ),
        ],
      ),
      body:
          (prefs == null)
              ? Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              )
              : (isLoggeedIn == true)
              ? regularUI()
              : loginUI(),
    );
  }
}
