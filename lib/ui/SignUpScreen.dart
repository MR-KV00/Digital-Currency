import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();

  final _formKey =GlobalKey();
  bool _hidePass = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return Scaffold(

      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Lottie.asset('images/waveloop.json',height: height *0.2,width: double.infinity,fit: BoxFit.fill),
          SizedBox(height: height *0.01),
           Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("SignUp",style: GoogleFonts.ubuntu(fontSize: height *0.035,color : Theme.of(context).unselectedWidgetColor,fontWeight: FontWeight.bold ),)

    ),
          SizedBox(height: height *0.01),
           Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Create account",style: GoogleFonts.ubuntu(fontSize: height *0.03,color : Theme.of(context).unselectedWidgetColor),)


    ),
          SizedBox(height: height *0.03),
          Form(
            key: _formKey,
              child: formChidl()
          )


        ],
      ),


    );
  }
  Widget formChidl(){
    var height=MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: "UserName",
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),


          ),
          controller: nameController,
          validator: (value) {
            if(value==null ||value.isEmpty){
              return "Please enter user name";
            }else if(value.length < 4){
              return "a least enter 4 characters";
              
            }else if(value.length > 13){
              return "maximum character is 13";
              
            }else{
              return null;
            }
          },

        ),
        SizedBox(height: height *0.02),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),


          ),
          controller: nameController,
          validator: (value) {
            if(value==null ||value.isEmpty){
              return "please enter email";
            }else if(value.endsWith("@gmail.com")){
              return "please enter valid email";
              
            }else{
              return null;
              
            }
          },

        ),
        SizedBox(height: height *0.02),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "UserName",

            prefixIcon: Icon(Icons.lock_open),
            suffixIcon: IconButton(
              icon: Icon(
                  _hidePass ? Icons.visibility:Icons.visibility_off
              ),

             onPressed: (){
                setState(() {
                  _hidePass = !_hidePass;
                });
              },

            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),


          ),
          controller: nameController,
          obscureText: _hidePass,
          validator: (value) {
            if(value==null ||value.isEmpty){
              return "Please enter user name";
            }else if(value.length < 4){
              return "a least enter 4 characters";
              
            }else{
              return null;
              
            }
          },

        ),
      ],
    );
  }
}
