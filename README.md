# Tires Guard - Sistema de Gerenciamento de Manutenção de Pneus

Tires Guard é um sistema integrado para o controle e manutenção de pneus de caminhões, visando 
digitalizar processos, garantir maior precisão nos dados e reduzir custos operacionais. 
Ele é composto por um aplicativo mobile desenvolvido em Flutter.

## 📱 Funcionalidades do Aplicativo

### 🛠 Gestão de Atendimentos

* Lista de atendimentos com filtros por status: pendente, concluído, todos;
* Cadastro de novos atendimentos com dados do veículo, responsável e observações;
* Tela de detalhes do atendimento com opção de edição e conclusão;
* Galeria de fotos para o atendimento com captura via câmera.

### 🗺 Mapa de Pneus do Atendimento

* Visualização de layout com o mapa de pneus;
* Cada pneu possui um botão que abre tela modal de aferição com os campos:
    * Sulco
    * Calibragem
    * Status
    * Fogo
    * Vida
    * Número de série 
* Pneus aferidos são destacados visualmente com cor verde;
* Botões "Salvar" e "Cancelar" encerram o processo;
* Cabeçalho exibe veículo, cor e placa;
* Layout visual segue padrão do sistema com design escuro e responsivo.

### 🗺 Mapa de Pneus do Chassi

* Permite definir a quantidade de eixos, pneus e steps;
* Quantidade de pneus por eixo pode ser ajustada (mínimo 2, máximo 6);
* Cada pneu tem formulário com número de fogo, vida e série;
* Pneus confirmados aparecem com imagem diferenciada (verde);
* Interface interativa com botões + e - para eixos, steps e pneus por eixo;
* Salva as configurações para uso posterior.

### 🧾 Cadastro e Gerenciamento

* Cadastro de:

    * Caminhões (modelo, placa, cor, ano, chassi);
    * Chassis (com número de eixos, steps e pneus por eixo);
    * Pneus (marca, série, fabricante, status/local, número de fogo e aro);
    * Usuários (com função Gestor ou Borracheiro e controle de senha);

### 🔐 Login e Segurança

* Tela de login com validação de e-mail e senha;
* Redirecionamento ao menu do gestor após login bem-sucedido;
* Opção de criação de nova conta e recuperação de senha;
* Feedback visual com Snackbars personalizados para validações e sucesso.

### 📋 Menu Gestor

* Tela principal após login do gestor;
* Acesso às funcionalidades principais via botões organizados verticalmente:
    * Atendimentos
    * Caminhões
    * Chassis
    * Pneus
    * Usuários
* Botão de logout no cabeçalho;
* Tela com design escuro, ícones acessíveis e responsivos.

### 🛞 Tela de Pneus

* Lista de pneus cadastrados com exibição das colunas: série, fogo e marca;
* Dados apresentados em layout organizado e responsivo;
* Ícone de ação para abrir a tela de edição de um pneu específico;
* Botão para cadastro de novo pneu, levando à tela de formulário completo;
* Navegação por páginas (ícones de primeira, anterior, próxima e última página);

### 📝 Cadastro de Usuário

* Tela de criação de conta com campos para nome, e-mail e senha;
* Validação de campos obrigatórios e formatação correta de e-mail;
* Verificação de senha mínima com 6 caracteres;
* Feedback ao usuário via snackbar e redirecionamento automático após sucesso;

### 👥 Tela de Usuários

* Exibe lista de usuários com colunas Nome e Função;
* Ícone para abrir tela de edição de cada usuário;
* Botão para cadastrar novo usuário;
* Estrutura de paginação com botões para primeira, anterior, próxima e última página;
* Interface moderna, acessível e alinhada com o tema visual do sistema.

## ⚙️ Tecnologias Utilizadas

* **Flutter**: SDK para desenvolvimento mobile;
* **Dart**: Linguagem principal da aplicação;
* **Image Picker**: Captura de fotos com a câmera do dispositivo;
* **Intl**: Formatação de datas e localização;

## 👤 Autor

Daniel Numair
Diuly Jorge Rocha
Gabryelle da Rocha Medeiros

---

Este projeto foi desenvolvido para fins acadêmicos, no contexto da disciplina 
**Laboratório de Simulação e Prototipagem**, ministrada pelo Professor **Taciano Balardin de Oliveira**.
