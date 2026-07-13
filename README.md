# Projeto Python

Este projeto utiliza o banco de dados PostgreSQL, o ambiente virtual (venv) em Python, bem como algumas dependências para execução.

---

## Requisitos

- PostgreSQL
- Python 3.10+
- pip

---

OBS: Os comandos abaixo podem ser executados com o prefixo "python..." ou "python3...", a depender de como a linguagem foi istalada no seu sistema.

## 1. Criar ambiente virtual (venv) e instalar dependências

Crie o ambiente na mesma pasta onde estão os scripts do projeto:

```bash
python -m venv .venv
```

Para acessar o ambiente virtual:

### Linux / macOS

```bash
source .venv/bin/activate
```

### Windows (CMD)

```cmd
.venv\Scripts\activate.bat
```

### Windows (PowerShell)

```powershell
.venv\Scripts\Activate.ps1
```

Dentro do ambiente virtual, execute o seguitne comando para instalar as dependências:

```bash
pip install numpy scipy scikit-fuzzy matplotlib networkx psycopg2-binary pandas
```

Caso não consiga executar algum comando acima, atualize o pip:

```bash
python -m pip install --upgrade pip
```

## 2. Carregar o banco com os dados do dataset

Esta etapa é possível ser feita através do arquivo dump.sql ou executando o script load_db.py. Mas de abas as maneiras, é necessário criar um banco local antes.
Então, crie um banco no Postgre com o nome recommendation_films_db.

Via arquivo dump.sql:
```bash
psql -U meu_usuario -d recommendation_films_db < dump.sql
```

Via script (Após entrar no venv):
```bash
python3 load_db.py
```

## 3. Executar o script de recomendação
Por fim, é só executar o script de recomendação e ver o resultado no prompt ou na tabela do banco depois.

```bash
python3 recommendation.py
```
ou
```bash
python3 recommendation.py --avaliar
```

## 4. Modos do Script
De acordo com o tópico 3, o script tem dois modos de execução. No primeiro, o usuário definirá manualmente qual usuário do banco e qual filme será utilizado (alterando no próprio código). E no segundo, o script rodará com os usuários pré-definidos de teste, para isso, será necessário criá-los no banco. O arquivo "cenarios_teste_fuzzy.sql" contém todos os comandos para a criação deles, e caso não queira usar esse arquivo, pode usar o "dump.sql" para carregar todo o banco de vez.
