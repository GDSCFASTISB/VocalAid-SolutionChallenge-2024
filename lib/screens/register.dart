import "package:gdscapp/index.dart";

class Register extends StatefulWidget {
  const Register({super.key});

  // final String title;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final int _counter = 0;

  void addUser() {
    DBHandler dbHandler = DBHandler.getDBHandler();
    dbHandler.addUser(User(name: "Salman"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the Register object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Register"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Email Address', border: OutlineInputBorder()),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                )),
            ElevatedButton(
                onPressed: () async {}, child: const Text("Register")),
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
