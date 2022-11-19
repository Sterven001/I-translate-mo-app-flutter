import 'package:app_proposal/pages/forgot_pw_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key,required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    // loading circler
    showDialog(
      context: context,
      builder: (context){
        return Center(child: CircularProgressIndicator());
      });
    
    
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim(),
      );
    // pop the loading circle
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/App-logo.png',
                  height: 350,
                  width: 350,
                  fit: BoxFit.cover,
                    ),
             
              ),
      
                 SizedBox(height: 10),
              
            Text(
              'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          // email textfield
           
          SizedBox(height: 60),
      
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
              
            
          
      
          // password textfield
          SizedBox(height: 10),
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
      
        // forgot password

        Padding(
          padding: const EdgeInsets.symmetric(horizontal:25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, 
                   MaterialPageRoute(builder: ((context) {
                     return ForgotPasswordPage();
                     }
                    ),
                   ),
                  );
                },
                child: Text('Forgot Password',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
            ],
          ),
        ),
          
      
         
          SizedBox(height: 10),
      
          //sign in buttton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25),
            child: GestureDetector(
              onTap: signIn,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    'Sign In', 
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
              Text('Not a member?',
              style: TextStyle(
               fontWeight: FontWeight.bold,
              ),
            ),
              GestureDetector(
                onTap: widget.showRegisterPage,
                child: Text(' Register now',
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