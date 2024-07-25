## Desafio Técnico Oficinaria

Este projeto é uma aplicação web para busca de CEPs. Ele utiliza a [API de CEP do Awesome API](https://docs.awesomeapi.com.br/api-cep) para obter informações completas de endereço, incluindo o DDD da área. Além disso, a aplicação integra o Google Maps para exibir a localização geográfica do endereço, facilitando a visualização para o usuário.

## Configurando Seu Ambiente

Para executar este projeto, você precisará de um computador, preferencialmente com Linux, e a linguagem de programação Ruby na versão 3.2.0, junto com o framework Rails na versão 7.0.8.3.

### Instalando Ruby

Primeiramente, instale o Ruby 3.2.0. Você pode usar o [RVM](https://rvm.io/) ou o [asdf](https://github.com/asdf-vm/asdf).

### Instalando Rails

Depois de instalar o Ruby, instale o Rails com o seguinte comando no seu terminal:

```
gem install rails --version 7.0.8.3
```

## Como Executar o Projeto

1. **Instale as dependências** definidas no arquivo `Gemfile` com o seguinte comando:

    ```
    bundle install
    ```

2. **Execute as migrations** com o comando:

    ```
    rails db:migrate
    ```

3. **Compile os assets** com o comando:

    ```
    rails assets:precompile
    ```

4. **Popule o banco de dados** com o comando:

    ```
    rails db:seed
    ```

5. **Inicie o servidor** com o comando:

    ```
    rails server
    ```

6. **Acesse a aplicação** no seu navegador em:

    ```
    http://localhost:3000
    ```

## Executando Testes e Verificações

### Testes com RSpec

Para rodar os testes automatizados com o RSpec, utilize o seguinte comando:

```
bundle exec rspec
```

### Verificação de Sintaxe e Boas Práticas com RuboCop

Para verificar a sintaxe e garantir o uso de boas práticas de programação com RuboCop, utilize o comando:

```
bundle exec rubocop
```

### Análise de Código com RubyCritic

Para gerar um relatório de análise do código utilizando o RubyCritic, execute o comando:

```
bundle exec rubycritic
```

Esses comandos ajudarão a garantir a qualidade e a manutenção do código ao longo do desenvolvimento do projeto.

## Gems Utilizadas

- **Para escrever e executar testes:**
  * `gem 'rspec-rails'`

- **Para verificar e analisar erros de sintaxe e boas práticas:**
  * `gem 'rubocop', require: false`
  * `gem 'rubycritic'`

- **Para estilização do Front-End:**
  * `gem "tailwindcss-rails", "~> 2.6"`

- **Para depuração interativa:**
  * `gem 'pry', '~> 0.14.2'`

- **Para fazer requisições HTTP:**
  * `gem 'faraday', '~> 2.7', '>= 2.7.11'`

- **Para aceleração de páginas estilo SPA:**
  * `gem "turbo-rails"`

- **Para o framework JavaScript do Hotwire:**
  * `gem "stimulus-rails"`

## Atualizações Futuras

* Adicionar a funcionalidade de CEPs mais buscados por cidade/estado.
* Adicionar a funcionalidade de quantidade de CEPs por estado
