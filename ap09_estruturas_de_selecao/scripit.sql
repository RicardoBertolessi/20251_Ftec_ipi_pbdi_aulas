--ddmmaaaa
DO $$
DECLARE
    --testar
    --22/10/2022: valida
    --29/02/2020: valida
    --29/02/2021: invalida
    --28/02/2021: valida
    --31/09/2025: invalida
    --31/06/2025: invalida
    DATA INT := 18501994;
    dia INT;
    mes INT;
    ano INT;
    data_valida BOOL := TRUE;
BEGIN
    dia := data / 1000000;
    mes := data % 1000000 / 100000;
    ano := data % 10000;
    RAISE NOTICE '%/%/%', dia, mes, ano;
    RAISE NOTICE 'Vejamos se ela é valida...';
    IF ano >= 1 THEN
        CASE
            WHEN mes > 12 OR mes < 1 OR dia < 1 OR dia > 31 THEN
                data_valida := FALSE;
            ELSE
                IF (mes = 4 OR mes = 6 OR mes = 9 OR mes = 11) AND dia > 30 THEN
                    data_valida := FALSE; 

                ELSE
                    IF mes = 2 THEN
                        CASE
                            WHEN (ano % 4 = 0 AND ano % 100 <> 0) OR ano % 400 = 0 THEN
                                IF dia > 29 THEN
                                    data_valida := FALSE;
                                END IF;                                
                            ELSE
                                IF dia > 28 THEN
                                    data_valida := FALSE;
                                END IF;
                        END CASE;
                    END IF;
                END IF;
        END CASE;
    ELSE
        data_valida := FALSE;
    END IF;
    CASE
        WHEN data_valida THEN
            RAISE NOTICE 'data valida';
        ELSE
            RAISE NOTICE 'data invalida';
    END CASE;
END;
$$


-- DO $$
-- DECLARE
--     valor INT := valor_aleatorio_entre(1,12);
--     mensagem VARCHAR(200);
-- BEGIN
--     RAISE NOTICE 'O valor da vez é %', valor;
--     CASE valor
--         WHEN 1,3,5,7,9 THEN
--             mensagem := 'Impar';
--         WHEN 2,4,6,8,10 THEN
--             mensagem := 'Par';
--         ELSE
--             mensagem := 'Fora do intervalo';
--     END CASE;
--     RAISE NOTICE '%', mensagem;
-- END;
-- $$

-- DO $$
-- DECLARE
--     a INT := valor_aleatorio_entre(0, 20);
--     b INT := valor_aleatorio_entre(0, 20);
--     c INT := valor_aleatorio_entre(0, 20);
--     delta NUMERIC(10, 2);
--     raizum NUMERIC(10, 2);
--     raizdois NUMERIC(10, 2);
--     -- ax^2 + bx + c = 0 
-- BEGIN
--     RAISE NOTICE '%x% + %x + % = 0', a, U&'\00B2', b, c;
--     IF a = 0 THEN
--         RAISE NOTICE 'Não é equação do segundo grau';   
--     ELSE    
--         delta := b ^ 2 - 4 * a * c;
--         RAISE NOTICE 'Delta: %', delta;
--         IF delta < 0 THEN
--             RAISE NOTICE 'Não teve muita graça, não tem raiz';
--         ELSE IF delta = 0 THEN
--             raizum := -1 * b / (2 * a);
--             RAISE NOTICE 'Teve uma raiz. Essa aqui: %', raizum;
--         ELSE
--             raizum := (-b + |/delta) / (2*a);
--             raizdois := (-b - |/delta) / (2*a);
--             RAISE NOTICE 'Duas raizes. Observe: % e %', raizum, raizdois;
--         END IF;
--     END IF;
-- END;
-- $$



-- DO $$
-- DECLARE
--     v_valor INT;
-- BEGIN
--     v_valor := valor_aleatorio_entre(1,30);
--     IF v_valor <- 20 THEN
--         RAISE NOTICE 'A Metade de % é %', v_valor, v_valor / 2::FLOAT;
--     END IF;
-- END;
-- $$


-- CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
-- INT) RETURNS INT AS
-- $$
-- BEGIN
-- RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
-- END;
-- $$ LANGUAGE plpgsql;