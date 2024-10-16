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

Para instalar o Flutter, utilizei a versão 3.22.2 no canal estável, disponível no repositório oficial: [Flutter GitHub Repository](https://github.com/flutter/flutter.git.com). Também foram utilizadas as ferramentas Dart 3.4.3 e DevTools 2.34.3.

Para instalação via **Snap** em sistemas Linux, execute o seguinte comando:

```bash
sudo snap install flutter
```

Caso o comando **Snap** não esteja disponível ou aplicável, você pode seguir os passos da documentação oficial do Flutter:

1. Acesse a [documentação oficial do Flutter](https://docs.flutter.dev/get-started/install?_gl=1*cp5aqc*_ga*MTc4MDUyNjk5Mi4xNzE3NzEzNzc1*_ga_/04YGWK0175*MTcyODUwODg3Ni4xMi4wLjE3Mjg1MDg4ODUuMC4wLjA).
2. Selecione o sistema operacional da sua máquina (Windows, macOS ou Linux).
3. Escolha o tipo de aplicação que deseja desenvolver.
4. Siga as instruções detalhadas para completar a instalação.

1. **Flutter dependências**:
Para verificar se todas as dependências do Flutter foram instaladas corretamente, execute o seguinte comando:

```bash
flutter doctor -v
```

Esse comando irá listar as ferramentas e bibliotecas necessárias para o funcionamento do Flutter. Se alguma dependência não estiver instalada, siga as recomendações fornecidas pelo próprio comando para realizar as instalações faltantes.
  
## USO
Para rodar a aplicação, certifique-se de que o back-end esteja em execução.
o comando a seguir deve ser executado para entrar acessar o diretório da aplicação:

```bash
cd /carona-front/caronafront
```

Para executar o front-end, utilize o comando:

```bash
flutter run
```

Alternativamente, você pode executar o arquivo main.dart diretamente através de uma IDE, como o Visual Studio Code ou Android Studio.
Escolha a opção no qual gostaria que o front-end seja executado.

*OBS: Antes de rodar a aplicação, certifique-se de que o emulador já está em execução. 
Somente após iniciar o emulador a opção de rodar a aplicação nele será exibida.

## Configuração da API
  Para configurar a conexão entre a localização do 
## Licença
O projeto trata-se de um software livre.

## Autores
  - William Wallace Teodoro Rodrigues - williamwallace@alunos.utfpr.edu.br
  - Guilherme Almeida Lopes - guilhermealmeidalopes@alunos.utfpr.edu.br
  - Yuri Ulisses dos Santos Baza - yuribaza@alunos.utfpr.edu.br
