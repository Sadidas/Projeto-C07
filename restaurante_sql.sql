DROP DATABASE IF EXISTS restaurante_db;
CREATE DATABASE restaurante_db;
USE restaurante_db;

-- Implemente o script SQL do modelo criado na entrega anterior (banco de dados, tabelas);


CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Funcionario (
    id_funcionario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NULL
);

CREATE TABLE Mesa (
    id_mesa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    numero INT NOT NULL UNIQUE CHECK (numero > 0),
    capacidade INT NOT NULL CHECK (capacidade > 0),
    status VARCHAR(20) NOT NULL 
    CHECK (status IN ('DISPONIVEL', 'OCUPADA', 'RESERVADA'))
);

CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL UNIQUE,
    descricao VARCHAR(255) NULL
);

CREATE TABLE Prato (
    id_prato INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255) NULL,
    preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);

CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    status VARCHAR(30) NOT NULL CHECK 
    (status IN ('PENDENTE', 'EM_PREPARACAO', 'FINALIZADO', 'ENTREGUE', 'CANCELADO', 'PAGO')),
    id_cliente INT NOT NULL,
    id_mesa INT NOT NULL,
    id_funcionario INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_mesa) REFERENCES MESA(id_mesa),
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO(id_funcionario)
);

CREATE TABLE Item_pedido (
    id_item INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario > 0),
    id_pedido INT NOT NULL,
    id_prato INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    FOREIGN KEY (id_prato) REFERENCES PRATO(id_prato)
);

CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    data_pagamento DATETIME NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    id_pedido INT NOT NULL UNIQUE,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);


-- Faça a inserção dos dados dentro do banco (mínimo 5 registros para cada tabela);

INSERT INTO Cliente (nome, telefone, email) VALUES
('João da Silva', '35990000001', 'joao.silva@gmail.com'),
('Maria Oliveira', '35990000002', 'maria.oliveira@gmail.com'),
('Pedro Santos', '35990000003', 'pedro.santos@gmail.com'),
('Ana Pereira', '35990000004', 'ana.pereira@gmail.com'),
('Carlos Souza', '35990000005', 'carlos.souza@gmail.com');

INSERT INTO Funcionario (nome, cargo, telefone) VALUES
('Lucas Martins', 'Garçom', '35980000001'),
('Beatriz Costa', 'Cozinheira', '35980000002'),
('Rafael Rocha', 'Caixa', '35980000003'),
('Carla Mendes', 'Gerente', '35980000004'),
('Daniel Nunes', 'Atendente', '35980000005');

INSERT INTO Mesa (numero, capacidade, status) VALUES
(1, 4, 'OCUPADA'),
(2, 2, 'DISPONIVEL'),
(3, 4, 'OCUPADA'),
(4, 6, 'RESERVADA'),
(5, 2, 'DISPONIVEL');

INSERT INTO Categoria (nome, descricao) VALUES
('Entradas', 'Pratos iniciais para aperitivo.'),
('Pratos Principais', 'Pratos de maior volume e valor.'),
('Sobremesas', 'Doces e sobremesas finais.'),
('Bebidas', 'Refrigerantes, sucos e outras bebidas.'),
('Massas', 'Massas e pizzas da casa.');

INSERT INTO Prato (nome, descricao, preco, id_categoria) VALUES
('Feijoada', 'Feijoada completa com arroz, couve e laranja.', 35.50, 2),
('Lasanha', 'Lasanha bolonhesa com queijo e molho.', 42.00, 5),
('Picanha', 'Picanha grelhada com farofa e arroz.', 52.90, 2),
('Pizza', 'Pizza de muçarela com molho de tomate.', 39.00, 5),
('Hambúrguer', 'Hambúrguer artesanal com queijo e batata.', 28.00, 2),
('Pudim', 'Pudim de leite condensado.', 16.50, 3),
('Refrigerante', 'Refrigerante 600ml.', 8.00, 4),
('Suco natural', 'Suco natural de laranja.', 12.00, 4);

INSERT INTO Pedido (data_hora, status, id_cliente, id_mesa, id_funcionario) VALUES
('2025-01-15 19:30:00', 'FINALIZADO', 1, 1, 1),
('2025-01-15 20:15:00', 'EM_PREPARACAO', 2, 2, 2),
('2025-01-16 18:40:00', 'ENTREGUE', 3, 4, 5),
('2025-01-16 21:10:00', 'PAGO', 4, 3, 1),
('2025-01-17 09:00:00', 'CANCELADO', 5, 5, 3);

INSERT INTO Item_pedido (quantidade, preco_unitario, id_pedido, id_prato) VALUES
(1, 35.50, 1, 1),
(2, 12.00, 1, 8),
(2, 39.00, 2, 4),
(2, 8.00, 2, 7),
(1, 42.00, 3, 2),
(2, 16.50, 3, 6),
(1, 52.90, 4, 3),
(2, 28.00, 4, 5),
(2, 8.00, 4, 7),
(1, 35.50, 5, 1),
(1, 12.00, 5, 8);

INSERT INTO Pagamento (valor, data_pagamento, forma_pagamento, id_pedido) VALUES
(59.50, '2025-01-15 19:45:00', 'DINHEIRO', 1),
(94.00, '2025-01-15 20:35:00', 'CARTAO', 2),
(75.00, '2025-01-16 19:10:00', 'PIX', 3),
(124.90, '2025-01-16 21:40:00', 'CARTAO', 4),
(47.50, '2025-01-17 09:20:00', 'DINHEIRO', 5);

-- SELECT * FROM Cliente;
-- SELECT * FROM Funcionario;
-- SELECT * FROM Mesa;
-- SELECT * FROM Categoria;
-- SELECT * FROM Prato;
-- SELECT * FROM Pedido;
-- SELECT * FROM Item_pedido;
-- SELECT * FROM Pagamento;


-- Utilize comandos de manipulação de dados (DML) e explique o motivo da utilização deles;

-- INSERT: cadastrar um novo cliente
INSERT INTO CLIENTE (nome, telefone, email)
VALUES ('Luiza Mendes', '35990000008', 'luiza.mendes@gmail.com');

-- UPDATE: atualizar o status de um pedido
UPDATE PEDIDO
SET status = 'EM_PREPARACAO'
WHERE id_pedido = 1;

-- DELETE: remover um cliente caloteiro
DELETE FROM CLIENTE
WHERE email = 'luiza.mendes@gmail.com';

-- SELECT: consultar pedidos realizados
SELECT p.id_pedido AS numero_do_pedido,
       c.nome AS cliente,
       p.status,
       DATE_FORMAT(p.data_hora, '%d/%m/%Y %H:%i') AS data_hora
FROM PEDIDO p
INNER JOIN CLIENTE c ON c.id_cliente = p.id_cliente
ORDER BY p.data_hora;

-- Crie dois usuários e relacione-os por meio de uma ROLE (função);

DROP USER IF EXISTS 'restaurante_atendente'@'localhost';
DROP USER IF EXISTS 'restaurante_gerente'@'localhost';
DROP ROLE IF EXISTS 'role_restaurante';

CREATE ROLE 'role_restaurante';

GRANT SELECT ON restaurante_db.* TO 'role_restaurante';
GRANT INSERT ON restaurante_db.CLIENTE TO 'role_restaurante';
GRANT INSERT ON restaurante_db.PEDIDO TO 'role_restaurante';
GRANT INSERT ON restaurante_db.ITEM_PEDIDO TO 'role_restaurante';
GRANT INSERT ON restaurante_db.PAGAMENTO TO 'role_restaurante';
GRANT UPDATE ON restaurante_db.PEDIDO TO 'role_restaurante';
GRANT UPDATE ON restaurante_db.MESA TO 'role_restaurante';

CREATE USER 'restaurante_atendente'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'restaurante_gerente'@'localhost' IDENTIFIED BY 'admin';

GRANT 'role_restaurante' TO 'restaurante_atendente'@'localhost';
GRANT 'role_restaurante' TO 'restaurante_gerente'@'localhost';

SET DEFAULT ROLE 'role_restaurante' TO 'restaurante_atendente'@'localhost';
SET DEFAULT ROLE 'role_restaurante' TO 'restaurante_gerente'@'localhost';

-- SHOW GRANTS FOR 'restaurante_atendente'@'localhost';
-- SHOW GRANTS FOR 'restaurante_gerente'@'localhost';


-- Faça buscas complexas com JOIN (utilizando os 3 tipos iniciais de relacionamento - 
-- 1:1, 1:N e N:M obrigatoriamente);

-- 1:1
SELECT p.id_pedido,
       p.data_hora,
       pg.valor,
       pg.forma_pagamento,
       p.status
FROM PEDIDO p
INNER JOIN PAGAMENTO pg ON pg.id_pedido = p.id_pedido
ORDER BY p.id_pedido;

-- 1:N
SELECT c.id_cliente,
       c.nome AS cliente,
       p.id_pedido,
       p.data_hora,
       p.status
FROM CLIENTE c
INNER JOIN PEDIDO p ON p.id_cliente = c.id_cliente
ORDER BY c.nome, p.id_pedido;

-- N:M
SELECT p.id_pedido,
       pr.nome AS prato,
       ip.quantidade,
       ip.preco_unitario,
       (ip.quantidade * ip.preco_unitario) AS subtotal
FROM PEDIDO p
INNER JOIN ITEM_PEDIDO ip ON ip.id_pedido = p.id_pedido
INNER JOIN PRATO pr ON pr.id_prato = ip.id_prato
ORDER BY p.id_pedido, pr.nome;


-- Crie uma Procedure, uma View, um Trigger e uma Function no 
-- mínimo, explicando o porquê da criação de cada objeto na documentação.

-- PROCEDURE

-- Uma lista dos atuais pedidos ativos para os cozinheiros e garçons saberem o 
-- que ainda não foi finalizado e/ou pago

DROP PROCEDURE IF EXISTS procedure_listar_ativos;
DELIMITER $$

CREATE PROCEDURE procedure_listar_ativos()
BEGIN
    SELECT id_pedido, status
    FROM PEDIDO
    WHERE status NOT IN ('PAGO', 'CANCELADO');
END$$

DELIMITER ;

CALL procedure_listar_ativos();


-- VIEW

-- Um relatorio completo para o gerente identificar e analizar os dados mais 
-- importantes do restaurante

DROP VIEW IF EXISTS view_relatorio_gerente;

CREATE VIEW view_relatorio_gerente AS
SELECT p.id_pedido,
       p.data_hora,
       c.nome AS cliente,
       f.nome AS funcionario,
       m.numero AS mesa,
       p.status,
       COUNT(ip.id_item) AS quantidade_itens,
       COALESCE(SUM(ip.quantidade * ip.preco_unitario), 0) AS valor_total,
       pg.forma_pagamento
FROM PEDIDO p
INNER JOIN CLIENTE c ON c.id_cliente = p.id_cliente
INNER JOIN FUNCIONARIO f ON f.id_funcionario = p.id_funcionario
INNER JOIN MESA m ON m.id_mesa = p.id_mesa
LEFT JOIN ITEM_PEDIDO ip ON ip.id_pedido = p.id_pedido
LEFT JOIN PAGAMENTO pg ON pg.id_pedido = p.id_pedido
GROUP BY p.id_pedido,
         p.data_hora,
         c.nome,
         f.nome,
         m.numero,
         p.status,
         pg.forma_pagamento;

SELECT *
FROM view_relatorio_gerente
ORDER BY id_pedido;


-- TRIGGER

-- Validação de forma de pagamento para que o garçom não leve calote

DROP TRIGGER IF EXISTS trigger_validar_forma;

DELIMITER $$

CREATE TRIGGER trigger_validar_forma
BEFORE INSERT ON PAGAMENTO
FOR EACH ROW
BEGIN
    IF NEW.forma_pagamento NOT IN ('DINHEIRO', 'CARTAO', 'PIX', 'DEBITO') 
		THEN SET MESSAGE_TEXT = 'Forma de pagamento inválida.';
    END IF;
END$$

DELIMITER ;

INSERT INTO Pagamento (valor, data_pagamento, forma_pagamento, id_pedido) VALUES
(59.50, '2026-01-15 22:12:00', 'MOEDA DE 5 CENTAVOS', 1);

-- Sem implementações extras