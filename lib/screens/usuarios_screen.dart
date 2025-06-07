import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_colors.dart';
import 'cadastro_usuario_screen.dart';
import '../models/usuario.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  Future<List<Usuario>> carregarUsuarios() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Usuario(codigo: '1', nome: 'João Silva', email: 'joao@empresa.com.br', funcao: 'Gestor'),
      Usuario(codigo: '2',nome: 'Maria Souza', email: 'maria@empresa.com.br',funcao: 'Borracheiro'),
      Usuario(codigo: '3',nome: 'Carlos Lima', email: 'carlos@empresa.com.br',funcao: 'Borracheiro'),
    ];
  }

  void _abrirCadastroUsuario({Usuario? usuario}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroUsuarioScreen(usuario: usuario),
      ),
    );
  }

  Widget _paginaBotao(IconData icon, bool enabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: enabled ? Color(0xFF444444) : Color(0xFF262626),
          borderRadius: BorderRadius.circular(6),
        ),
        child: IconButton(
          icon: Icon(icon, size: 16, color: Colors.white),
          onPressed: enabled ? () {} : null,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 70,
                      semanticLabel: 'Logo do Tires Guard',
                    ),
                    Image.asset(
                      'assets/images/user.png',
                      height: 60,
                      semanticLabel: 'Ícone do usuário',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.inputText),
                      tooltip: 'Voltar ao menu',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'USUÁRIOS',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.inputText,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: double.infinity, height: 1, color: Colors.grey),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Row(
                  children: const [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nome',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.inputText,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Função',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.inputText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Usuario>>(
                  future: carregarUsuarios(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Erro ao carregar usuários'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Nenhum usuário encontrado'));
                    }

                    final usuarios = snapshot.data!;
                    return Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 340,
                        child: ListView.builder(
                          itemCount: usuarios.length,
                          itemBuilder: (context, index) {
                            final usuario = usuarios[index];
                            return Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(usuario.nome,
                                                style: const TextStyle(
                                                    fontFamily: 'Inter', fontWeight: FontWeight.w500, color: AppColors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(usuario.funcao,
                                                style: const TextStyle(
                                                    fontFamily: 'Inter', fontWeight: FontWeight.w500, color: AppColors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.open_in_new, color: AppColors.white),
                                    onPressed: () => _abrirCadastroUsuario(usuario: usuario),
                                  ),
                                ),
                                const Divider(color: Colors.grey),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () => _abrirCadastroUsuario(),
                      child: const Text(
                        'Cadastrar novo usuário',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _paginaBotao(Icons.first_page, false),
                        _paginaBotao(Icons.navigate_before, false),
                        _paginaBotao(Icons.navigate_next, true),
                        _paginaBotao(Icons.last_page, true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
