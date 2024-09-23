# Movie App 🎬

Este é um aplicativo de filmes desenvolvido em Flutter que permite aos usuários buscar por filmes populares, visualizar detalhes dos filmes e explorar uma vasta coleção de títulos. O aplicativo utiliza a API do The Movie Database (TMDb) para buscar e exibir informações sobre filmes.

## Funcionalidades 📱

- **Busca de Filmes**: Utilize a barra de pesquisa para encontrar filmes específicos. Os resultados são atualizados em tempo real conforme o usuário digita.
- **Exibição de Filmes Populares**: A tela inicial do aplicativo exibe uma lista dos filmes mais populares, utilizando um layout horizontal para fácil navegação.
- **Detalhes dos Filmes**: Ao selecionar um filme, o usuário é redirecionado para uma página de detalhes que exibe informações detalhadas sobre o filme, como sinopse, data de lançamento e classificação.
- **Carregamento Assíncrono de Dados**: O aplicativo utiliza `FutureBuilder` para carregar e exibir dados de forma assíncrona, garantindo uma experiência de usuário fluida e responsiva.
- **Interface de Usuário Intuitiva**: A interface do usuário foi projetada para ser simples e intuitiva, utilizando componentes nativos do Flutter como `CupertinoSearchTextField` e `ListView.builder`.

## Tecnologias Utilizadas 🛠️

- **Flutter**: Framework principal utilizado para o desenvolvimento do aplicativo.
- **Dart**: Linguagem de programação utilizada para desenvolver a lógica do aplicativo.
- **API do TMDb**: Fonte de dados para buscar e exibir informações sobre filmes.
- **Cupertino Widgets**: Utilizados para criar uma interface elegante e consistente em todas as plataformas.

## Configuração e Instalação 🚀

1. **Clone o Repositório**:

   ```bash
   git clone https://github.com/seu-usuario/movie-app.git
   cd movie-app  

2. **Instalar as dependências do projeto**:
   ```bash
   flutter pub get

3. **Configure a API Key**:

  - Obtenha uma chave de API do The Movie Database.
  - Substitua a variável api_key na ApiServices pela sua chave de API.

4. **Rode o projeto**:
   ```bash
   flutter run
