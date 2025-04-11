# 🇧🇷 Brasil Cripto

Aplicativo Flutter que permite consultar informações detalhadas de criptomoedas em tempo real, com base na API da [CoinGecko](https://www.coingecko.com/).  
Permite busca por nome, favoritos com persistência local e visualização de gráficos de variação de preços.

---

## 🚀 Funcionalidades

- 🔍 Campo de busca por nome da criptomoeda
- 💰 Exibição de preço atual, variação percentual e volume de mercado
- 📊 Mini gráfico de variação (7 dias) direto na lista
- ℹ️ Tela de detalhes com descrição e gráfico interativo
- ⭐ Favoritar moedas com persistência local (SharedPreferences)
- 🧭 Navegação entre home e favoritos

---

## 🛠️ Como rodar o projeto

### ✅ Requisitos:
- Flutter SDK (versão 3.29.2 recomendada)
- Dart SDK
- Android Studio, VSCode ou outro IDE com Flutter

### 📦 Dependências usadas:
```yaml
dependencies:
  flutter:
    sdk: flutter
  mobx: ^2.3.0
  flutter_mobx: ^2.0.6
  http: ^0.13.5
  shared_preferences: ^2.2.2
  fl_chart: ^0.65.0

dev_dependencies:
  build_runner: ^2.4.6
  mobx_codegen: ^2.3.0
```

### ▶️ Passo a passo para rodar localmente:

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/brasil_cripto.git
cd brasil_cripto

# Instale as dependências
flutter pub get

# Gere os arquivos do MobX
dart run build_runner build --delete-conflicting-outputs

# Rode o app
flutter run
```

---

## 🌐 API utilizada

O projeto consome dados da [CoinGecko API](https://www.coingecko.com/en/api) — totalmente gratuita e sem autenticação obrigatória, mas com suporte a `x-cg-demo-api-key`.

### Endpoints utilizados:

- `/coins/markets` → Lista moedas com preço, volume, variação e gráfico:
  ```
  https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true&price_change_percentage=24h
  ```

- `/coins/{id}` → Detalhes da moeda:
  ```
  https://api.coingecko.com/api/v3/coins/{id}
  ```

- `/coins/{id}/market_chart` → Dados para o gráfico:
  ```
  https://api.coingecko.com/api/v3/coins/{id}/market_chart?vs_currency=usd&days=7
  ```

---

## 🧠 Padrões de Projeto e Decisões Técnicas

### Arquitetura MVVM

O projeto utiliza o padrão MVVM, com:
- `models/` → Representação dos dados da API
- `views/` → Interfaces visuais
- `viewmodels/` → Controle de estado e lógica de negócio
- `services/` → Comunicação com a API

### Estado com MobX

MobX foi utilizado por sua simplicidade e reatividade, com `Observer` nas views e `@observable/@action` nos ViewModels.

### Persistência com SharedPreferences

Para salvar favoritos, foi utilizado o `SharedPreferences`, ideal para dados simples como listas de strings (`coinId`). A estrutura permite migrar facilmente para `Hive` se for necessário armazenar dados mais complexos.

### Padrões aplicados:

- Observer Pattern (MobX)
- DRY / KISS
- Princípios SOLID (especialmente SRP e Open/Closed)
- Singleton (compartilhamento do ViewModel entre telas)