# Alocador de Professores

![Status](https://img.shields.io/badge/status-em%20desenvolvimento-blue) ![License](https://img.shields.io/badge/license-MIT-green)

---

## Sumário

- [Descrição](#descrição)
- [Funcionalidades](#funcionalidades)
- [Fluxo de Uso](#fluxo-de-uso)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Objetivo](#objetivo)
- [Implementações](#implementações)

---

## Descrição

O **Alocador de Professores** é um sistema para **alocação automatizada de turmas em salas**.  
Cada turma é representada por um professor, e o sistema garante que **restrições de horário, capacidade e requisitos** sejam respeitadas, oferecendo **ajustes manuais** e visualizações organizadas para administradores e professores.

> *Nota*: O nome “Alocador de Professores” se refere ao fato de cada turma ser identificada pelo professor responsável.

---

## Funcionalidades

### Acesso e Perfis
- Login e cadastro com **matrícula e senha**.
- Perfis diferenciados para **Administrador** e **Professor**.

### Administrador
- Cadastro e edição de salas e turmas.
- Geração **automática de alocações** considerando restrições.
- Visualização e ajustes das alocações.

### Professor
- Visualização de turmas e alocações atribuídas.
- Edição de **requisitos específicos** das turmas.

### Validação de Conflitos
- Conflitos detectados automaticamente:
  - **Horários** (sobreposição de aulas)
  - **Capacidade** (excedente de alunos por sala)
  - **Requisitos** (necessidades não atendidas)

### Persistência
- Armazenamento e recuperação de dados para manter histórico e consistência.

---

## Fluxo de Uso

1. **Login ou Cadastro**  
   Usuário entra no sistema com matrícula e senha ou cria nova conta.

2. **Gestão de Alocações (Administrador)**  
   - Cadastra salas e turmas.  
   - Gera alocações automaticamente ou faz ajustes manuais.  

3. **Consulta e Edição (Professor)**  
   - Visualiza turmas e alocações atribuídas.  
   - Altera requisitos das suas turmas, se necessário.  

4. **Validação**  
   - O sistema verifica conflitos de horários, capacidade ou requisitos.  

---

## Estrutura do Projeto

- **Interface de Login e Cadastro**
- **Painel do Administrador**  
  Gestão de salas, turmas e alocações
- **Painel do Professor**  
  Visualização e ajustes de turmas/alocações

---

## Objetivo

Oferecer uma solução eficiente para instituições acadêmicas que necessitam **alocar turmas em salas que atendam seus requisitos e capacidades**, reduzindo erros manuais e otimizando o planejamento.

---

## Implementações

- **Versão Funcional em Haskell**  
  Para explorar conceitos de programação funcional e imutabilidade na solução do problema.  

- **Versão Lógica em Prolog**  
  Para implementar e validar a lógica de restrições e alocações através de programação lógica.  

---

> **Observação:** Este projeto está em desenvolvimento e pode sofrer alterações estruturais ou visuais durante sua evolução.
