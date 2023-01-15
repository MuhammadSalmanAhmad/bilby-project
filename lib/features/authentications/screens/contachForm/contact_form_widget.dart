
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import 'package:flutter/material.dart';

import '../../../../common_widgets/form/input_fields.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';


class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({Key? key}) : super(key: key);

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}
final nameController=TextEditingController();
final subjectController=TextEditingController();
final emailController=TextEditingController();
final messageController=TextEditingController();



Future sendEmail() async{

  final url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId = "service_zlcbq3h";
  const templateId = "template_ars5g2u";
  const userId = "3OstZ3o-MZkiyPCwd";
  // const privatekey= "ER6z2jXuigWEFkSaevqUi";

  final response=await http.post(url,
      headers: {'Content-Type':'application/json'},
      body: json.encode({"service_id":serviceId,
        "template_id":templateId,
        "user_id":userId,
        "template_params":{
          "name":nameController.text,
          "subject":subjectController.text,
          "message":messageController.text,
          "user_email":emailController.text,}
      }));



  if (response.statusCode == 200) {
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: 100.0),
      content: Text("Email Sent", style: TextStyle(color: Colors.green),),
    );
  }else{
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: 100.0),
      content: Text(response.body),
    );
  }

  debugPrint("RESPONSE CODE: ${response.statusCode}");
  debugPrint("RESPONSE TEXT:${response.body}");
  return response.statusCode;

}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                if (value.trim().length < 2) {
                  return 'Name must be valid';
                }
                // Return null if the entered username is valid
                return null;
              },


              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_rounded),
                labelText: tFullName,
                hintText: tFullName,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: subjectController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                if (value.trim().length < 2) {
                  return 'Subject must be valid';
                }
                // Return null if the entered username is valid
                return null;
              },


              decoration: InputDecoration(
                prefixIcon: Icon(Icons.drive_file_rename_outline),
                labelText: "Subject",
                hintText: "Subject",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),),



            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: emailController,
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
              ),),

            const SizedBox(height: tFormHeight - 20),
            Container(

              // padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
                child: TextFormField(
                  controller: messageController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 5) {
                      return 'message must be valid';
                    }
                    // Return null if the entered username is valid
                    return null;
                  },



                  minLines: 1,
                  maxLines: 100,
                  keyboardType: TextInputType.multiline,

                  decoration: InputDecoration(
                    labelText: "Message",
                    hintText: "Kindly enter your message",
                    contentPadding: EdgeInsets.fromLTRB(15, 90, 10, 0),


                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),

                    ),
                  ),)
            ),


            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: tPrimaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                onPressed: ()  async {

    if(_formkey.currentState!.validate()){
      int code = await sendEmail();
      if (code == 200) {

        Get.snackbar("Email Sent!", "Thanks for contacting us!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
        );
      }else{
        Get.snackbar("Error!", "Oh! Email not sent",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red
        );
      }



    }


                },
                child: Text("Send".toUpperCase()),

              ),
            )
          ],
        ),
      ),
    );

  }
}



