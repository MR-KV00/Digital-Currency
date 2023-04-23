import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kv_dev/providers/RegisterUserProvider.dart';
import 'package:kv_dev/providers/UserDataProvider.dart';
import 'package:kv_dev/ui/core/MainWraper.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../netWork/ResponseModel.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var  _hidePass = false;
  late UserDataProvider userProvider;

  @override
  void dispose() {

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    userProvider =Provider.of<UserDataProvider>(context);

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
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Form(
              key: _formKey,
                child: formChild()
            ),
          ),
          SizedBox(height: height * 0.01,),
          Text('Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',style: GoogleFonts.ubuntu(fontSize: 15,color: Colors.grey,height: 1.5),textAlign: TextAlign.center,),
          SizedBox(height: height * 0.02,),
          Consumer<UserDataProvider>(
            builder: (context, userApiProvider, child) {
              switch(userApiProvider.registerStatus?.status){
                case Status.LOADING:
                  return CircularProgressIndicator();
                case Status.COMPLETED :
                  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainWraper(),)));
                  return signupBtn();
                case Status.ERROR:
                  return Column(
                    children: [
                      signupBtn(),
                       SizedBox(height: 5,),
                       Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.error,color: Colors.red,),
                      const SizedBox(width: 5,),
                      Text(userApiProvider.registerStatus!.massage,style: GoogleFonts.ubuntu(color: Colors.redAccent,fontSize: 15),)
                    ],
                  )
                    ],
                  );


                default:
                  return signupBtn();
                  
                
              }
              
            },


          )





        ],
      ),


    );
  }
  Widget signupBtn(){

    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: SizedBox(
        height: 55,
        width: double.infinity,

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: nameController.value.text.isEmpty && emailController.value.text.isEmpty && passwordController.value.text.isEmpty ? Colors.blue:Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
          ),
          onPressed: (){


            if(_formKey.currentState !.validate()){
              userProvider.callRegisterApi(nameController.text, emailController.text, passwordController.text);
            }

          },
          child: const Text("SignUp"),
        ),

      ),
    );


  }
  Widget formChild(){
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
          controller: emailController,
          validator: (value) {
            if(value==null ||value.isEmpty){
              return "please enter email";
            }else if(!value.endsWith("@gmail.com")){
              return "please enter valid email";
              
            }else{
              return null;
              
            }
          },

        ),
        SizedBox(height: height *0.02),
        TextFormField(
          decoration:  InputDecoration(
            hintText: "password",

            prefixIcon: const Icon(Icons.lock_open),

            suffixIcon :IconButton(
                icon: Icon( _hidePass ? Icons.visibility_off:Icons.visibility ),

                 onPressed: () {
                  setState(() {
                    _hidePass =!_hidePass;
                  });
              },
            ),


            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),


          ),
          controller: passwordController,
          obscureText: _hidePass,
          validator: (value) {
            if(value==null ||value.isEmpty){
              return "Please enter password";
            } else if(value.length <= 7 ) {

              return "please more character";

            }


            else{
              return null;
              
            }
          },

        ),
      ],
    );
  }

}


