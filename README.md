
![Logo](https://github.com/AdrianoJunior/WordWise/blob/master/assets/icon/app_icon.png?raw=true)


# WordWise

O prejeto do app WordWise consiste em uma lista de palavras em inglês, onde é possível selecionar e consultar uma palavra na API https://www.wordsapi.com/, e funciona como um dicionário de fácil acesso em seu dispositivo.
Nele, é possível favoritar as palavras de seu interesse, para ter um acesso mais rápido a elas, além de contar com a função de histórico de pesquisa, onde é possível ver todas as palavras acessadas anteriormente, além de ser possível escutar a pronuncia as palavras selecionadas.

O projeto pode ser acessado em sua versão web [aqui](https://dictionary-45478.web.app/#/).


## Referência

This is a challenge by [Coodesh](https://coodesh.com/)

As tecnologias utilizadas no desenvolvimento do app foram:

- [Dart](https://dart.dev/): Dart é uma linguagem de programação desenvolvida pela Google, projetada para criar aplicativos web, mobile e desktop de forma eficiente e escalável. Com sua sintaxe simples e concisa, o Dart oferece recursos como tipagem estática, coleta de lixo automatizada e suporte a programação orientada a objetos, tornando-se uma escolha popular para o desenvolvimento de aplicativos Flutter.

- [Flutter](https://flutter.dev/): Flutter é um framework de desenvolvimento de aplicativos móveis criado pela Google que permite criar interfaces de usuário nativas para iOS e Android usando uma única base de código. Ele oferece alta performance, rapidez de desenvolvimento e uma ampla gama de widgets personalizáveis.

- [Firebase](https://firebase.google.com/?hl=pt-br): Firebase é uma plataforma de desenvolvimento de aplicativos móveis e web da Google que fornece diversos serviços, como autenticação de usuários, armazenamento em nuvem, banco de dados em tempo real e notificações push, permitindo que os desenvolvedores construam aplicativos robustos e escaláveis de forma simples e eficiente.

- [SQLite](https://pub.dev/packages/sqflite): SQLite é um sistema de gerenciamento de banco de dados relacional embutido, que não requer um servidor separado para funcionar. Ele oferece uma solução compacta, eficiente e confiável para armazenamento local de dados em aplicativos, sendo amplamente utilizado em diversos tipos de aplicações, desde dispositivos móveis até aplicações desktop. Nesta aplicação foi usado o sqflite, plugin para uso do SQLite com o Flutter.


## Documentação

### Processo de desenvolvimento

Para desenvolver este aplicativo, separei algumas etapas a serem desenvolvidas:

- Desenvolvimento da tela de introdução
- Criação da lista de palavras em memória (utilizando json salvo localmente na pasta assets/json)
- Desenvolvimento da tela de login e criação de conta
- Criação do layout da tela principal com as tabs e drawer
- Desenvolvimento da SplashPage
- Desenvolvimento da tela com a lista de palavras
- Desenvolvimento da tela com a resposta da API ou cache com a palavra selecionada
- Desenvolvimento da página de favoritos
- Desenvolvimento da página de histórico
- Desenvolvimento do código para linkar o histórico e favoritos no [Firestore](https://firebase.google.com/docs/firestore?hl=pt-br) com o ID do usuário fornecido pelo [Firebase Authentication](https://firebase.google.com/docs/auth?hl=pt-br).
- Upload para o GitHub
- Atualização do README.md e commit final
## Funcionalidades

- Página de introdução
- Login com email/senha
- Listagem de palavras com busca e seleção
- Página de detalhes da palavra selecionada
- Reprodução em áudio da palavra selecionada (apenas na versão mobile)
- Armazenamento em cache para buscas futuras mais rápidas
- Página de palavras favoritas
- Página de histórico
- Multiplataforma


## Instalação
Para instalar e utilizar o projeto em seu computador, siga os seguintes passos:

### Instalação do Flutter

Para configurar o Flutter em seu computador, siga estes passos:

- Faça o download e a instalação do Flutter SDK no site oficial do [Flutter](https://flutter.dev/), de acordo com o seu sistema operacional.
- Extraia o arquivo baixado e adicione o diretório bin do Flutter ao seu PATH de sistema.
- Abra um terminal ou prompt de comando e execute o comando flutter doctor para verificar se há alguma dependência faltando ou configuração adicional necessária.
- Caso haja alguma dependência faltando, siga as instruções fornecidas pelo flutter doctor para instalá-las corretamente.
- Após a instalação das dependências, execute novamente o comando flutter doctor para verificar se tudo está configurado corretamente.
- Configure um editor de código compatível com o Flutter, como o [Visual Studio Code](https://code.visualstudio.com/), instalando as extensões recomendadas para desenvolvimento Flutter.
- Certifique-se de consultar a documentação oficial do Flutter para obter instruções mais detalhadas e atualizadas de acordo com seu sistema operacional.

### Execução do projeto

Para executar o projeto basta clonar o repositório para uma pasta do seu computador e abrir o projeto em uma IDE compátivel, devidamente configurada seguindo o passo-a-passo acima ou a documentação oficial do flutter.

Ao abrir o projeto pela primeira vez, no terminal acesse o diretório raiz do projeto e utilize o comando:

```
flutter pub get
```

Caso sejam apresentados erros, verifique se as configurações do Flutter no sistema estão corretas e se as versões são compatíveis.
OBS: O projeto foi desenvolvido em um ambiente com as seguintes configurações do Flutter:

- Flutter version 3.10.5
- Dart version 3.0.5
- DevTools version 2.23.1

Após executar o comando "flutter pub get" para obter as dependências do seu projeto Flutter, siga os seguintes passos para executar o aplicativo:

- Certifique-se de ter um dispositivo virtual ou físico configurado e conectado ao seu computador. Você pode verificar os dispositivos disponíveis usando o comando ```flutter devices``` no terminal.

- No terminal, navegue até a pasta raiz do seu projeto Flutter usando o comando ```cd caminho/do/seu/projeto```.

- Execute o comando ```flutter run``` para iniciar o aplicativo no dispositivo selecionado. Se houver mais de um dispositivo conectado, você precisará especificar o dispositivo de destino com a flag "-d" seguida pelo ID do dispositivo. Por exemplo, ```flutter run -d deviceID```.

- Aguarde alguns instantes enquanto o Flutter compila o aplicativo e o instala no dispositivo.

- O aplicativo será iniciado automaticamente no dispositivo selecionado, e você poderá ver a saída do aplicativo no terminal.

- Para fazer alterações no código e visualizar as atualizações em tempo real, salve os arquivos modificados e o Flutter Hot Reload será acionado automaticamente, refletindo as alterações no aplicativo em execução.

- Lembre-se de que essas são apenas etapas básicas e podem variar dependendo da configuração do seu projeto ou ambiente de desenvolvimento. Consulte a documentação oficial do Flutter para obter mais detalhes e opções avançadas de execução e depuração de aplicativos Flutter.
## Stack utilizada

**Front-end:** Flutter

**Mobile:** Flutter

**Back-end:** Firebase, SQLite (sqflite), WordsAPI


## Autor

- [@AdrianoJunior](https://www.github.com/AdrianoJunior)

