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
- Flutter SDK (versão 3.13+ recomendada)
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