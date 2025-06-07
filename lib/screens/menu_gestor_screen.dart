import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_colors.dart';
import 'login_screen.dart';
import 'usuarios_screen.dart';
import 'pneus_screen.dart';
import 'chassis_screen.dart';
import 'caminhoes_screen.dart';
import 'atendimentos_screen.dart';

class MenuGestorScreen extends StatelessWidget {
  const MenuGestorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.black,
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      tooltip: 'Sair do sistema',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 52),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                    semanticLabel: 'Logo do Tires Guard',
                  ),
                ),
                const SizedBox(height: 40),
                _buildMenuButton(context, 'Atendimentos', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AtendimentosScreen()));
                }),
                const SizedBox(height: 16),
                _buildMenuButton(context, 'Caminhões', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CaminhoesScreen()));
                }),
                const SizedBox(height: 16),
                _buildMenuButton(context, 'Chassis', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ChassisScreen()));
                }),
                const SizedBox(height: 16),
                _buildMenuButton(context, 'Pneus', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PneusScreen()));
                }),
                const SizedBox(height: 32),
                _buildMenuButton(context, 'Usuários', color: Colors.black, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UsuariosScreen()));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, {Color? color, VoidCallback? onTap}) {
    return Semantics(
      label: 'Botão para acessar $text',
      button: true,
      child: Center(
        child: SizedBox(
          width: 300,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? AppColors.button,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.black, width: 1),
              ),
            ),
            onPressed: onTap ?? () {},
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
