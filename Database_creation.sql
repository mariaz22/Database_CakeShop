
CREATE SEQUENCE COFETARII_SEQ START WITH 1;
CREATE SEQUENCE PRODUSE_SEQ START WITH 1;
CREATE SEQUENCE CLIENT_SEQ START WITH 1;
CREATE SEQUENCE FURNIZOR_SEQ START WITH 1;
CREATE SEQUENCE ANGAJATI_SEQ START WITH 1;
CREATE SEQUENCE EVENIMENTE_SEQ START WITH 1;
CREATE SEQUENCE COMENZI_SEQ START WITH 1;
CREATE SEQUENCE INGREDIENTE_SEQ START WITH 1;
CREATE SEQUENCE RETETA_SEQ START WITH 1;
CREATE SEQUENCE INFORMATII_NUTRITIONALE_SEQ START WITH 1;
CREATE SEQUENCE USTENSILE_SEQ START WITH 1;
CREATE SEQUENCE FINANTE_CONTABILITATE_SEQ START WITH 1;
CREATE SEQUENCE VANZARI_SEQ START WITH 1;
CREATE SEQUENCE FIRMA_LIVRARE_SEQ START WITH 1;
CREATE SEQUENCE PROMOTII_SEQ START WITH 1;
CREATE SEQUENCE DETALII_VANZARE_SEQ START WITH 1;
CREATE SEQUENCE INCLUDE_SEQ START WITH 1;
CREATE SEQUENCE DETALII_COMPOZITIE_SEQ START WITH 1;
CREATE SEQUENCE DETALII_USTENSILE_SEQ START WITH 1;



CREATE TABLE COFETARII (
    id_cofetarie INT PRIMARY KEY,
    numar_de_telefon INT,
    adresa_mail VARCHAR2(100)
);

INSERT INTO COFETARII (id_cofetarie, numar_de_telefon, adresa_mail)
VALUES (101, 0712345678, 'cofetarie1@yahoo.com');

INSERT INTO COFETARII (id_cofetarie, numar_de_telefon, adresa_mail)
VALUES (102, 0712345679, 'cofetarie2@yahoo.com');

INSERT INTO COFETARII (id_cofetarie, numar_de_telefon, adresa_mail)
VALUES (103, 0712345680, 'cofetarie3@yahoo.com');

INSERT INTO COFETARII (id_cofetarie, numar_de_telefon, adresa_mail)
VALUES (104, 0712345681, 'cofetarie4@yahoo.com');

INSERT INTO COFETARII (id_cofetarie, numar_de_telefon, adresa_mail)
VALUES (105, 0712345682, 'cofetarie5@yahoo.com');

INSERT INTO COFETARII (id_cofetarie, numar_de_telefon, adresa_mail)
VALUES (106, 0712345683, 'cofetarie6@yahoo.com');

SELECT *
FROM COFETARII;


CREATE TABLE PRODUSE (
    id_produs INT DEFAULT PRODUSE_SEQ.NEXTVAL PRIMARY KEY,
    pret INT,
    nume VARCHAR2(150),
    data_expirare DATE,
    disponibilitate VARCHAR2(2) CHECK (disponibilitate IN ('DA', 'NU')),
    categorie VARCHAR2(10) CHECK (categorie IN ('tort', 'prajitura', 'fursec', 'tarta'))
);

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (50, 'Tort de ciocolata', TO_DATE('25-12-2024', 'DD-MM-YYYY'), 'DA', 'tort');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (30, 'Prajitura cu vanilie', TO_DATE('15-01-2025', 'DD-MM-YYYY'), 'DA', 'prajitura');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (20, 'Fursecuri cu unt', TO_DATE('10-11-2024', 'DD-MM-YYYY'), 'DA', 'fursec');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (25, 'Tarta cu fructe', TO_DATE('05-10-2024', 'DD-MM-YYYY'), 'DA', 'tarta');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (60, 'Tort Red Velvet', TO_DATE('20-11-2024', 'DD-MM-YYYY'), 'NU', 'tort');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (35, 'Prajitura cu ciocolata', TO_DATE('12-12-2024', 'DD-MM-YYYY'), 'DA', 'prajitura');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (15, 'Fursecuri cu ciocolata', TO_DATE('08-09-2024', 'DD-MM-YYYY'), 'NU', 'fursec');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (27, 'Tarta cu lamaie', TO_DATE('30-08-2024', 'DD-MM-YYYY'), 'DA', 'tarta');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (55, 'Tort cu fructe de padure', TO_DATE('18-07-2024', 'DD-MM-YYYY'), 'NU', 'tort');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (28, 'Prajitura de post', TO_DATE('22-06-2024', 'DD-MM-YYYY'), 'DA', 'prajitura');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (18, 'Fursecuri cu migdale', TO_DATE('14-05-2024', 'DD-MM-YYYY'), 'DA', 'fursec');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (26, 'Tarta cu ciocolata', TO_DATE('10-04-2024', 'DD-MM-YYYY'), 'NU', 'tarta');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (65, 'Tort de inghetata', TO_DATE('05-03-2024', 'DD-MM-YYYY'), 'DA', 'tort');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (34, 'Prajitura cu mere', TO_DATE('28-02-2024', 'DD-MM-YYYY'), 'DA', 'prajitura');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (22, 'Fursecuri cu stafide', TO_DATE('15-01-2025', 'DD-MM-YYYY'), 'DA', 'fursec');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (29, 'Tarta cu caramel', TO_DATE('10-12-2024', 'DD-MM-YYYY'), 'NU', 'tarta');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (25, 'Tort cu fructe', TO_DATE('25-06-2025', 'DD-MM-YYYY'), 'DA', 'tort');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (15, 'Prajitura Tiramisu', TO_DATE('20-08-2024', 'DD-MM-YYYY'), 'DA', 'prajitura');

INSERT INTO PRODUSE (pret, nume, data_expirare, disponibilitate, categorie)
VALUES (50, 'Tort Diplomat', TO_DATE('25-08-2024', 'DD-MM-YYYY'), 'DA', 'tort');

SELECT *
FROM PRODUSE;

CREATE TABLE CLIENT (
    id_client INT DEFAULT CLIENT_SEQ.NEXTVAL PRIMARY KEY,
    numar_de_telefon VARCHAR2(10),
    id_cofetarie INT,
    nume VARCHAR2(200),
    prenume VARCHAR2(200),
    adresa_mail VARCHAR2(100),
    data_nastere DATE,
    produs_preferat VARCHAR2(20),
    metoda_plata_preferata VARCHAR2(10),
    CONSTRAINT fk_cofetarie FOREIGN KEY (id_cofetarie) REFERENCES COFETARII(id_cofetarie)
);


INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0712345678', 101, 'Popescu', 'Ion', 'popescu.ion@yahoo.com', DATE '1990-01-01', 'tort', 'cash');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0723456789', 102, 'Ionescu', 'Maria', 'ionescu.maria@yahoo.com', DATE '1985-05-15', 'prajitura', 'card');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0734567890', 106, 'Radu', 'Ana', 'radu.ana@yahoo.com', DATE '1982-10-10', 'fursec', 'cash');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0745678901', 104, 'Dumitrescu', 'George', 'dumitrescu.george@yahoo.com', DATE '1988-03-20', 'tarta', 'card');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0756789012', 105, 'Constantinescu', 'Elena', 'constantinescu.elena@yahoo.com', DATE '1975-12-05', 'tort', 'cash');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0767890123', 106, 'Gheorghe', 'Mihai', 'gheorghe.mihai@yahoo.com', DATE '1983-09-18', 'prajitura', 'card');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0778901234', 102, 'Stefan', 'Andreea', 'stefan.andreea@yahoo.com', DATE '1992-06-30', 'fursec', 'cash');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0789012345', 103, 'Popa', 'Alexandru', 'popa.alexandru@yahoo.com', DATE '1979-04-25', 'tarta', 'card');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0790123456', 104, 'Florescu', 'Cristina', 'florescu.cristina@yahoo.com', DATE '1986-11-15', 'tort', 'cash');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0711234567', 105, 'Stan', 'Laura', 'stan.laura@yahoo.com', DATE '1980-08-12', 'prajitura', 'card');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0722345678', 101, 'Balan', 'Daniel', 'balan.daniel@yahoo.com', DATE '1984-03-28', 'fursec', 'cash');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0733456789', 102, 'Vasilescu', 'Ana Maria', 'vasilescu.anamaria@yahoo.com', DATE '1995-10-03', 'tarta', 'card');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0744567890', 103, 'Dumitrache', 'Ionut', 'dumitrache.ionut@yahoo.com', DATE '1987-07-17', 'tort', 'cash');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0755678901', 104, 'Georgescu', 'Catalin', 'georgescu.catalin@yahoo.com', DATE '1981-02-09', 'prajitura', 'card');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0766789012', 105, 'Dragomir', 'Andrei', 'dragomir.andrei@yahoo.com', DATE '1990-11-22', 'fursec', 'cash');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0788901234', 102, 'Popescu', 'Mihai', 'popescu.mihai@yahoo.com', DATE '1978-09-27', 'prajitura', 'cash');

INSERT INTO CLIENT (numar_de_telefon, id_cofetarie, nume, prenume, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
VALUES ('0766789012', 103, 'Dumitrescu', 'Ana', 'dumitrescu.ana@yahoo.com', DATE '1990-12-03', 'tarta', 'card');

SELECT *
FROM CLIENT;



CREATE TABLE FURNIZOR (
    id_furnizor INT DEFAULT FURNIZOR_SEQ.NEXTVAL PRIMARY KEY,
    nume VARCHAR2(200),
    id_cofetarie INT,
    adresa VARCHAR2(300),
    adresa_mail VARCHAR2(150),
    produse_furnizate VARCHAR2(20) CHECK (produse_furnizate IN ('ingrediente', 'ustensile', 'ambele'))
);


INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Furnizorul Delicios', 101, 'Str. Florilor, Nr. 10, Bucuresti', 'delicios@gmail.com', 'ingrediente');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Compania Bunatatilor SRL', 106, 'Bd. Libertatii, Nr. 25, Cluj-Napoca', 'bunatati@yahoo.com', 'ustensile');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Ingrediente Fine SRL', 103, 'Calea Victoriei, Nr. 15, Timisoara', 'ingrediente_fine@yahoo.com', 'ingrediente');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Furnizorul de Top SRL', 104, 'Bd. Unirii, Nr. 30, Iasi', 'top_furnizor@gmail.com', 'ustensile');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Ingrediente Naturale', 105, 'Str. Libertatii, Nr. 5, Brasov', 'naturale@yahoo.com', 'ingrediente');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Furnizorul Profesional', 101, 'Bd. Republicii, Nr. 20, Constanta', 'profesional@gmail.com', 'ambele');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Materiale de Înalt? Calitate', 102, 'Calea Doroban?ilor, Nr. 18, Oradea', 'calitate@gmail.com', 'ustensile');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Furnizorul de Bucatarie', 106, 'Str. Mihai Viteazu, Nr. 8, Gala?i', 'bucatarie@yahoo.com', 'ustensile');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Produse Profesioniste', 104, 'Bd. Dacia, Nr. 12, Bacau', 'profesionale@gmail.com', 'ingrediente');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Furnizorul Artistic', 105, 'Str. Avram Iancu, Nr. 17, Sibiu', 'artistic@yahoo.com', 'ustensile');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Ingrediente de Calitate', 101, 'Bd. Traian, Nr. 14, Ploiesti', 'calitate@yahoo.com', 'ingrediente');

INSERT INTO FURNIZOR (nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
VALUES ('Furnizorul de Incredere', 102, 'Str. Victoriei, Nr. 22, Buzau', 'incredere@gmail.com', 'ambele');

SELECT *
FROM FURNIZOR

CREATE TABLE ANGAJATI (
    id_angajat INT DEFAULT ANGAJATI_SEQ.NEXTVAL PRIMARY KEY,
    id_cofetarie INT,
    tip_angajat VARCHAR2(20),
    nume VARCHAR2(200),
    prenume VARCHAR2(200),
    numar_de_telefon VARCHAR2(10),
    salariu INT,
    numar_ore_lucru_zi INT,
    data_angajarii DATE,
    FOREIGN KEY (id_cofetarie) REFERENCES COFETARII(id_cofetarie)
);

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (101, 'cofetar', 'Popescu', 'Ion', '0712345678', 2500, 8, TO_DATE('01-01-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (102, 'contabil', 'Ionescu', 'Ana', '0723456789', 3500, 8, TO_DATE('15-02-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (103, 'manager', 'Popa', 'Mihai', '0734567890', 4000, 8, TO_DATE('10-03-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (104, 'vanzator', 'Georgescu', 'Maria', '0745678901', 2000, 8, TO_DATE('20-04-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (106, 'cofetar', 'Dumitrescu', 'Elena', '0756789012', 2700, 8, TO_DATE('05-05-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (101, 'contabil', 'Radu', 'Andrei', '0767890123', 3800, 8, TO_DATE('15-06-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (106, 'manager', 'Stoica', 'Cristina', '0778901234', 4200, 8, TO_DATE('20-07-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (103, 'vanzator', 'Constantinescu', 'Alex', '0789012345', 2200, 8, TO_DATE('01-08-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (104, 'cofetar', 'Popovici', 'Ana-Maria', '0790123456', 2600, 8, TO_DATE('10-09-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (105, 'contabil', 'Ivan', 'Vlad', '0701234567', 3600, 8, TO_DATE('15-10-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (106, 'manager', 'Muresan', 'Bianca', '0712345678', 4100, 8, TO_DATE('20-11-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (102, 'vanzator', 'Gheorghe', 'Doru', '0723456789', 2300, 8, TO_DATE('01-12-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (103, 'cofetar', 'Stanciu', 'Georgiana', '0734567890', 2800, 8, TO_DATE('05-01-2024', 'DD-MM-YYYY'));
---14
INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (103, 'cofetar', 'Popescu', 'Andreea', '0734567890', 3000, 8, TO_DATE('05-01-2024', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (105, 'manager', 'Moldovan', 'Andreea', '0756789012', 4300, 8, TO_DATE('15-03-2024', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (101, 'vanzator', 'Antonescu', 'Adrian', '0767890123', 2400, 8, TO_DATE('20-04-2024', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (102, 'cofetar', 'Vasilescu', 'Anca', '0789001234', 2700, 8, TO_DATE('01-05-2024', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (106, 'manager', 'Pop', 'Bogdan', '0752709072', 50000, 8, TO_DATE('20-04-2024', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (102, 'vanzator', 'Georgescu', 'Mihai', '0723956280', 2300, 8, TO_DATE('05-04-2022', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (105, 'contabil', 'Moraru', 'Andreea', '0705934538', 3300, 8, TO_DATE('20-10-2022', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (105, 'contabil', 'Popa', 'Elena', '0701624591', 4200, 8, TO_DATE('17-09-2023', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (102, 'cofetar', 'Radulescu', 'Horia', '0751616363', 5500, 4, TO_DATE('30-05-2024', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (103, 'cofetar', 'Alexandrescu', 'Carmen', '0751614073', 4000, 8, TO_DATE('15-05-2024', 'DD-MM-YYYY'));

INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (104, 'cofetar', 'Ionescu', 'Florentina', '0751568356', 3500, 4, TO_DATE('20-05-2024', 'DD-MM-YYYY'));


SELECT *
FROM ANGAJATI

CREATE TABLE MANAGER (
    id_angajat INT PRIMARY KEY,
    titlu_manager VARCHAR2(200),
    numar_angajati_supravegheati INT,
    FOREIGN KEY (id_angajat) REFERENCES ANGAJATI(id_angajat),
    CHECK (numar_angajati_supravegheati >= 0)
);

INSERT INTO MANAGER (id_angajat, titlu_manager, numar_angajati_supravegheati)
VALUES (3, 'Manager General', 10);

INSERT INTO MANAGER (id_angajat, titlu_manager, numar_angajati_supravegheati)
VALUES (7, 'Manager Vânz?ri', 5);

INSERT INTO MANAGER (id_angajat, titlu_manager, numar_angajati_supravegheati)
VALUES (11, 'Manager Opera?iuni', 8);

INSERT INTO MANAGER (id_angajat, titlu_manager, numar_angajati_supravegheati)
VALUES (15, 'Manager Financiar', 7);

INSERT INTO MANAGER (id_angajat, titlu_manager, numar_angajati_supravegheati)
VALUES (18, 'Manager Proiecte', 12);

SELECT *
FROM MANAGER
DROP TABLE MANAGER;

CREATE TABLE CONTABIL (
    id_angajat INT PRIMARY KEY,
    specializare VARCHAR2(100),
    titlu_contabil VARCHAR2(200),
    CONSTRAINT fk_contabil_angajat FOREIGN KEY (id_angajat) REFERENCES ANGAJATI(id_angajat)
);
INSERT INTO CONTABIL (id_angajat, specializare, titlu_contabil)
VALUES (6, 'Audit Financiar', 'Contabil Senior');

INSERT INTO CONTABIL (id_angajat, specializare, titlu_contabil)
VALUES (10, 'Contabilitate de Gestiune', 'Contabil Junior');

INSERT INTO CONTABIL (id_angajat, specializare, titlu_contabil)
VALUES (20, 'Contabilitate General?', 'Contabil ?ef');

INSERT INTO CONTABIL (id_angajat, specializare, titlu_contabil)
VALUES (21, 'Contabilitate de Costuri', 'Contabil');

INSERT INTO CONTABIL (id_angajat, specializare, titlu_contabil)
VALUES (2, 'Contabilitate Fiscal?', 'Contabil Expert');

SELECT *
FROM CONTABIL

CREATE TABLE COFETAR (
    id_angajat INT PRIMARY KEY,
    reteta_specialitate VARCHAR2(100),
    experienta_lucru INT CHECK (experienta_lucru > 0),
    CONSTRAINT fk_cofetar_angajat FOREIGN KEY (id_angajat) REFERENCES ANGAJATI(id_angajat)
);
INSERT INTO COFETAR (id_angajat, reteta_specialitate, experienta_lucru)
VALUES (1, 'Tort de Ciocolata', 5);

INSERT INTO COFETAR (id_angajat, reteta_specialitate, experienta_lucru)
VALUES (5, 'Tarta cu Fructe', 7);

INSERT INTO COFETAR (id_angajat, reteta_specialitate, experienta_lucru)
VALUES (9, 'Prajitura cu Vanilie', 3);

INSERT INTO COFETAR (id_angajat, reteta_specialitate, experienta_lucru)
VALUES (13, 'Fursecuri cu Unt', 6);

INSERT INTO COFETAR (id_angajat, reteta_specialitate, experienta_lucru)
VALUES (14, 'Fursecuri cu Unt', 5);

INSERT INTO COFETAR (id_angajat, reteta_specialitate, experienta_lucru)
VALUES (17, 'Tort Red Velvet', 8);

INSERT INTO COFETAR (id_angajat, reteta_specialitate, experienta_lucru)
VALUES (22, 'Tort de Ciocolata', NULL);

INSERT INTO COFETAR (id_angajat, reteta_specialitate, experienta_lucru)
VALUES (23, 'Fursecuri de ciocolata', NULL);

INSERT INTO COFETAR (id_angajat, reteta_specialitate, experienta_lucru)
VALUES (24, 'Tarta cu lamaie', NULL);


SELECT *
FROM COFETAR


CREATE TABLE VANZATOR (
    id_angajat INT PRIMARY KEY,
    cunoaste_limba_straina VARCHAR2(2) CHECK (cunoaste_limba_straina IN ('DA', 'NU')),
    vanzari_lunare INT CHECK (vanzari_lunare >= 0),
    CONSTRAINT fk_vanzator_angajat FOREIGN KEY (id_angajat) REFERENCES ANGAJATI(id_angajat)
);

INSERT INTO VANZATOR (id_angajat, cunoaste_limba_straina, vanzari_lunare)
VALUES (4, 'DA', 150);

INSERT INTO VANZATOR (id_angajat, cunoaste_limba_straina, vanzari_lunare)
VALUES (8, 'NU', 120);

INSERT INTO VANZATOR (id_angajat, cunoaste_limba_straina, vanzari_lunare)
VALUES (12, 'DA', 180);

INSERT INTO VANZATOR (id_angajat, cunoaste_limba_straina, vanzari_lunare)
VALUES (16, 'NU', 140);

INSERT INTO VANZATOR (id_angajat, cunoaste_limba_straina, vanzari_lunare)
VALUES (19, 'DA', 200);

SELECT *
FROM VANZATOR
DROP TABLE VANZATOR;

CREATE TABLE EVENIMENTE (
    id_eveniment  INT DEFAULT EVENIMENTE_SEQ.NEXTVAL PRIMARY KEY,
    tip_eveniment VARCHAR2(100),
    data_eveniment DATE,
    numar_telefon VARCHAR2(10) CHECK (length(numar_telefon) = 10),
    stare_eveniment VARCHAR2(20) CHECK (stare_eveniment IN ('planificat', 'in desfasurare', 'finalizat'))
);

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Nunta', TO_DATE('25-06-2024', 'DD-MM-YYYY'), '0712345678', 'planificat');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Aniversare', TO_DATE('15-07-2024', 'DD-MM-YYYY'), '0723456789', 'in desfasurare');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Botez', TO_DATE('05-08-2024', 'DD-MM-YYYY'), '0734567890', 'finalizat');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Nunta', TO_DATE('10-09-2024', 'DD-MM-YYYY'), '0745678901', 'planificat');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Aniversare', TO_DATE('25-10-2024', 'DD-MM-YYYY'), '0756789012', 'in desfasurare');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Botez', TO_DATE('15-11-2024', 'DD-MM-YYYY'), '0767890123', 'finalizat');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Nunta', TO_DATE('05-12-2024', 'DD-MM-YYYY'), '0778901234', 'planificat');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Aniversare', TO_DATE('15-01-2025', 'DD-MM-YYYY'), '0789012345', 'in desfasurare');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Botez', TO_DATE('25-02-2025', 'DD-MM-YYYY'), '0790123456', 'finalizat');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Nunta', TO_DATE('05-03-2025', 'DD-MM-YYYY'), '0701234567', 'planificat');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Aniversare', TO_DATE('15-04-2025', 'DD-MM-YYYY'), '0712345678', 'in desfasurare');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Botez', TO_DATE('25-05-2025', 'DD-MM-YYYY'), '0723456789', 'finalizat');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Nunta', TO_DATE('05-06-2025', 'DD-MM-YYYY'), '0734567890', 'planificat');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Aniversare', TO_DATE('15-07-2025', 'DD-MM-YYYY'), '0745678901', 'in desfasurare');

INSERT INTO EVENIMENTE (tip_eveniment, data_eveniment, numar_telefon, stare_eveniment) 
VALUES ('Botez', TO_DATE('25-08-2025', 'DD-MM-YYYY'), '0756789012', 'finalizat');


SELECT *
FROM EVENIMENTE


CREATE TABLE FIRMA_LIVRARE (
    id_firma_livrare INT DEFAULT FIRMA_LIVRARE_SEQ.NEXTVAL PRIMARY KEY,
    nume VARCHAR2(200),
    numar_telefon VARCHAR2(10),
    pret_livrare INT
);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Firma Livrare Rapida', '0712345678', 20);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Livrari Express', '0723456789', 25);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Firma Curierat', '0734567890', 18);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Rapid Curier', '0745678901', 22);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Firma Transport', '0756789012', 30);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Livrari de Top', '0767890123', 28);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Livrare Nationala', '0778901234', 26);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Curierat Rapid', '0789012345', 24);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Firma Expres', '0790123456', 21);

INSERT INTO FIRMA_LIVRARE (nume, numar_telefon, pret_livrare) VALUES
('Transport Express', '0701234567', 27);


SELECT *
FROM FIRMA_LIVRARE;




CREATE TABLE PROMOTII (
    id_promotie INT DEFAULT PROMOTII_SEQ.NEXTVAL PRIMARY KEY,
    id_produs INT,
    data_inceput DATE,
    data_sfarsit DATE,
    FOREIGN KEY (id_produs) REFERENCES PRODUSE(id_produs)
);

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES
(5, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(14, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES
(5, TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(9, TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES
(11, TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(9, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(1, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(15, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES
(12, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-28', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(19, TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES
(9, TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-30', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(7, TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-31', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(14, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(16, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(12, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-06-09', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(14, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-08-02', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(16, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-09-14', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(1, TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2025-02-14', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(2, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2025-03-14', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(3, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2025-02-23', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(4, TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2025-02-15', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(5, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2025-03-10', 'YYYY-MM-DD'));

INSERT INTO PROMOTII (id_produs, data_inceput, data_sfarsit) VALUES 
(6, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2025-03-10', 'YYYY-MM-DD'));

SELECT *
FROM PROMOTII;

CREATE TABLE INFORMATII_NUTRITIONALE (
    id_informatie_nutritionala INT DEFAULT INFORMATII_NUTRITIONALE_SEQ.NEXTVAL PRIMARY KEY,
    id_produs INT,
    valoare_calorica INT,
    cant_grasimi INT,
    cant_carbohidrati INT,
    FOREIGN KEY (id_produs) REFERENCES PRODUSE(id_produs)
);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(1, 350, 20, 45);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(2, 250, 15, 30);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(3, 150, 5, 20);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(4, 300, 10, 35);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(5, 400, 25, 50);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(6, 275, 18, 33);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(7, 200, 8, 25);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(8, 325, 12, 40);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(9, 450, 30, 55);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(10, 220, 10, 28);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(11, 175, 6, 22);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(12, 350, 20, 45);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES
(13, 375, 22, 48);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(14, 250, 14, 32);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(15, 275, 17, 34);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(16, 300, 19, 37);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(17, 320, 21, 40);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(18, 280, 16, 36);

INSERT INTO INFORMATII_NUTRITIONALE (id_produs, valoare_calorica, cant_grasimi, cant_carbohidrati) VALUES 
(19, 360, 24, 42);


SELECT *
FROM INFORMATII_NUTRITIONALE;


CREATE TABLE FINANTE_CONTABILITATE (
    id_finante INT DEFAULT FINANTE_CONTABILITATE_SEQ.NEXTVAL PRIMARY KEY,
    id_angajat INT,
    tip_cheltuiala VARCHAR2(150),
    suma DECIMAL(10,2),
    data_efectuarii DATE,
    FOREIGN KEY (id_angajat) REFERENCES ANGAJATI(id_angajat)
);

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(6, 'Achizitie echipamente', 1500.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(20, 'Plata salarii', 5000.00, TO_DATE('2023-02-01', 'YYYY-MM-DD'));

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(21, 'Achizitie materii prime', 2000.00, TO_DATE('2023-02-20', 'YYYY-MM-DD'));

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(2, 'Plata utilitati', 800.00, TO_DATE('2023-03-05', 'YYYY-MM-DD'));

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(10, 'Reparatii echipamente', 1200.00, TO_DATE('2023-03-18', 'YYYY-MM-DD'));

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(21, 'Marketing si publicitate', 3000.00, TO_DATE('2023-04-01', 'YYYY-MM-DD'));

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(6, 'Plata chirie', 2500.00, TO_DATE('2023-04-15', 'YYYY-MM-DD'));

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(2, 'Achizitie software contabilitate', 500.00, TO_DATE('2023-05-01', 'YYYY-MM-DD'));

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(10, 'Training angajati', 1500.00, TO_DATE('2023-05-20', 'YYYY-MM-DD'));

INSERT INTO FINANTE_CONTABILITATE (id_angajat, tip_cheltuiala, suma, data_efectuarii) VALUES 
(21, 'Taxe si impozite', 4000.00, TO_DATE('2023-06-01', 'YYYY-MM-DD'));

SELECT *
FROM FINANTE_CONTABILITATE;


CREATE TABLE VANZARI (
    id_vanzari INT DEFAULT VANZARI_SEQ.NEXTVAL PRIMARY KEY,
    id_angajat INT,
    data_plata DATE,
    tip_produs_vandut VARCHAR2(20),
    metoda_plata_client VARCHAR2(10),
    suma NUMBER(10, 2),
    FOREIGN KEY (id_angajat) REFERENCES ANGAJATI(id_angajat),
    CHECK (metoda_plata_client IN ('cash', 'card'))
);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(4, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'tort', 'cash', 150.50);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(8, TO_DATE('2023-02-20', 'YYYY-MM-DD'), 'prajitura', 'card', 30.75);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(12, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 'fursec', 'cash', 20.00);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(16, TO_DATE('2023-04-05', 'YYYY-MM-DD'), 'tarta', 'card', 45.60);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(19, TO_DATE('2023-05-18', 'YYYY-MM-DD'), 'tort', 'cash', 175.90);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(4, TO_DATE('2023-06-25', 'YYYY-MM-DD'), 'prajitura', 'card', 25.50);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(16, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 'fursec', 'cash', 18.25);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(16, TO_DATE('2024-04-30', 'YYYY-MM-DD'), 'tort', 'cash', 160.00);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(16, TO_DATE('2024-03-30', 'YYYY-MM-DD'), 'tort', 'cash', 155.75);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(4, TO_DATE('2024-10-30', 'YYYY-MM-DD'), 'prajitura', 'card', 80);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(19, TO_DATE('2024-12-10', 'YYYY-MM-DD'), 'fursec', 'cash', 130);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(8, TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'tort', 'card', 240);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(8, TO_DATE('2025-01-02', 'YYYY-MM-DD'), 'fursec', 'card', 100);

INSERT INTO VANZARI (id_angajat, data_plata, tip_produs_vandut, metoda_plata_client, suma) VALUES 
(19, TO_DATE('2025-01-03', 'YYYY-MM-DD'), 'prajitura', 'cash', 125);


SELECT *
FROM VANZARI;



CREATE TABLE RETETA (
    id_reteta INT DEFAULT RETETA_SEQ.NEXTVAL PRIMARY KEY,
    id_angajat INT,
    id_produs INT,
    nume VARCHAR2(200),
    timp_preparare INT,
    dificultate VARCHAR2(10),
    FOREIGN KEY (id_angajat) REFERENCES ANGAJATI(id_angajat),
    FOREIGN KEY (id_produs) REFERENCES PRODUSE(id_produs),
    CHECK (dificultate IN ('usor', 'mediu', 'dificil'))
);

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (1, 1, 'Tort de ciocolata', 120, 'dificil');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (5, 2, 'Prajitura cu vanilie', 60, 'mediu');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (9, 3, 'Fursecuri cu unt', 45, 'usor');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (13, 4, 'Tarta cu fructe', 90, 'mediu');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (1, 5, 'Tort Red Velvet', 150, 'dificil');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (1, 6, 'Prajitura cu ciocolata', 75, 'mediu');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (17, 7, 'Fursecuri cu ciocolata', 60, 'usor');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (9, 8, 'Tarta cu lamaie', 90, 'mediu');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (1, 9, 'Tort cu fructe de padure', 120, 'dificil');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (13, 10, 'Prajitura de post', 45, 'usor');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (17, 11, 'Fursecuri cu migdale', 60, 'usor');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (5, 12, 'Tarta cu ciocolata', 90, 'mediu');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (5, 13, 'Tort de inghetata', 180, 'dificil');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (1, 14, 'Prajitura cu mere', 70, 'mediu');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (17, 15, 'Fursecuri cu stafide', 50, 'usor');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (13, 16, 'Tarta cu caramel', 100, 'mediu');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (5, 17, 'Tort cu fructe', 150, 'dificil');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (9, 18, 'Prajitura Tiramisu', 60, 'mediu');

INSERT INTO RETETA (id_angajat, id_produs, nume, timp_preparare, dificultate) 
VALUES (13, 19, 'Tort Diplomat', 120, 'mediu');


SELECT *
FROM RETETA;

CREATE TABLE INGREDIENTE (
    id_ingredient INT DEFAULT INGREDIENTE_SEQ.NEXTVAL PRIMARY KEY,
    nume VARCHAR2(200),
    cantitate_disponibila INT,
    data_expirare DATE,
    pret DECIMAL(10,2)
);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Faina', 100, TO_DATE('31-12-2024', 'DD-MM-YYYY'), 5.99);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Zahar', 200, TO_DATE('15-10-2024', 'DD-MM-YYYY'), 3.49);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Unt', 150, TO_DATE('28-02-2025', 'DD-MM-YYYY'), 7.25);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Oua', 80, TO_DATE('10-08-2024', 'DD-MM-YYYY'), 2.75);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Ciocolata', 120, TO_DATE('20-11-2024', 'DD-MM-YYYY'), 4.50);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Vanilie', 90, TO_DATE('05-06-2024', 'DD-MM-YYYY'), 6.99);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Lapte', 180, TO_DATE('15-09-2024', 'DD-MM-YYYY'), 3.20);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Cacao', 150, TO_DATE('10-07-2024', 'DD-MM-YYYY'), 8.75);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Scortisoara', 100, TO_DATE('25-09-2024', 'DD-MM-YYYY'), 6.00);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Frisca', 120, TO_DATE('15-08-2024', 'DD-MM-YYYY'), 5.25);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Capsuni', 120, TO_DATE('15-08-2023', 'DD-MM-YYYY'), 5.20);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Caramel', 120, TO_DATE('15-08-2022', 'DD-MM-YYYY'), 4.25);

INSERT INTO INGREDIENTE (nume, cantitate_disponibila, data_expirare, pret) 
VALUES ('Crema', 120, TO_DATE('15-08-2023', 'DD-MM-YYYY'), 5.25);

SELECT *
FROM INGREDIENTE;


CREATE TABLE DETALII_COMPOZITIE (
    id_ingredient INT,
    id_produs INT,
    cantitate_necesara NUMBER(10, 2) NOT NULL,
    PRIMARY KEY (id_ingredient, id_produs),
    FOREIGN KEY (id_ingredient) REFERENCES INGREDIENTE(id_ingredient),
    FOREIGN KEY (id_produs) REFERENCES PRODUSE(id_produs)
);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(1, 1, 30);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(2, 1, 50);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(3, 2, 70);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(4, 2, 250);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(5, 3, 300);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(7, 4, 100);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(8, 4, 200);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(9, 5, 150);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(10, 5, 250);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(1, 2, 300);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(2, 3, 200);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(3, 4, 150);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(4, 5, 250);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES 
(5, 1, 100);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(7, 3, 150);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(8, 10, 50);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(8, 11, 100);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(4, 15, 150);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(2, 17, 200);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(5, 12, 100);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(5, 17, 150);

INSERT INTO DETALII_COMPOZITIE (id_ingredient, id_produs, cantitate_necesara) VALUES
(2, 19, 200);


SELECT *
FROM DETALII_COMPOZITIE;



SELECT *
FROM INCLUDE

DROP TABLE INCLUDE;

CREATE TABLE DETALII_VANZARE (
    id_cofetarie INT,
    id_produs INT,
    cantitate INT,
    FOREIGN KEY (id_cofetarie) REFERENCES COFETARII(id_cofetarie),
    FOREIGN KEY (id_produs) REFERENCES PRODUSE(id_produs),
    PRIMARY KEY (id_cofetarie, id_produs)
);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(101, 5, 4);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(102, 7, 7);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(103, 9, 9);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES
(101, 10, 6);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(104, 11, 5);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(102, 13, 10);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(103, 9, 3);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(104, 2, 13);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(101, 16, 8);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(102, 17, 12);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(103, 9, 4);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(104, 14, 8);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(104, 10, 18);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(105, 8, 2);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES
(106, 3, 7);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(104, 4, 12);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(102, 8, 6);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(103, 6, 12);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(106, 18, 10);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(106, 12, 8);

INSERT INTO DETALII_VANZARE (id_cofetarie, id_produs, cantitate) VALUES 
(105, 14, 3);

SELECT *
FROM DETALII_VANZARE;


CREATE TABLE USTENSILE (
    id_ustensila INT DEFAULT USTENSILE_SEQ.NEXTVAL PRIMARY KEY,
    nume_ustensila VARCHAR2(150),
    data_achizitiei DATE,
    data_expirarii_garantiei DATE
);

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES 
('Mas? de lucru pentru patiserie', TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES 
('Ma?in? de g?tit cuptor', TO_DATE('2022-05-20', 'YYYY-MM-DD'), TO_DATE('2024-05-20', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES 
('Frigider pentru depozitarea ingredientelor', TO_DATE('2021-11-10', 'YYYY-MM-DD'), TO_DATE('2023-11-10', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES 
('Mixeri pentru prepararea aluaturilor', TO_DATE('2024-02-28', 'YYYY-MM-DD'), TO_DATE('2026-02-28', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES 
('Ma?in? de sp?lat vase profesional?', TO_DATE('2023-08-10', 'YYYY-MM-DD'), TO_DATE('2025-08-10', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES 
('Cu?ite speciale pentru decorare', TO_DATE('2022-04-05', 'YYYY-MM-DD'), TO_DATE('2024-04-05', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES 
('Mixer vertical pentru crem?', TO_DATE('2024-01-30', 'YYYY-MM-DD'), TO_DATE('2026-01-30', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES
('Termometru de buc?t?rie', TO_DATE('2023-06-12', 'YYYY-MM-DD'), TO_DATE('2025-06-12', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES
('Sticl? de m?surat', TO_DATE('2022-09-25', 'YYYY-MM-DD'), TO_DATE('2024-09-25', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES
('Forme de copt speciale', TO_DATE('2021-12-08', 'YYYY-MM-DD'), TO_DATE('2023-12-08', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES
('Calculator cu software de gestiune a vânz?rilor', TO_DATE('2023-04-20', 'YYYY-MM-DD'), TO_DATE('2025-04-20', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES 
('Calculator cu software contabil', TO_DATE('2021-10-05', 'YYYY-MM-DD'), TO_DATE('2023-10-05', 'YYYY-MM-DD'));

INSERT INTO USTENSILE (nume_ustensila, data_achizitiei, data_expirarii_garantiei) VALUES
('Imprimant? pentru facturi ?i rapoarte', TO_DATE('2024-03-12', 'YYYY-MM-DD'), TO_DATE('2026-03-12', 'YYYY-MM-DD'));

SELECT *
FROM USTENSILE;

CREATE TABLE DETALII_USTENSILE (
    id_angajat INT,
    id_ustensila INT,
    PRIMARY KEY (id_angajat, id_ustensila),
    FOREIGN KEY (id_angajat) REFERENCES ANGAJATI(id_angajat),
    FOREIGN KEY (id_ustensila) REFERENCES USTENSILE(id_ustensila)
);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(1, 1);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(5, 2);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(9, 3);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(13, 4);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(17, 5);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(1, 6);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES
(5, 7);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(9, 8);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(13, 9);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(17, 10);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES
(1, 3);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(17, 1);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(6, 11);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(10, 12);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(20, 13);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES
(2, 12);

INSERT INTO DETALII_USTENSILE (id_angajat, id_ustensila) VALUES 
(9, 2);

SELECT *
FROM DETALII_USTENSILE;


CREATE TABLE COMENZI (
    id_eveniment INT,
    id_produs INT,
    id_firma_livrare INT,
    PRIMARY KEY (id_eveniment, id_produs, id_firma_livrare),
    FOREIGN KEY (id_eveniment) REFERENCES EVENIMENTE(id_eveniment),
    FOREIGN KEY (id_produs) REFERENCES PRODUSE(id_produs),
    FOREIGN KEY (id_firma_livrare) REFERENCES FIRMA_LIVRARE(id_firma_livrare)
);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES 
(2, 5, 2);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES 
(3, 7, 4);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES 
(1, 12, 5);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(7, 9, 8);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(11, 18, 4);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(8, 17, 3);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(10, 5, 7);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(6, 19, 10);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(14, 3, 5);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(11, 11, 9);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(13, 10, 2);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(13, 17, 7);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(15, 4, 5);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(9, 7, 4);

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(6, 10, 8);

SELECT *
FROM COMENZI;
