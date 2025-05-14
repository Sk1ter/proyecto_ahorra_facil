import 'package:final_app_ahorrafacil/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double ingresos = 0.0;
  double gastos = 0.0;
  double saldo = 0.0;

  final ingresoController = TextEditingController();
  final gastoController = TextEditingController();

  void agregarIngreso() {
    setState(() {
      final ingreso = double.tryParse(ingresoController.text.trim()) ?? 0.0;
      ingresos += ingreso;
      saldo += ingreso;
      ingresoController.clear();
    });
  }

  void agregarGasto() {
    setState(() {
      final gasto = double.tryParse(gastoController.text.trim()) ?? 0.0;
      gastos += gasto;
      saldo -= gasto;
      gastoController.clear();
    });
  }

  Future<void> cerrarSesion() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage())); 
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cerrar sesión')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade300,
        title: const Text(
          'AhorraFácil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: cerrarSesion,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            tarjetaDebitoUsuario(),
            const SizedBox(height: 30),
            ingresarCampos(),
            const SizedBox(height: 30),
            resumenCard(
              icon: Icons.account_balance_wallet,
              label: 'Saldo disponible',
              value: 'S/ ${saldo.toStringAsFixed(2)}',
            ),
            resumenCard(
              icon: Icons.arrow_upward,
              label: 'Ingresos',
              value: 'S/ ${ingresos.toStringAsFixed(2)}',
            ),
            resumenCard(
              icon: Icons.arrow_downward,
              label: 'Gastos',
              value: 'S/ ${gastos.toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
    );
  }

  Widget tarjetaDebitoUsuario() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.orange.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade300.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tarjeta de Ahorros',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            '**** **** **** 4521',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Nombre',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'USUARIO REGISTRADO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Saldo',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'S/ ${saldo.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ingresarCampos() {
    return Column(
      children: [
        TextField(
          controller: ingresoController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Ingresar Ingreso',
            hintText: 'Monto del ingreso',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.arrow_upward, color: Colors.orange.shade700),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: gastoController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Ingresar Gasto',
            hintText: 'Monto del gasto',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.arrow_downward, color: Colors.orange.shade700),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: agregarIngreso,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade500,
              ),
              child: const Text('Agregar Ingreso'),
            ),
            ElevatedButton(
              onPressed: agregarGasto,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade500,
              ),
              child: const Text('Agregar Gasto'),
            ),
          ],
        ),
      ],
    );
  }

  Widget resumenCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange.shade700, size: 30),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
