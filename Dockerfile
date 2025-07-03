# Etapa 1: Definir a imagem base
# Usamos uma imagem Alpine por ser leve e segura.
FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do container
# Isso ajuda a organizar os arquivos da aplicação.
WORKDIR /app

# Etapa 3: Copiar e instalar as dependências
# Copiamos o requirements.txt primeiro para aproveitar o cache do Docker.
# Se este arquivo não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação para o container
# Copia todos os arquivos do diretório atual para o /app no container.
COPY . .

# Etapa 5: Expor a porta que a aplicação vai usar
# O Uvicorn, por padrão, roda na porta 8000.
EXPOSE 8000

# Etapa 6: Comando para iniciar a aplicação
# Inicia o servidor Uvicorn, tornando a API acessível de fora do container.
# O host 0.0.0.0 é essencial para que o container aceite conexões externas.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]