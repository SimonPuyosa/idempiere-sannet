-- init.sql

-- Crea el usuario adempiere con la contraseña adempiere
CREATE USER adempiere WITH CREATEDB CREATEROLE PASSWORD 'adempiere';

-- Crea la base de datos idempiere y asigna el propietario al usuario adempiere
CREATE DATABASE idempiere WITH OWNER adempiere;
