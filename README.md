Carona Consciente: aplicativo móvel para conectar motoristas e comunidade acadêmica da UTFPR em traslados locais

## Descrição
O presente aplicativo trata-se de um aplicativo de carona universitária com foco na Universidade Tecnológica Federal do Paraná - Campus Campo Mourão, 
que visa unir passageiros e motoristas, servidores ou alunos da universidade, a fim de otimizar o encontro de caronas na rota da universidade.
As funcionalidades presentes no aplicativo são:
  - Criaçao de usuários, apenas com email com domínio @alunos.utfpr.edu.br ou @utfpr.edu.br;
  - Cadastro de carros por parte dos usuários;
  - Aos usuários com carros cadastrados, é possível selecionar o carro padrão;
  - Aos usuários com carros cadastrados, é possível editar ou excluir carros;
  - Aos usuários com carros cadastrados, é possível criar ou excluir caronas;
  - Aos usuários com caronas cadastradas, é possível remover usuários da carona;
  - À todos os uduários, é permito entrar e sair de caronas;
  - À todos os usuários presentes em uma carona, é possível enviar e visualizar mensagens no chat da carona;
Além disso, notificações são enviadas para o email dos usuários em situações como:
  - Criar conta;
  - Entrar em corrida, no caso de motoristas;
  - Sair ou ser removido da corrida;
  - Quando um usuário sai ou é removido de uma corrida em que se é motorista;


## Índice
- Instalação
- Uso
- Contribuição
- Licença
- Autores

## Instalação

  Para instalar o Flutter, o usuário utilizou a versão 3.22.2 no canal estável, disponível no repositório https://github.com/flutter/flutter.git.com, 
  juntamente com as ferramentas Dart 3.4.3 e DevTools 2.34.3.

  (sudo snap install flutter)

  Aqui estão as instruções para configurar o ambiente Flutter, incluindo a configuração de um emulador e as alterações necessárias no back-end.

1. **Acessar a documentação Flutter**:
   - Acesse o site da documentação oficial do Flutter: [Flutter Get Started](https://docs.flutter.dev/get-started/install?_gl=1*cp5aqc*_ga*MTc4MDUyNjk5Mi4xNzE3NzEzNzc1*_ga_/04YGWK0175*MTcyODUwODg3Ni4xMi4wLjE3Mjg1MDg4ODUuMC4wLjA).
   - Escolha o **sistema operacional** da sua máquina (Windows, macOS ou Linux).

2. **Instalação do Flutter e Ferramentas**:
   - Siga as instruções para baixar e instalar o Flutter no seu sistema operacional.
   - Verifique se tudo foi instalado corretamente com o comando `flutter doctor -v` no terminal, e instale qualquer dependência que o comando sugerir.

3. **Configuração do Emulador Móvel (Pixel 8 Pro API 30)**:
   - Caso você vá usar o emulador "Pixel 8 Pro API 30", siga os passos para configurá-lo via Android Studio:
     - No Android Studio, acesse **Tools > AVD Manager** e crie um novo dispositivo virtual.
     - Escolha o modelo **Pixel 8 Pro**, defina a API como **30**, e finalize a criação.
     - Inicie o emulador e certifique-se de que ele está funcionando corretamente com o comando `flutter devices`.

4. **Rodando o Back-End**:
   - O back-end está rodando no servidor definido no arquivo `lib/servicos/localback.dart` do projeto, localizado no diretório `carona-front/caronafront`.
   - Se for utilizar um **emulador diferente** do **Pixel 8 Pro API 30**, é necessário alterar a configuração do back-end no arquivo mencionado.
     - Atualize o **endpoint** dentro de `localback.dart` para refletir o IP do novo emulador ou o ambiente de rede apropriado para garantir a correta comunicação entre o front-end e o back-end.

  Ao garantir que o emulador e o servidor back-end estão devidamente configurados e funcionando, o ambiente estará pronto para rodar e testar o aplicativo.

  Caso esteja tendo problema entre em contato
## USO
  Para rodar a aplicação, o back-end deve estar em execução, com o emulador já inicializado. Ao executar o arquivo main.dart, 
  o aplicativo será instalado manualmente no emulador e executado, permitindo assim que o app seja inicializado. 
  Caso esteja usando a VSCode como IDE, é recomendado baixar o pluggin do "Flutter".  
## Licença
O projeto trata-se de um software livre.

## Autores
  - William Wallace Teodoro Rodrigues - williamwallace@alunos.utfpr.edu.br
  - Guilherme Almeida Lopes - guilhermealmeidalopes@alunos.utfpr.edu.br
  - Yuri Ulisses dos Santos Baza - yuribaza@alunos.utfpr.edu.br
