--1.1
ALTER TABLE tb_pessoa ADD COLUMN ativo BOOLEAN NOT NULL DEFAULT TRUE;

--1.2
CREATE OR REPLACE FUNCTION fn_delete_tb_pessoa()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
   
    UPDATE tb_pessoa
       SET ativo = FALSE
     WHERE cod_pessoa = OLD.cod_pessoa;
	 RETURN NULL;          
END;
$$;

CREATE TRIGGER tg_delete_tb_pessoa
BEFORE DELETE ON tb_pessoa
FOR EACH ROW
EXECUTE PROCEDURE fn_delete_tb_pessoa();

--Teste do Trigger
DELETE FROM tb_pessoa WHERE cod_pessoa = 1;

SELECT * FROM tb_pessoa WHERE cod_pessoa = 1;