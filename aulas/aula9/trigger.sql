CREATE OR REPLACE TRIGGER seguranca_cliente
BEFORE INSERT OR DELETE OR UPDATE ON cliente
BEGIN
if (to_char(sysdate,'DY') in ('SÁB','DOM')) 
 or (to_number(to_char(sysdate,'HH24')) not between 8 and 18) then
 if DELETING then
    raise_application_error(-20001,'Você só pode deletar no horário comercial');
 elsif INSERTING then
    raise_application_error(-20001,'Você só pode inserir no horário comercial');
 elsif UPDATING ('endereco') THEN
    raise_application_error(-20001,'Você só pode alterar o endereco no horário comercial');
 else
 raise_application_error(-20001,'Você só pode alterar no horário comercial');
 end if;
end if;
end;