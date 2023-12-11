import 'package:finalproject/Models/LoginStructure.dart';
import 'package:finalproject/Models/AuthResponse.dart';
import 'package:finalproject/Repositories/UserClient.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/Models/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anderson Final Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Anderson Final Project Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final UserClient userClient = UserClient();
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool _loading = false;

class _MyHomePageState extends State<MyHomePage> {
  String apiVersion = "";
  var usernameController = new TextEditingController();
  var passwordController = new TextEditingController();

  void initState() {
    super.initState();
    _loading = false;

    widget.userClient
        .GetAPIVersion()
        .then((response) => {print(response), setApiVersion(response)});
    widget.userClient.AddDefaultUser(); //Default username and password.
  }

  void setApiVersion(String version) {
    setState(() {
      apiVersion = version;
    });
  }

  void onLoginButtonPress() {
    setState(() {
      _loading = true;
      LoginStructure user = new LoginStructure(usernameController.text, passwordController.text);
      widget.userClient
        .LoginNoAPI(user)
        .then((response) => {onLoginCallCompleted(response)});
    });
  }

  void onLoginCallCompleted(var response) {
    
    if(response == 0)
    {
      ScaffoldMessenger.of(context)
        .showSnackBar((SnackBar(content: Text("Username does not exist."))));
    } else if (response == 1) {
      ScaffoldMessenger.of(context)
        .showSnackBar((SnackBar(content: Text("Incorrect Password."))));
    } else if (response == 2) {
      ScaffoldMessenger.of(context)
        .showSnackBar((SnackBar(content: Text("Login successful."))));
    } else {
      ScaffoldMessenger.of(context)
        .showSnackBar((SnackBar(content: Text("Login error."))));
    }
    setState(() {
      _loading = false;
    });
  }

  void getUsers()
  {
    setState(() {
      _loading = true;
      widget.userClient.GetUsersAsync().then((response) => onGetUsersSuccess(response));
    });
  }

  onGetUsersSuccess(List<User>? users)
  {
    setState(() {
      if(users != null) {
        for (var user in users) {
          print(user.Username);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Enter Credentials"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(hintText: "Username"),)
                    
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(hintText: "Password"),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                      onPressed: onLoginButtonPress,
                      child: Text("Login"),
                    ),
                  ],
                ),
              ],
              
            ),
            _loading
              ? Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Loading..."),
                ],
              )
            : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(apiVersion),
            ]),
          ],
        ),
      ),
    );
  }
}

/*_loading ?
            Column(
              children: [
                CircularProgressIndicator(),
                Text("Loading..."),
              ],
            )
            : Text(apiVersion)*/