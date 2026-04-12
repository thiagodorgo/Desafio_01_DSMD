# FastLocation

  Aplicativo mobile para consulta de CEP e enderecos desenvolvido para a empresa FastDelivery.

  ## Funcionalidades

  - Consulta de endereco por CEP (API publica ViaCEP)
  - Exibicao dos dados completos do endereco consultado
  - Historico local de enderecos consultados
  - Traco de rota do local atual ate o endereco consultado
  - Tela de abertura com animacao

  ## Tecnologias utilizadas

  - Flutter (Android e iOS)
  - Dio — comunicacao HTTP com a API externa
  - MobX + flutter_mobx — gerenciamento de estado reativo
  - Hive + hive_flutter — armazenamento local
  - map_launcher — abertura de aplicativos de mapa
  - geocoding — conversao de endereco em coordenadas geograficas

  ## Pre-requisitos

  - Flutter SDK >= 2.18.0 instalado
  - Android Studio ou Xcode configurado
  - Dispositivo fisico ou emulador

  ## Como executar

  ### 1. Instalar dependencias

  ```bash
  flutter pub get
  ```

  ### 2. Executar o app

  ```bash
  flutter run
  ```

  ### 3. Gerar arquivos do MobX (opcional — ja incluidos no projeto)

  Caso precise regenerar os arquivos `.g.dart`:

  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```

  ## Estrutura do projeto

  ```
  lib/
    main.dart
    src/
      shared/
        colors/         # Paleta de cores do aplicativo
        components/     # Componentes reutilizaveis
        metrics/        # Constantes de espacamento
        storage/        # Configuracao do armazenamento local (Hive)
      routes/           # Constantes de rotas
      http/             # Configuracao do cliente HTTP (Dio)
      modules/
        initial/        # Tela de abertura (splash)
          page/
        home/           # Modulo principal de consulta de CEP
          model/        # Modelo de dados do endereco
          repositories/ # Comunicacao com API externa e armazenamento local
          service/      # Regras de negocio
          controller/   # Controlador com MobX
          components/   # Componentes da tela home
          page/         # Tela principal
        history/        # Modulo de historico de consultas
          controller/   # Controlador com MobX
          page/         # Tela de historico
  ```

  ## API utilizada

  [ViaCEP](https://viacep.com.br) — API publica gratuita para consulta de CEP e enderecos brasileiros.

  Exemplos de uso:
  - Consulta por CEP: `https://viacep.com.br/ws/01310100/json/`
  