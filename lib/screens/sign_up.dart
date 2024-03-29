import 'package:gdscapp/auth_fuctions/sign_up_func.dart';
import 'package:gdscapp/screens/Profile.dart';
import 'package:gdscapp/screens/Profile.dart';
import '../index.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  bool? isChecked = false;
  User user = User();
  bool isLoginPage = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Align(
              alignment: const Alignment(-0.8, 1),
              child: Text(
                'Register account',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 3),
              child: TextFormField(
                keyboardType: TextInputType.name,
                key: const ValueKey('Name'),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: false,
                  label: const Text('Name'),
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // hintStyle: TextStyle(
                  //   color: Colors.grey,
                  //   fontFamily: 'Poppins',
                  //   fontWeight: FontWeight.w400
                  // ),
                ),
                validator: (value) {
                  if (value!.toString().length < 4) {
                    return 'Name too small';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    user.name = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                key: const ValueKey('email'),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  label: const Text('Email'),
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                validator: validateEmail,
                onChanged: (value) {
                  user.emailAddress = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: _obscureText,
                key: const ValueKey('password'),
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    label: const Text('password'),
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ))),
                validator: (value) {
                  if (value!.toString().length < 6) {
                    return 'password should be greater than 6 characters';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  user.password = value;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Checkbox(
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.green;
                    }
                    return Colors.grey.shade200;
                  }),
                  checkColor: Colors.white,
                  tristate: true,
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('''By Creating account, you are accepting terms & 
conditions''',
                  maxLines: 2,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF008A70),
                ),
                onPressed: () async {
                  CustomProgressDialog.showProDialog("Signing you up");
                  try {
                    await signUp(user);
                    // Navigate to the next screen or perform other actions upon successful signup.
                  } catch (e) {
                    CustomProgressDialog.hideProDialog();
                    // Handle and display the error, e.g., show an error message to the user.
                    print('Error during signup: $e');
                  }
                },
                child: Text('SignUp',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      switchScreenWithData(ProfilePage());
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                          color: Color(0xFF008A70),
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
