
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../common_widgets/form/input_fields.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class ForgetFormWidget extends StatefulWidget {
  const ForgetFormWidget({Key? key}) : super(key: key);

  @override
  State<ForgetFormWidget> createState() => _ForgetFormWidgetState();
}

class _ForgetFormWidgetState extends State<ForgetFormWidget> {

  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  late String email;


  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    resetPass() async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email)
            .whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Email has been sent"),

            ),);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No user found with this email"),
            ),);
        }
      }
    }
    return   Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formkey,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: tFormHeight),

            Input_Field(LabelText: tFullName, HintText: tFullName, PrefixIcon: Icons.person_outline_rounded),

            const SizedBox(height: tFormHeight - 10),
            TextFormField(

              validator: (value) {
                bool _isEmailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!);
                if (!_isEmailValid) {
                  return 'Invalid email.';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              controller: emailController,

            ),

            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: tPrimaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                onPressed: () {
                if(_formkey.currentState!.validate()){
                  setState(() {
                    email=emailController.text;
                    resetPass();
                });}

                },
                child: Text("Recover".toUpperCase()),

              ),
            )
          ],
        ),
      ),
    );

  }
}
