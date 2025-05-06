create or replace procedure sp_cadastrar_cliente
(in p_nome varchar(200), in p_cod_cliente int default null)
language PLPGSQL
as $$
BEGIN
    if p_cod_cliente is NULL THEN
        insert into tb_cliente (nome) values (p_nome);
    ELSE
        insert into tb_cliente (cod_cliente, nome) values (p_cod_cliente, p_nome);
    end if;
end;
$$


create table tb_item_pedido(
    cod_item_pedido serial primary KEY,
    cod_item int not null,
    cod_pedido int not null,
    constraint fk_item FOREIGN KEY (cod_item) REFERENCES tb_item(cod_item),
    constraint fk_pedido FOREIGN KEY (cod_pedido) REFERENCES tb_pedido(cod_pedido)
)


insert into tb_item
(descricao, valor, cod_tipo)
VALUES
('Refrigerante', 7, 1),
('Suco', 8, 1),
('Hamburger', 12, 2),
('Batata frita', 9, 2);



create table tb_item(
    cod_item serial primary key,
    descricao varchar(200) not null,
    valor numeric (10, 2) not null,
    cod_tipo int not null,
    constraint fk_tipo_item FOREIGN KEY (cod_tipo)
    REFERENCES tb_tipo_item(cod_tipo)
);


insert into tb_tipo_item
(descricao) values ('Bebida'), ('Comida')

create table tb_tipo_item(
    cod_tipo serial primary key,
    descricao varchar(200) not null
);

create table tb_pedido(
    cod_pedido serial primary KEY,
    data_criacao TIMESTAMP default current_TIMESTAMP,
    data_modificacao TIMESTAMP DEFAULT current_timestamp,
    status varchar(100) default 'aberto',
    cod_cliente int not null,
    constraint fk_cliente FOREIGN key (cod_cliente)
    references tb_cliente(cod_cliente)
) 

-- create table tb_cliente(
--     cod_cliente serial primary key,
--     nome varchar(200) not NULL
-- );


call sp_calcula_media(1);

create or replace procedure sp_calcula_media
(variadic p_valores int[])
language plpgsql
as $$
DECLARE
    v_media numeric(10,2):= 0;
    v_valor int;
BEGIN
    LOOP
        foreach v_valor in array p_valores LOOP
            v_media := v_media + v_valor;
    end loop;
    raise notice 'A média é %', v_media / array_length(p_valores,1); --1 é o slice
end;
$$

--colocando em execução (chamando ou invocando, jamais puxando)
do $$
DECLARE
    v_valor1 int := 2;
    v_valor2 int := 3;
BEGIN
    call sp_acha_maior(v_valor1, v_valor2);
    raise notice '% é o maior', v_valor1;
end;
$$

drop procedure if exists sp_acha_maior;

create or replace procedure sp_acha_maior
(inout p_valor1 int, in p_valor2 int)
language plpgsql
as $$
begin 
    if p_valor2 > p_valor1 THEN
        p_valor1 := p_valor2;
    end if;
end;
$$



do $$
DECLARE
    v_resultado INT;
begin
    call sp_acha_maior(v_resultado,5, 6);
    raise notice '% é o maior', v_resultado;
end;
$$

drop procedure if exists sp_acha_maior;
create or replace procedure sp_acha_maior(out p_resultado int, in p_valor1 int, in p_valor2 int)
language plpgsql
as $$
BEGIN
    CASE 
        WHEN p_valor1 > p_valor2 THEN
            p_resultado := p_valor1;  
        ELSE 
            $1 := p_valor2; 
    END CASE;
end;
$$




call sp_acha_maior(2,5);

create or replace procedure sp_acha_maior(in p_valor1 int, p_valor2 int)
language plpgsql 
as $$
BEGIN
    if p_valor1 > p_valor2 THEN
        raise notice '% é o maior', $1;
    ELSE
        raise notice '% é o maior', $2;
    end if;
END;
$$

-- CALL sp_ola_usuario('Pedro', 'Ricardo');

-- create or replace procedure sp_ola_usuario(p_nome varchar(200),p_nome2 varchar(100))
-- language plpgsql
-- as $$
-- BEGIN
--     --acessar o parametro pelo nome dele
--     raise notice 'Olá, % e %', p_nome, p_nome2 ;
--     -- acessar o parametro pelo seu numero indicador, começando pelo 1
--     raise notice 'Olá, % e %', $1, $2;
-- end;
-- $$


-- CALL sp_ola_procedures();

-- CREATE OR REPLACE PROCEDURE sp_ola_procedures()
-- LANGUAGE plpgsql    
-- AS $$
-- BEGIN
--     RAISE NOTICE 'Ola, procedures';
-- END;
-- $$


