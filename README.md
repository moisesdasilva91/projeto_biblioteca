Projeto desenvolvido como parte de um desafio de estágio, com o objetivo de criar um sistema simples de gerenciamento de biblioteca.
Permite controlar livros disponíveis e registros de empréstimos, utilizando SQL Server com procedures de CRUD.

Funcionalidades

Tabelas:

Livro — armazena informações sobre os livros (título, autor, ano de publicação).

Emprestimo — registra os empréstimos dos livros.

Procedures implementadas:

sp_inserir_livro, sp_editar_livro, sp_remover_livro, sp_listar_livros

sp_inserir_emprestimo, sp_finalizar_emprestimo, sp_listar_emprestimos, sp_remover_emprestimo

Integridade referencial entre livros e empréstimos para evitar exclusões inválidas.

Tecnologias

SQL Server

Procedures para CRUD (Create, Read, Update, Delete)
