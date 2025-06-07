import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../models/usuario.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  final Usuario? usuario;

  const CadastroUsuarioScreen({super.key, this.usuario});

  @override
  State<CadastroUsuarioScreen> createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaAtualController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  String? _funcaoSelecionada;

  @override
  void initState() {
    super.initState();
    if (widget.usuario != null) {
      _nomeController.text = widget.usuario!.nome;
      _emailController.text = widget.usuario!.email;
      _funcaoSelecionada = widget.usuario!.funcao;
    } else {
      _funcaoSelecionada = 'Borracheiro';
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaAtualController.dispose();
    _novaSenhaController.dispose();
    super.dispose();
  }

  void _salvarAlteracoes() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Alterações salvas com sucesso!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.button,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/usergrande.png',
                    height: 240,
                    semanticLabel: 'Ícone do usuário',
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: CustomTextField(
                      controller: _nomeController,
                      hintText: 'Nome',
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Informe o nome' : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Informe o e-mail';
                        if (!value.contains('@')) return 'E-mail inválido';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      value: _funcaoSelecionada,
                      items: const [
                        DropdownMenuItem(
                          value: 'Gestor',
                          child: Text('Gestor'),
                        ),
                        DropdownMenuItem(
                          value: 'Borracheiro',
                          child: Row(
                            children: [
                              Icon(Icons.star_border, color: AppColors.inputText, size: 20),
                              SizedBox(width: 8),
                              Text('Borracheiro'),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _funcaoSelecionada = value;
                        });
                      },
                      validator: (value) => value == null ? 'Selecione a função' : null,
                      dropdownColor: AppColors.inputBackground,
                      style: const TextStyle(color: AppColors.inputText, fontFamily: 'Inter'),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputBackground,
                        hintText: 'Função',
                        hintStyle: TextStyle(color: AppColors.inputText),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: CustomTextField(
                      controller: _senhaAtualController,
                      hintText: 'Senha atual',
                      icon: Icons.lock_outline,
                      obscure: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Informe a senha atual';
                        if (value.length < 6) return 'A senha deve ter no mínimo 6 caracteres';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: CustomTextField(
                      controller: _novaSenhaController,
                      hintText: 'Nova senha',
                      icon: Icons.lock_outline,
                      obscure: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Informe a nova senha';
                        if (value.length < 6) return 'A senha deve ter no mínimo 6 caracteres';
                        if (value != _senhaAtualController.text) return 'As senhas devem coincidir';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 300,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      onPressed: _salvarAlteracoes,
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 300,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Voltar',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
