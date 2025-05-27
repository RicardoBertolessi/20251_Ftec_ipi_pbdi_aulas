-- Active: 1742297457591@@127.0.0.1@5432@20251_fatec_ipi_pbdi_Ricardo
CREATE TABLE tb_teste_trigger(
cod_teste_trigger SERIAL PRIMARY KEY,
texto VARCHAR(200)
);


create or replace function fn_antes_de_um_insert()
returns TRIGGER
language plpgsql
as $$
begin
    raise notice 'Trigger foi chamado antes do insert';
    return null;
end;
$$


create or replace trigger tg_antes_do_insert
before insert on tb_teste_trigger
for each statement
execute function fn_antes_de_um_insert();

insert into tb_teste_trigger(texto)
values('testando trigger');

select * from tb_teste_trigger;

create or replace function fn_depois_de_um_insert()
returns TRIGGER
language plpgsql
as $$
BEGIN
    raise notice 'trigger foi chamado depois do insert';
    return null;
end;
$$


create or replace trigger tg_depois_de_insert
after insert on tb_teste_trigger
for each statement
execute function fn_depois_de_um_insert();

insert into tb_teste_trigger(texto) values('testando trigger 5');


create or replace trigger tg_depois_de_insert2
after insert on tb_teste_trigger
for each statement
execute function fn_depois_de_um_insert();

create or replace trigger tg_antes_de_insert2
before insert on tb_teste_trigger
for each statement
execute function fn_antes_de_um_insert();

delete from tb_teste_trigger;


select * from tb_teste_trigger_cod_teste_trigger_seq;

alter sequence tb_teste_trigger_cod_teste_trigger_seq
restart with 1; 



drop trigger if exists tg_depois_de_insert2
on tb_teste_trigger;

drop trigger if exists tg_antes_de_insert2
on tb_teste_trigger;

create or replace trigger tg_antes_do_insert
before insert or update on tb_teste_trigger
for each statement
execute function fn_antes_de_um_insert('Antes: V1', 'Antes: V2');


create or replace trigger tg_depois_de_insert
after insert or update on tb_teste_trigger
for each statement
execute function fn_depois_de_um_insert('Depois: V1', 'Depois: V2', 'Depois: V3');


create or replace function fn_antes_de_um_insert()
returns TRIGGER
language plpgsql
as $$
begin
    raise notice 'Estamos no trigger BEFORE';
    raise notice 'OLD %', OLD;
    raise notice 'NEW %', NEW;
    raise notice 'OLD.TEXTO: %', old.texto;
    raise notice 'NEW.TEXTO: %', new.texto;
    raise notice 'TG_NAME: %', TG_NAME;
    raise notice 'TG_LEVEL: %', TG_LEVEL;
    raise notice 'TG_WHEN: %', TG_WHEN;
    raise notice 'TG_TABLE_NAME: %', TG_TABLE_NAME;
    for i in 0..TG_NARGS -1 LOOP
        raise notice '%', TG_ARGV[i];
    end loop;
    return new;
end;
$$




create or replace function fn_depois_de_um_insert()
returns TRIGGER
language plpgsql
as $$
BEGIN
    raise notice 'Etamos no trigger AFTER';
    raise notice 'OLD %', OLD;
    raise notice 'NEW %', NEW;
    raise notice 'OLD.TEXTO: %', old.texto;
    raise notice 'NEW.TEXTO: %', new.texto;
    raise notice 'TG_NAME: %', TG_NAME;
    raise notice 'TG_LEVEL: %', TG_LEVEL;
    raise notice 'TG_WHEN: %', TG_WHEN;
    raise notice 'TG_TABLE_NAME: %', TG_TABLE_NAME;
    for i in 0..TG_NARGS -1 LOOP
        raise notice '%', TG_ARGV[i];
    end loop;
    return new;
end;
$$


insert into tb_teste_trigger(texto) values('oi')