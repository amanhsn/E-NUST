import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/splash.dart';
import 'package:flutter_svg/flutter_svg.dart';


void main() {
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Init the firebase app
  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return LoginScreen();
          }
          return const Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}
  class LoginScreen extends StatefulWidget {
    const LoginScreen({Key? key}) : super(key: key);
    
    @override
    _LoginScreenState createState() => _LoginScreenState();
  }

  class _LoginScreenState extends State<LoginScreen> {
    //Login using username and password
    static Future<User?> loginUsingUsernamePassword({required String username, required String password,required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: username, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No user found for that email.')));
    }
    }
    return user;
    }

  bool _obscureText = true;
  Widget build(BuildContext context) {
  return Container(
    width: 360,
    height: 800,
    color: const Color(0xff121212),
    padding: const EdgeInsets.only(top: 119, bottom: 140, ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Login', textAlign: TextAlign.center, style: TextStyle(
        decoration: TextDecoration.none,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Montserrat',
        fontSize: 36,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),),
      Container(
      width: 320,
      height: 280,
      
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: Container(
        width: 320,
        height: 280,
        decoration: const BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
      color : Color.fromRGBO(217, 217, 217, 0.14000000059604645),
  )
      )
      ),const Positioned(
        top: 27,
        left: 24,
        child: Text('Welcome Back',
         textAlign: TextAlign.left, style: TextStyle(
          decoration: TextDecoration.none,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Montserrat',
        fontSize: 24,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),Stack(
  children: [
    Positioned(
      top: 190,
      left: 24,
      child: SizedBox(
        width: 271,
        height: 36,
        child: Material(
          color: Colors.transparent,
          child: TextField(
            obscureText: _obscureText,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, color: Colors.white),
              suffixIcon: IconButton(
              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
              setState(() {
              _obscureText = !_obscureText;
              });
              },
              ),
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Color.fromRGBO(65, 60, 60, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat',
        fontSize: 18,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1,
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            //controller: TextEditingController(text: ''), //initial value
            //obscureText: true,
          ),
        ),
      ),
    ),
  ],
),Stack(
  children: [
    Positioned(
      top: 112,
      left: 25,
      child: SizedBox(
        width: 271,
        height: 36,
        child: Material(
          color: Colors.transparent,
          child: TextField(
            
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person, color: Colors.white),
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Color.fromRGBO(65, 60, 60, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat',
        fontSize: 18,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1,
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            controller: TextEditingController(text: '  '), //initial value
          ),
        ),
      ),
    ),
  ],
),
const Positioned(
        top: 90,
        left: 25,
        child: Text('Username', textAlign: TextAlign.left, style: TextStyle(
          decoration: TextDecoration.none,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Montserrat',
        fontSize: 18,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),const Positioned(
        top: 168,
        left: 24,
        child: Text('Password', textAlign: TextAlign.left, style: TextStyle(
          decoration: TextDecoration.none,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Montserrat',
        fontSize: 18,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),const Positioned(
        top: 112,
        left: 30,
        child: Text('', textAlign: TextAlign.left, style: TextStyle(
          decoration: TextDecoration.none,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Montserrat',
        fontSize: 18,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      )
      ,Positioned(
        top: 240,
        left: 86,
        child: Container(
        width: 148,
        height: 30,
        decoration: const BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(7),
            topRight: Radius.circular(7),
            bottomLeft: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
      color : Color.fromRGBO(19, 50, 91, 1),
  )
      )
      ),const Positioned(
        top: 245,
        left: 128,
        child: Text('Submit', textAlign: TextAlign.left, style: TextStyle(
          decoration: TextDecoration.none,
        color: Color.fromRGBO(227, 227, 227, 1),
        fontFamily: 'Inter',
        fontSize: 18,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),
        ]
      )
    ),
    Container(
      width: 320,
      height: 100,
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 10,
        left: 15,
        child: Text('New User?', textAlign: TextAlign.left, style: TextStyle(
          decoration: TextDecoration.none,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Montserrat',
        fontSize: 20,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),Positioned(
        top: 0,
        left: 0,
        child: Container(
        width: 320,
        height: 100,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
      color : Color.fromRGBO(217, 217, 217, 0.14000000059604645),
  )
      )
      ),Positioned(
        top: 48,
        left: 30,
        child: Container(
        width: 265,
        height: 40,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
      color : Color.fromRGBO(66, 60, 60, 1),
  )
      )
      ),const Positioned(
        top: 56,
        left: 86,
        child: Text('Signup/Register', textAlign: TextAlign.left, style: TextStyle(
        decoration: TextDecoration.none,
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Inter',
        fontSize: 20,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),
        ]
      )
    ),
    ],
        ),
        );
}
}
