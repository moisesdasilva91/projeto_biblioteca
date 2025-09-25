-- =================================================
-- BANCO DE DADOS
-- =================================================
IF DB_ID('BibliotecaDB') IS NULL
    CREATE DATABASE BibliotecaDB;
GO

USE BibliotecaDB;
GO

-- =================================================
-- TABELAS
-- =================================================

-- Tabela de livros
CREATE TABLE Livro (
    IdLivro INT IDENTITY(1,1) PRIMARY KEY,
    Titulo NVARCHAR(200) NOT NULL,
    Autor NVARCHAR(150) NOT NULL,
    Ano_Publicacao INT NOT NULL
);
GO

-- Tabela de empréstimos
CREATE TABLE Emprestimo (
    IdEmprestimo INT IDENTITY(1,1) PRIMARY KEY,
    Id_Livro INT NOT NULL,
    Data_Emprestimo DATE NOT NULL,
    Data_Devolucao DATE NULL
);
GO

-- Relacionamento: um livro pode ter vários empréstimos
ALTER TABLE Emprestimo
ADD CONSTRAINT FK_Livro_Emp FOREIGN KEY (Id_Livro)
REFERENCES Livro(IdLivro)
ON DELETE NO ACTION;
GO

-- =================================================
-- CRUD LIVROS
-- =================================================

-- Adicionar novo livro
CREATE PROCEDURE sp_add_livro
    @titulo NVARCHAR(200),
    @autor NVARCHAR(150),
    @ano_pub INT
AS
BEGIN
    INSERT INTO Livro (Titulo, Autor, Ano_Publicacao)
    VALUES (@titulo, @autor, @ano_pub)
END;
GO

-- Editar livro existente
CREATE PROCEDURE sp_edit_livro
    @id_livro INT,
    @titulo NVARCHAR(200),
    @autor NVARCHAR(150),
    @ano_pub INT
AS
BEGIN
    UPDATE Livro
    SET Titulo = @titulo,
        Autor = @autor,
        Ano_Publicacao = @ano_pub
    WHERE IdLivro = @id_livro
END;
GO

-- Listar livros
CREATE PROCEDURE sp_list_livros
    @id_livro INT = NULL
AS
BEGIN
    IF @id_livro IS NULL
        SELECT * FROM Livro
    ELSE
        SELECT * FROM Livro WHERE IdLivro = @id_livro
END;
GO

-- Apagar livro (só se não tiver empréstimos)
CREATE PROCEDURE sp_del_livro
    @id_livro INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Emprestimo WHERE Id_Livro = @id_livro)
    BEGIN
        RAISERROR('Não é possível apagar: livro está emprestado!', 16, 1)
        RETURN
    END

    DELETE FROM Livro WHERE IdLivro = @id_livro
END;
GO

-- =================================================
-- CRUD EMPRÉSTIMOS
-- =================================================

-- Inserir empréstimo
CREATE PROCEDURE sp_add_emprestimo
    @id_livro INT,
    @data_emp DATE
AS
BEGIN
    INSERT INTO Emprestimo (Id_Livro, Data_Emprestimo)
    VALUES (@id_livro, @data_emp)
END;
GO

-- Finalizar devolução
CREATE PROCEDURE sp_return_emprestimo
    @id_emp INT,
    @data_dev DATE
AS
BEGIN
    UPDATE Emprestimo
    SET Data_Devolucao = @data_dev
    WHERE IdEmprestimo = @id_emp
END;
GO

-- Listar empréstimos
CREATE PROCEDURE sp_list_emprestimos
    @id_emp INT = NULL
AS
BEGIN
    IF @id_emp IS NULL
        SELECT * FROM Emprestimo
    ELSE
        SELECT * FROM Emprestimo WHERE IdEmprestimo = @id_emp
END;
GO

-- Apagar empréstimo
CREATE PROCEDURE sp_del_emprestimo
    @id_emp INT
AS
BEGIN
    DELETE FROM Emprestimo WHERE IdEmprestimo = @id_emp
END;
GO
