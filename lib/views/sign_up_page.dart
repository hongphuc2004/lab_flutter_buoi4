import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phanphuochongphuc_2224802010871_lab4/controllers/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() async {
    if (formKey.currentState!.validate()) {
      var result = await AuthService().createAccountWithEmail(
        _emailController.text, 
        _passwordController.text
      );
      if (result == "Account Created") {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account Created successfully'))
           );
           Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result ?? "Lỗi không xác định"), backgroundColor: Colors.red.shade400,)
           );
        }
      }
    }
  }

  void _continueWithGoogle() async {
    var result = await AuthService().continueWithGoogle();
    if (result == "Google Login successful") {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful'))
           );
           Navigator.pushReplacementNamed(context, '/home');
        }
    } else {
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result), backgroundColor: Colors.red.shade400,)
           );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
           icon: const Icon(Icons.arrow_back),
           onPressed: () => Navigator.pop(context),
         ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                'Sign Up',
                style: GoogleFonts.sora(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) => 
                      value == null || value.isEmpty ? 'Email cannot be empty' : null,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) => value!.length < 8
                      ? 'Password must be at least 8 characters'
                      : null,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 55,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade50,
                    foregroundColor: Colors.orange.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16),
                  )
                )
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 55,
                width: MediaQuery.of(context).size.width * .9,
                child: OutlinedButton(
                  onPressed: _continueWithGoogle,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Continue with Google",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      )
                    ],
                  )
                )
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?", style: TextStyle(color: Colors.black54)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text('Login', style: TextStyle(color: Colors.orange.shade900)),
                  )
                ],
              )
            ]
          )
        ),
      ),
    );
  }
}
