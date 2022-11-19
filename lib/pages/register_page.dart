import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
    }) : super(key: key);
  

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }
  Future signUp() async{

    
   if (passwordConfirmed()) {
    // create user
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    // add user details
    addUserDetails(
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _emailController.text.trim(),
      int.parse(_ageController.text.trim(),)
      );
   }

  }

  Future addUserDetails(String firstName, String lastName, String email, int age) async{
    await FirebaseFirestore.instance.collection('users').add({
      'first name':firstName,
      'last name':lastName,
      'email': email,
      'age':age,
      
    });
    
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
     _confirmpasswordController.text.trim()){
      return true;
     }else{
      return false;
     }

  }
  
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
              'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
           
           SizedBox(height: 60),
           // firstname textfield
           
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: TextField( 
              controller: _firstNameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ) ,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'First Name',
                fillColor: Colors.grey[200],
                filled: true,
                ),
              
                ),
        ),
              
             SizedBox(height: 10),

            // lastname textfield
           
        
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: TextField( 
              controller: _lastNameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ) ,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Last Name',
                fillColor: Colors.grey[200],
                filled: true,
                ),
              
                ),
        ),
              
             SizedBox(height: 10),

              // age textfield
           
        
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: TextField( 
              controller: _ageController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ) ,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Age',
                fillColor: Colors.grey[200],
                filled: true,
                ),
              
                ),
        ),
              
             SizedBox(height: 10),

           // email textfield
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: TextField( 
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ) ,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[200],
                filled: true,
                ),
              
                ),
        ),
              
             SizedBox(height: 10),
      
          // password textfield
         
            Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: TextField( 
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ) ,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Password',
                fillColor: Colors.grey[200],
                filled: true,
                ),
              
                ),
        ),
 SizedBox(height: 10),
      
        // confirm password textfield
         
            Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: TextField( 
              obscureText: true,
              controller: _confirmpasswordController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ) ,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Confirm Password',
                fillColor: Colors.grey[200],
                filled: true,
                ),
              
                ),
        ),
          
      
         
          SizedBox(height: 10),
      
          //sign in buttton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25),
            child: GestureDetector(
              onTap: signUp,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    'Sign Up', 
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                      ),
                  )
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
      
          //not a member? register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('I am a member!',
              style: TextStyle(
               fontWeight: FontWeight.bold,
              ),
            ),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: Text(' Login now',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                          ),
              )
            ],
          ),
          
          ],
          ),
        ),
      ),
    );
  }
}