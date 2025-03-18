DO $$
DECLARE
    n1 NUMERIC (5,2);
    n2 INT;
    limite_inferior INT := 5;
    limite_superior INT :=17;
BEGIN
    n1 := random();
    RAISE NOTICE 'n1: %', n1;

    n1 := 1 + random() * 9;
    RAISE NOTICE 'n1: %', n1;

    n2 := floor(random()* 10 + 1)::INT;
    RAISE NOTICE 'n2: %', n2;
z
    n2 := floor(random()* (17 - 5 + 1) + 5)::INT;
    RAISE NOTICE 'n2: %', n2;   
END;
$$




-- DO
-- $$
-- DECLARE
--     v_codigo INTEGER := 1;
--     v_nome_completo VARCHAR(200) := 'JOÃO';
--     v_salario NUMERIC (11, 2):= 20.5;
-- BEGIN
--     RAISE NOTICE 'Meu codigo é %, me chamo % e meu salário é %.',
--     v_codigo, v_nome_completo, v_salario;
-- END;
-- $$
-- DO
-- $$
-- BEGIN
--     RAISE NOTICE '% + % = %', 2, 2, 2 + 2;
-- END;
-- $$

--DO
--$$
--BEGIN
--    RAISE NOTICE 'Meu primeiro bloquinho anonimo';
--END;
--$$

-- CREATE DATABASE "20251_fatec_ipi_pbdi_Ricardo2";
