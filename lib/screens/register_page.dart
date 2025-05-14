import 'package:final_app_ahorrafacil/components/my_button.dart';
import 'package:final_app_ahorrafacil/components/my_text_field.dart';
import 'package:final_app_ahorrafacil/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();

  Future<void> register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.shade200,
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Regístrate para comenzar a ahorrar fácil',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: nameController,
                  hintText: 'Nombre completo',
                  icon: Icons.person,
                ),
                MyTextField(
                  controller: emailController,
                  hintText: 'Correo electrónico',
                  icon: Icons.email,
                ),
                MyTextField(
                  controller: cityController,
                  hintText: 'Ciudad',
                  icon: Icons.location_city,
                ),
                MyTextField(
                  controller: phoneController,
                  hintText: 'Teléfono',
                  icon: Icons.phone,
                ),
                MyTextField(
                  controller: passController,
                  hintText: 'Contraseña',
                  obscureText: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 20),
                MyButton(onTap: register, text: 'Crear Cuenta'),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes cuenta?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Inicia sesión',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
