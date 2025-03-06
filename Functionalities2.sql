SET SERVEROUTPUT ON;
--------
--Ex6: Realizeaza un subprogram care sa actualizeze stocul elementelor din cofetarie primind ca parametrii o lista de ID-uri ale elmentelor respective
--si o lista a cantitatilor consumate din acestea. Subprogramul va verifica existenta ingredientelor, daca stocul acestora e suficient si va actualiza cantitatea
--disponibila, respectiv va atentiona utilizatorul daca stocul produsului este mai mic decat cantitatea ceruta,afisand si numele ingredientelor al caror stoc 
--a fost actualizat.
---Subprogramul este unul stocat independent si am folosit cele trei tipuri de colectii: un tabel indexat, unul imbricat si un vector 
-------------------
-- Definim tipul de date pentru cele doua liste din input
CREATE OR REPLACE TYPE lista_nr IS TABLE OF NUMBER;

CREATE OR REPLACE PROCEDURE actualizeaza_stoc (
    ingrediente_input IN lista_nr,
    cantitati_input IN lista_nr 
) IS
    -- tabel indexat -> pentru stocurile curente.
    TYPE tab_ind IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_stocuri tab_ind; 

    -- vector -> pentru numele ingredientelor modificate
    TYPE tab_vec IS VARRAY(10) OF VARCHAR2(100);
    v_nume_ingrediente tab_vec := tab_vec(); 

    -- tabloul imbricat  -> pentru ingredientele fara stoc suficient
    TYPE tab_imbricat IS TABLE OF VARCHAR2;
    v_ingrediente_indisp tab_imbricat := tab_imbricat(); 

BEGIN
    --vf daca vectorul de intrare are dimensiunea corespunzatoare
    IF ingrediente_input.COUNT != cantitati_input.COUNT THEN
        RAISE_APPLICATION_ERROR(-20001, 'Dimensiunea listelor de ingrediente si cantitati nu corespunde.');
    END IF;

    FOR i IN 1 .. ingrediente_input.COUNT LOOP
        DECLARE
            v_nume_ingredient VARCHAR2(100); 
        BEGIN
            -- cant disponibila si numele ingredientului
            SELECT nume, cantitate_disponibila
            INTO v_nume_ingredient, v_stocuri(i)
            FROM INGREDIENTE
            WHERE id_ingredient = ingrediente_input(i);

            -- vf stocul
            IF v_stocuri(i) >= cantitati_input(i) THEN
                --actualizam stocul
                UPDATE INGREDIENTE
                SET cantitate_disponibila = cantitate_disponibila - cantitati_input(i)
                WHERE id_ingredient = ingrediente_input(i);

                -- adaugam ingredientele in vector
                v_nume_ingrediente.EXTEND; 
                v_nume_ingrediente(v_nume_ingrediente.COUNT) := v_nume_ingredient;

                DBMS_OUTPUT.PUT_LINE('SUCCES pentru ID: ' || ingrediente_input(i) || ', ' || v_nume_ingredient);
            ELSE
                -- adaugam ingredientele indisponibile daca exista
                v_ingrediente_indisp.EXTEND; 
                v_ingrediente_indisp(v_ingrediente_indisp.COUNT) := v_nume_ingredient;

                DBMS_OUTPUT.PUT_LINE('EROARE: Stoc insuficient pentru ID: ' || ingrediente_input(i) || ', ' || v_nume_ingredient);
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- daca ingredientele nu exista
                v_ingrediente_indisp.EXTEND; -- extindem tabloul pentru a permite adaugarea unui nou element
                v_ingrediente_indisp(v_ingrediente_indisp.COUNT) := 'Ingredient inexistent pentru ID: ' || ingrediente_input(i);

                DBMS_OUTPUT.PUT_LINE('EROARE: Ingredient inexistent pentru ID: ' || ingrediente_input(i));
        END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Ingredientele modificate cu succes:');
    FOR j IN 1 .. v_nume_ingrediente.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_nume_ingrediente(j));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Ingredientele fara stoc suficient:');
    FOR k IN 1 .. v_ingrediente_indisp.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_ingrediente_indisp(k));
    END LOOP;
END actualizeaza_stoc;
/

---Apelarea subprogramului
DECLARE
    ingrediente_input lista_nr; 
    cantitati_input lista_nr; 
BEGIN
    ingrediente_input := lista_nr(300); 
    cantitati_input := lista_nr(100);  

    actualizeaza_stoc(ingrediente_input, cantitati_input);
END;
/

DECLARE
    ingrediente_input lista_nr; 
    cantitati_input lista_nr; 
BEGIN
    ingrediente_input := lista_nr(1,2); 
    cantitati_input := lista_nr(1,200);  

    actualizeaza_stoc(ingrediente_input, cantitati_input);
END;
/

SELECT *
FROM INGREDIENTE;

-------------------
---Ex7: Sa se realizeze un subprogram care primeste ca parametrii doua date calendaristice si calculeaza suma de bani obtinuta din vanzarile din intervalul
---specificat de utilizator pentru fiecare cofetarie care are clienti inregistrati in baza de date(se afisaza adresa de mail pentru fiecare dintre acestea).
---Explicatie: Am folosit doua cursoare unul parametrizat(c_vanzari) si unul neparametrizat(c_cofetarii) care este folosit ca ciclu cursor. Cursorul neparametrizat itereaza prin toate cofetariile
---iar cel parametrizat este apelat pentru fiecare dintre acestea deci este dependent de primul.
CREATE OR REPLACE PROCEDURE total_vanzari_per_cofetarie (
    p_data_inceput IN DATE,    
    p_data_sfarsit IN DATE    
) AS
    --cursorul care itereaza prin toate cofetariile
    CURSOR c_cofetarii IS
        SELECT id_cofetarie, adresa_mail  
        FROM COFETARII c
        WHERE (SELECT COUNT(*) 
           FROM CLIENT cl 
           WHERE cl.id_cofetarie = c.id_cofetarie) > 0;
    
    -- cursorul parametrizat pentru a obtine totalul vanzarilor din cofetarie respectiva
    CURSOR c_vanzari(p_id_cofetarie NUMBER) IS
        SELECT SUM(v.suma) AS total_vanzari  
        FROM VANZARI v
        JOIN ANGAJATI a ON v.id_angajat = a.id_angajat
        WHERE a.id_cofetarie = p_id_cofetarie
        AND v.data_plata BETWEEN p_data_inceput AND p_data_sfarsit;
    
    v_total_vanzari NUMBER;  
    v_adresa_mail_cofetarie VARCHAR2(100);  
BEGIN
    FOR rec_cofetarie IN c_cofetarii LOOP
        v_adresa_mail_cofetarie := rec_cofetarie.adresa_mail;

        -- folosim cursorul parametrizat pentru a obtine vanzarile din cofetaria respectiva
        OPEN c_vanzari(rec_cofetarie.id_cofetarie);
        FETCH c_vanzari INTO v_total_vanzari;
        CLOSE c_vanzari;

        IF v_total_vanzari IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Cofetaria cu adresa de e-mail: ' || v_adresa_mail_cofetarie || ', are totalul vanzarilor: ' || v_total_vanzari);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Cofetaria cu adresa de e-mail: ' || v_adresa_mail_cofetarie || ', are totalul vaznarilor: 0');
        END IF;
    END LOOP;
END total_vanzari_per_cofetarie;
/

SELECT *
FROM COFETARII;
---Apelarea subprogramului
BEGIN
    total_vanzari_per_cofetarie(
        TO_DATE('2024-01-01', 'YYYY-MM-DD'), 
        TO_DATE('2024-12-31', 'YYYY-MM-DD')  
    );
END;
/
--------------------------------
---Ex8:Sa sa afiseze pentru fiecare cofetarie care are mai mult de doua produse inregistrate, produsele sanatoase in functie de preferintele utilizatorului.
---Acestea sunt produsele, dintre cele care au scorul de sanatate peste cel mediu din cofetaria respectiva, scorul de sanatate mai mare decat cel intordus.
---Scorul de sanatate se calculeaza  din suma valorii calorice si a cantitatii de grasimi pe 100.
---Explicatie: Subprogramul este de tip functie si contine o comanda caare utilizeaza 3 tabele (INFORMATII_NUTRITIONALE, DETALII_VANZARE, COFETARII)

---definim tipul de date pentru tabloul returnat
CREATE OR REPLACE TYPE t_produse_sanatoase IS TABLE OF VARCHAR2(255);

CREATE OR REPLACE FUNCTION produse_sanatoase(p_scor_sanatate NUMBER)
RETURN t_produse_sanatoase
IS
    v_rezultate t_produse_sanatoase := t_produse_sanatoase();

    exceptie_scor_negativ EXCEPTION;
    exceptie_scor_null EXCEPTION;

BEGIN

    IF p_scor_sanatate IS NULL THEN
        RAISE exceptie_scor_null; 
    END IF;

    IF p_scor_sanatate < 0 THEN
        RAISE exceptie_scor_negativ; 
    END IF;

    -- produsele care respecta conditia 
    -- folosim procedeul bulk collect pentru a transfera liniile in tabela
    SELECT p.nume || ' - Cofetaria cu ID-ul: ' || c.id_cofetarie || 
           ' (Scor Sanatate: ' || ROUND((inf.valoare_calorica + inf.cant_grasimi) / 100, 2) || ')'
    BULK COLLECT INTO v_rezultate
    FROM PRODUSE p
    JOIN DETALII_VANZARE dv ON p.id_produs = dv.id_produs
    JOIN INFORMATII_NUTRITIONALE inf ON p.id_produs = inf.id_produs
    JOIN COFETARII c ON dv.id_cofetarie = c.id_cofetarie
    WHERE (inf.valoare_calorica + inf.cant_grasimi) / 100 > (
        SELECT AVG(scor_mediu)
        --calcuam scorul mediu pentru cofetariile care vand cel putin 2 produse
        FROM (
            SELECT AVG((inf1.valoare_calorica + inf1.cant_grasimi) / 100) AS scor_mediu
            FROM INFORMATII_NUTRITIONALE inf1
            JOIN DETALII_VANZARE dv1 ON inf1.id_produs = dv1.id_produs
            JOIN COFETARII c1 ON dv1.id_cofetarie = c1.id_cofetarie
            GROUP BY c1.id_cofetarie
            HAVING COUNT(*) >= 2
        )
    )
    AND (inf.valoare_calorica + inf.cant_grasimi) / 100 > p_scor_sanatate
    ORDER BY ROUND((inf.valoare_calorica + inf.cant_grasimi) / 100, 2) DESC;

    IF v_rezultate.COUNT = 0 THEN
        RAISE NO_DATA_FOUND; 
    END IF;

    RETURN v_rezultate;

EXCEPTION
    WHEN exceptie_scor_negativ THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Scorul de sanatate trebuie sa fie un numar pozitiv.');
        RETURN t_produse_sanatoase(); 

    WHEN exceptie_scor_null THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Parametrul p_scor_sanatate nu poate fi NULL.');
        RETURN t_produse_sanatoase(); 

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista produse care sa indeplineasca conditia specificata.');
        RETURN t_produse_sanatoase(); 

    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Interogarea a returnat prea multe randuri.');
        RETURN t_produse_sanatoase(); 

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare neasteptata: ' || SQLERRM);
        RETURN t_produse_sanatoase();
END produse_sanatoase;
/

----Apelare subprogram
DECLARE
    v_rezultate t_produse_sanatoase; 
BEGIN
    v_rezultate := produse_sanatoase(10); 

    FOR i IN 1 .. v_rezultate.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_rezultate(i));
    END LOOP;
END;
/

DECLARE
    v_rezultate t_produse_sanatoase; 
BEGIN
    v_rezultate := produse_sanatoase(2.5); 

    FOR i IN 1 .. v_rezultate.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_rezultate(i));
    END LOOP;
END;
/

--------------------
---Ex10:Angajatii de la resurse umane care se ocupa de mentenanta bazei de date au o scurta pauza de la 13:00 la 13:30 de luni pana vineri, asa ca se doreste ca
---in acest interval orar sa nu se mai efectueze nicio operatie de update, delete sau insert pe tabela ANGAJATI respectiv pe tabelele pentru categoriile acesteia 
---MANAGER, COFETAR, VANZATOR si CONTABIL
CREATE OR REPLACE TRIGGER restrictii_operatii_angajati
BEFORE INSERT OR DELETE OR UPDATE ON ANGAJATI
DECLARE
    ora_curenta NUMBER;
    minut_curent NUMBER;
    zi_curenta VARCHAR2(10);
BEGIN
    ora_curenta := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    minut_curent := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    zi_curenta := TO_CHAR(SYSDATE, 'DAY');

    -- verificarea daca este pauza 
    IF TRIM(zi_curenta) IN ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY') AND
       ora_curenta = 13 AND minut_curent BETWEEN 0 AND 30 THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20001, 'Inserarea in tabelul ANGAJATI este interzisa in timpul pauzei (13:00-13:30).');
        ELSIF DELETING THEN
            RAISE_APPLICATION_ERROR(-20002, 'Stergerea din tabelul ANGAJATI este interzisa in timpul pauzei (13:00-13:30).');
        ELSE 
            RAISE_APPLICATION_ERROR(-20003, 'Actualizarile în tabelul ANGAJATI sunt interzise in timpul pauzei (13:00-13:30).');
        END IF;
    END IF;
END;
/
-----Se va proceda identic si pentru celelalte 4 tabele

CREATE OR REPLACE TRIGGER restrictii_operatii_angajati_manager
BEFORE INSERT OR DELETE OR UPDATE ON MANAGER
DECLARE
    ora_curenta NUMBER;
    minut_curent NUMBER;
    zi_curenta VARCHAR2(10);
BEGIN
    ora_curenta := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    minut_curent := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    zi_curenta := TO_CHAR(SYSDATE, 'DAY');

    IF TRIM(zi_curenta) IN ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY') AND
       ora_curenta = 13 AND minut_curent BETWEEN 0 AND 30 THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20001, 'Inserarea in tabelul MANAGER este interzisa in timpul pauzei (13:00-13:30).');
        ELSIF DELETING THEN
            RAISE_APPLICATION_ERROR(-20002, 'Stergerea din tabelul MANAGER este interzisa in timpul pauzei (13:00-13:30).');
        ELSE 
            RAISE_APPLICATION_ERROR(-20003, 'Actualizarile în tabelul MANAGER sunt interzise in timpul pauzei (13:00-13:30).');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER restrictii_operatii_angajati_contabil
BEFORE INSERT OR DELETE OR UPDATE ON CONTABIL
DECLARE
    ora_curenta NUMBER;
    minut_curent NUMBER;
    zi_curenta VARCHAR2(10);
BEGIN
    ora_curenta := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    minut_curent := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    zi_curenta := TO_CHAR(SYSDATE, 'DAY');

    IF TRIM(zi_curenta) IN ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY') AND
       ora_curenta = 13 AND minut_curent BETWEEN 0 AND 30 THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20001, 'Inserarea in tabelul CONTABIL este interzisa in timpul pauzei (13:00-13:30).');
        ELSIF DELETING THEN
            RAISE_APPLICATION_ERROR(-20002, 'Stergerea din tabelul CONTABIL este interzisa in timpul pauzei (13:00-13:30).');
        ELSE 
            RAISE_APPLICATION_ERROR(-20003, 'Actualizarile în tabelul CONTABIL sunt interzise in timpul pauzei (13:00-13:30).');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER restrictii_operatii_angajati_cofetar
BEFORE INSERT OR DELETE OR UPDATE ON COFETAR
DECLARE
    ora_curenta NUMBER;
    minut_curent NUMBER;
    zi_curenta VARCHAR2(10);
BEGIN
    ora_curenta := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    minut_curent := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    zi_curenta := TO_CHAR(SYSDATE, 'DAY');

    IF TRIM(zi_curenta) IN ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY') AND
       ora_curenta = 13 AND minut_curent BETWEEN 0 AND 30 THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20001, 'Inserarea in tabelul COFETAR este interzisa in timpul pauzei (13:00-13:30).');
        ELSIF DELETING THEN
            RAISE_APPLICATION_ERROR(-20002, 'Stergerea din tabelul COFETAR este interzisa in timpul pauzei (13:00-13:30).');
        ELSE 
            RAISE_APPLICATION_ERROR(-20003, 'Actualizarile în tabelul COFETAR sunt interzise in timpul pauzei (13:00-13:30).');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER restrictii_operatii_angajati_vanzator
BEFORE INSERT OR DELETE OR UPDATE ON VANZATOR
DECLARE
    ora_curenta NUMBER;
    minut_curent NUMBER;
    zi_curenta VARCHAR2(10);
BEGIN
    ora_curenta := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    minut_curent := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    zi_curenta := TO_CHAR(SYSDATE, 'DAY');

    IF TRIM(zi_curenta) IN ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY') AND
       ora_curenta = 13 AND minut_curent BETWEEN 0 AND 30 THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20001, 'Inserarea in tabelul VANZATOR este interzisa in timpul pauzei (13:00-13:30).');
        ELSIF DELETING THEN
            RAISE_APPLICATION_ERROR(-20002, 'Stergerea din tabelul VANZATOR este interzisa in timpul pauzei (13:00-13:30).');
        ELSE -- Actualizare
            RAISE_APPLICATION_ERROR(-20003, 'Actualizarile în tabelul VANZATOR sunt interzise in timpul pauzei (13:00-13:30).');
        END IF;
    END IF;
END;
/
INSERT INTO ANGAJATI (id_cofetarie, tip_angajat, nume, prenume, numar_de_telefon, salariu, numar_ore_lucru_zi, data_angajarii)
VALUES (104, 'cofetar', 'Ionescu', 'Florentina', '0751568356', 3500, 4, TO_DATE('20-05-2024', 'DD-MM-YYYY'));

----------------
----Ex11: Inainte de plasarea unei comenzi ar trebui verificat stocul incredientelor pentru produsul respectiv. Sa se realizeze un trigger care va verifica stocul
---si nu va adauga o comanda care contine un produs care nu are cantitatea necesara din toate ingredientele din compozitie disponibila.
---Se va afiisa si u n reminder pentru a cumpara cantitatea care lipseste din ingredientul respectiv.

CREATE OR REPLACE PROCEDURE verifica_stoc(p_id_produs NUMBER) IS
    v_cantitate_necesara NUMBER;
    v_cantitate_disponibila NUMBER;
    v_diferenta NUMBER;
BEGIN
    FOR c IN (
        SELECT dc.id_ingredient, dc.cantitate_necesara, i.cantitate_disponibila
        FROM DETALII_COMPOZITIE dc
        JOIN INGREDIENTE i ON dc.id_ingredient = i.id_ingredient
        WHERE dc.id_produs = p_id_produs
    ) LOOP
        v_cantitate_necesara := c.cantitate_necesara;
        v_cantitate_disponibila := c.cantitate_disponibila;

        IF v_cantitate_disponibila < v_cantitate_necesara THEN
           v_diferenta := v_cantitate_necesara - v_cantitate_disponibila;
            DBMS_OUTPUT.PUT_LINE('Stoc insuficient, trebuie cumparate : ' ||v_diferenta || ' grame din ingredientul cu ID-ul: ' || c.id_ingredient);  
            RAISE_APPLICATION_ERROR(-20001, 
                'Stoc insuficient pentru ingredientul cu ID-ul: ' || c.id_ingredient || 
                ', Cantitate necesara: ' || v_cantitate_necesara || 
                ', Cantitate disponibila: ' || v_cantitate_disponibila);    
            END IF;
    END LOOP;
END verifica_stoc;


CREATE OR REPLACE TRIGGER verificare_stoc
BEFORE INSERT ON COMENZI
FOR EACH ROW
BEGIN
    -- apelam subprogramul definit anterior
    verifica_stoc(:NEW.id_produs);
END verificare_stoc;

INSERT INTO COMENZI (id_eveniment, id_produs, id_firma_livrare) VALUES
(6, 2, 8) --- declansare trigger

BEGIN
    verifica_stoc_produs(2);
END;



DROP TRIGGER operatii_ldd;

SELECT *
FROM OPERATII_LDD_EFECTUATE
----------------
---Ex12: Realizati un trigger prin intermediul caruia se vor inregistra intr-un tabel detaliile despre fiecare operatie de create, drop sau alter efectuate
---asupra bazei de date

--secventa pentru generare id
CREATE SEQUENCE OPERATII_LDD_EFECTUATE_SEQ START WITH 1;

CREATE TABLE OPERATII_LDD_EFECTUATE (
    id_operatie INT DEFAULT OPERATII_LDD_EFECTUATE_SEQ.NEXTVAL PRIMARY KEY,
    utilizator VARCHAR2(50),
    nume_operatie VARCHAR2(50),
    nume_obiect VARCHAR2(100),
    tip_obiect VARCHAR2(50),
    data_efectuare TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE TRIGGER operatii_ldd
AFTER CREATE OR DROP OR ALTER
ON SCHEMA
DECLARE
    v_tip_eveniment VARCHAR2(50);
    v_tip_obiect VARCHAR2(30);
    v_nume_obiect VARCHAR2(100);
    v_username VARCHAR2(30);
    v_log_id NUMBER;
BEGIN
    -- aflam ce tip de operatie este
    v_tip_eveniment := CASE
        WHEN ora_sysevent = 'CREATE' THEN 'CREATE'
        WHEN ora_sysevent = 'ALTER' THEN 'ALTER'
        WHEN ora_sysevent = 'DROP' THEN 'DROP'
    END;

    v_tip_obiect := ora_dict_obj_type;
    v_nume_obiect := ora_dict_obj_name;
    v_username := SYS_CONTEXT('USERENV', 'SESSION_USER'); 

    SELECT operatii_ldd_efectuate_seq.NEXTVAL INTO v_log_id FROM dual;

    INSERT INTO operatii_ldd_efectuate (
        id_operatie, 
        utilizator, 
        nume_operatie, 
        nume_obiect, 
        tip_obiect, 
        data_efectuare
    ) VALUES (
        v_log_id, 
        v_username, 
        v_tip_eveniment, 
        v_nume_obiect, 
        v_tip_obiect, 
        SYSTIMESTAMP
    );
END;
/

ALTER TRIGGER operatii_ldd DISABLE;
CREATE TABLE TEST_LDD (id INT);

CREATE TABLE TEST_LDD1 (id INT);
SELECT *
FROM OPERATII_LDD_EFECTUATE;

-------------------------------
---Ex9: Pentru cofetarie ar fi foarte utila crearea unui catalog de preferinte personalizat pentru fiecare client,asa ca prin intermediul unui subprogram stocat 
---independent de tip procedura sa se creeze unul. Acesta va avea doi parametrii, se va introduce numele clientului si numarul de recomandari dorite. Acestea vor
---fi filtrate dupa pret, faptul ca au o promotie activa si vor fi afisate numai cele din cateoria preferata a clientului respectiv. Subprogramul are si un parametru
---optional unde se va cere introducerea id-ului clientului daca exista mai multi clienti cu acelasi nume(id-ul va fi sugerat pe ecran pentru ca subprogramul sa fie
---apelat din nou cu parametru id-ul respectiv).
-------------
CREATE OR REPLACE PROCEDURE recomandari (
    p_nume_client IN VARCHAR2,
    p_numar_recomandari IN INT,
    p_id_client IN NUMBER DEFAULT NULL 
) AS
    v_id_client NUMBER;
    v_id_cofetarie NUMBER;
    v_numar_recomandari_realizat INT := 0;

    exceptie1_clientul_nu_exista EXCEPTION;
    exceptie2_produse_insuficiente EXCEPTION;
    exceptie3_nume_invalid EXCEPTION;
    exceptie4_nr_recomandari_invalid EXCEPTION;

BEGIN
    IF p_nume_client IS NULL OR p_nume_client = '' THEN
        RAISE exceptie3_nume_invalid; 
    END IF;

    IF p_numar_recomandari <= 0 THEN
        RAISE exceptie4_nr_recomandari_invalid; 
    END IF;

    -- vf daca clientul exista 
    IF p_id_client IS NOT NULL THEN
        -- daca id-ul clientului este dat il folosim
        SELECT id_client INTO v_id_client
        FROM CLIENT
        WHERE id_client = p_id_client;

    ELSE
        BEGIN
            -- daca id-ul nu este dat vom cauta clientul dupa nume 
            SELECT id_client INTO v_id_client
            FROM CLIENT
            WHERE nume = p_nume_client;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE exceptie1_clientul_nu_exista; 
           WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('Exista mai multi clienti cu numele "' || p_nume_client || '".');
                FOR clnt IN (SELECT id_client, nume, prenume FROM CLIENT WHERE nume = p_nume_client) LOOP
                     DBMS_OUTPUT.PUT_LINE('ID: ' || clnt.id_client || ', Nume: ' || clnt.nume || ', Prenume: ' || clnt.prenume);
                END LOOP;
                RETURN;

        END;
    END IF;

    -- obtinem id-ul cofetariei clientului cautat
    SELECT id_cofetarie INTO v_id_cofetarie
    FROM CLIENT
    WHERE id_client = v_id_client;

    -- filtram recomandarile si informatile afisate despre acestea
    FOR recomandare IN (
        SELECT p.nume AS nume_produs, 
               i.valoare_calorica, 
               i.cant_carbohidrati, 
               i.cant_grasimi,
               r.timp_preparare 
        FROM CLIENT c
        JOIN COFETARII cf ON c.id_cofetarie = cf.id_cofetarie
        JOIN PRODUSE p ON p.categorie = c.produs_preferat
        JOIN PROMOTII pr ON p.id_produs = pr.id_produs
        LEFT JOIN INFORMATII_NUTRITIONALE i ON p.id_produs = i.id_produs
        LEFT JOIN RETETA r ON p.id_produs = r.id_produs 
        WHERE c.nume = p_nume_client
          AND (pr.data_inceput <= SYSDATE AND pr.data_sfarsit >= SYSDATE)
          AND p.disponibilitate = 'DA'
           AND p.categorie = (SELECT produs_preferat FROM CLIENT WHERE id_client = v_id_client)
        ORDER BY p.pret
        FETCH FIRST p_numar_recomandari ROWS ONLY
    ) LOOP
        v_numar_recomandari_realizat := v_numar_recomandari_realizat + 1;

        -- Afisam recomandarile
        DBMS_OUTPUT.PUT_LINE('Produs: ' || recomandare.nume_produs || 
                             ', Valoare calorica: ' || recomandare.valoare_calorica || 
                             ', Carbohidrati: ' || recomandare.cant_carbohidrati || 
                             ', Grasimi: ' || recomandare.cant_grasimi || 
                             ', Timp preparare: ' || recomandare.timp_preparare || ' minute');
    END LOOP;

    IF v_numar_recomandari_realizat < p_numar_recomandari THEN
        RAISE exceptie2_produse_insuficiente; 
    END IF;

EXCEPTION
    WHEN exceptie1_clientul_nu_exista THEN
        DBMS_OUTPUT.PUT_LINE('Clientul ' || p_nume_client || ' nu exista.');
     WHEN exceptie2_produse_insuficiente THEN
        DBMS_OUTPUT.PUT_LINE('Nu sunt suficiente produse recomandate.');
    WHEN exceptie3_nume_invalid THEN
        DBMS_OUTPUT.PUT_LINE('Numele clientului nu poate fi NULL sau necompletat.');
    WHEN exceptie4_nr_recomandari_invalid THEN
        DBMS_OUTPUT.PUT_LINE('Numarul de recomandari trebuie sa fie mai mare decat 0.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
END recomandari;


------------
---apelare subprogram
 CALL recomandari('Ionescu', 0);
 
 
 SELECT *
 FROM CLIENT;
 
 SELECT *
 FROM PROMOTII;
 
 ------------

-----------
----Ex13: Se doreste realizarea unei platforme a cofetariei pentru facilitarea interactiunii dintre lantul de cofetarii si viitorii colaboratori. Astfel se va
----defini un pachet care contine mai multe functii si proceduri care vor adauga noi colaboratori sau vor contribui la afisarea unor infromatii utile pentru acestia
CREATE OR REPLACE PACKAGE pachet_platforma_cofetarie AS
    TYPE tip_client IS RECORD (
        id_cofetarie NUMBER,
        nume VARCHAR2(100),
        prenume VARCHAR2(100),
        numar_telefon VARCHAR2(15),
        adresa_mail VARCHAR2(100),
        data_nastere DATE,
        produs_preferat VARCHAR2(100),
        metoda_plata VARCHAR2(50)
    );

    TYPE tip_furnizor IS RECORD (
        id_cofetarie NUMBER,
        nume VARCHAR2(100),
        adresa VARCHAR2(200),
        adresa_mail VARCHAR2(100),
        produse_furnizate VARCHAR2(200)
    );

    TYPE tip_firma_livrare IS RECORD (
        nume VARCHAR2(100),
        numar_telefon VARCHAR2(15),
        pret_livrare NUMBER
    );

    TYPE tip_eveniment IS RECORD (
        tip_eveniment VARCHAR2(100),
        data_eveniment DATE,
        numar_telefon VARCHAR2(15),
        stare_eveniment VARCHAR2(50)
    );

    TYPE lista IS TABLE OF NUMBER;

    PROCEDURE adauga_client (p_client tip_client);
    PROCEDURE adauga_furnizor (p_furnizor tip_furnizor);
    PROCEDURE adauga_firma_livrare (p_firma tip_firma_livrare);
    PROCEDURE adauga_eveniment (p_eveniment tip_eveniment);
    FUNCTION cofetarii_joburi_disponibile (p_tip_job VARCHAR2) RETURN lista;
    PROCEDURE posturi_disponibile (p_id_cofetarie NUMBER);
    FUNCTION eveniment_existent (p_data_eveniment DATE) RETURN BOOLEAN;
    PROCEDURE verifica_si_adauga_eveniment (p_eveniment tip_eveniment);
    FUNCTION evenimente_viitoare RETURN lista;
END pachet_platforma_cofetarie;
/

CREATE OR REPLACE PACKAGE BODY pachet_platforma_cofetarie AS

    --inserare client in tabel
    PROCEDURE adauga_client (
        p_client tip_client
    ) IS
        v_id_client NUMBER;
        v_count NUMBER;
    BEGIN
        SELECT NVL(MAX(id_client), 0) + 1 INTO v_id_client 
        FROM CLIENT;

        -- vf daca id-ul exista deja
        SELECT COUNT(*) INTO v_count
        FROM CLIENT
        WHERE id_client = v_id_client;

        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Eroare: ID-ul clientului exista deja.');
            RETURN;
        END IF;

        INSERT INTO CLIENT (id_client, id_cofetarie, nume, prenume, numar_de_telefon, adresa_mail, data_nastere, produs_preferat, metoda_plata_preferata)
        VALUES (v_id_client, p_client.id_cofetarie, p_client.nume, p_client.prenume, p_client.numar_telefon, p_client.adresa_mail, p_client.data_nastere, p_client.produs_preferat, p_client.metoda_plata);

        DBMS_OUTPUT.PUT_LINE('Client nou adaugat cu ID: ' || v_id_client);

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Eroare la adaugarea clientului: ' || SQLERRM);
    END adauga_client;
    
    --inserare furnizor in tabel
    PROCEDURE adauga_furnizor (
        p_furnizor tip_furnizor
    ) IS
        v_id_furnizor NUMBER;
        v_count NUMBER;
    BEGIN
        SELECT NVL(MAX(id_furnizor), 0) + 1 INTO v_id_furnizor 
        FROM FURNIZOR;

        SELECT COUNT(*) INTO v_count
        FROM FURNIZOR
        WHERE id_furnizor = v_id_furnizor;

        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Eroare: ID-ul furnizorului exista deja.');
            RETURN;
        END IF;

        INSERT INTO FURNIZOR (id_furnizor, nume, id_cofetarie, adresa, adresa_mail, produse_furnizate)
        VALUES (v_id_furnizor, p_furnizor.nume, p_furnizor.id_cofetarie, p_furnizor.adresa, p_furnizor.adresa_mail, p_furnizor.produse_furnizate);

        DBMS_OUTPUT.PUT_LINE('Furnizor nou adaugat cu ID: ' || v_id_furnizor);

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Eroare la adaugarea furnizorului: ' || SQLERRM);
    END adauga_furnizor;

    --inserare firma de livrare in tabel
    PROCEDURE adauga_firma_livrare (
        p_firma tip_firma_livrare
    ) IS
        v_id_firma NUMBER;
        v_count NUMBER;
    BEGIN
        SELECT NVL(MAX(id_firma_livrare), 0) + 1 INTO v_id_firma 
        FROM FIRMA_LIVRARE;

        SELECT COUNT(*) INTO v_count
        FROM FIRMA_LIVRARE
        WHERE id_firma_livrare = v_id_firma;

        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Eroare: ID-ul firmei de livrare exista deja.');
            RETURN;
        END IF;

        INSERT INTO FIRMA_LIVRARE (id_firma_livrare, nume, numar_telefon, pret_livrare)
        VALUES (v_id_firma, p_firma.nume, p_firma.numar_telefon, p_firma.pret_livrare);

        DBMS_OUTPUT.PUT_LINE('Firma de livrare noua adaugata cu ID: ' || v_id_firma);

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Eroare la adaugarea firmei de livrare: ' || SQLERRM);
    END adauga_firma_livrare;

    --inserare eveniment in tabel
    PROCEDURE adauga_eveniment (
    p_eveniment tip_eveniment
) IS
    v_id_eveniment NUMBER;
    v_count NUMBER;
BEGIN
    SELECT NVL(MAX(id_eveniment), 0) + 1 INTO v_id_eveniment 
    FROM EVENIMENTE;

    SELECT COUNT(*) INTO v_count
    FROM EVENIMENTE
    WHERE id_eveniment = v_id_eveniment;

    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: ID-ul evenimentului exista deja.');
        RETURN;
    END IF;

    INSERT INTO EVENIMENTE (id_eveniment, tip_eveniment, data_eveniment, numar_telefon, stare_eveniment)
    VALUES (v_id_eveniment, p_eveniment.tip_eveniment, p_eveniment.data_eveniment, p_eveniment.numar_telefon, p_eveniment.stare_eveniment);

    DBMS_OUTPUT.PUT_LINE('Eveniment nou adaugat cu ID: ' || v_id_eveniment || 
                         ', tip: ' || p_eveniment.tip_eveniment || 
                         ', data: ' || p_eveniment.data_eveniment);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare la adaugarea evenimentului: ' || SQLERRM);
END adauga_eveniment;

   
    --primeste ca parametru un job si returneaza o lista a cofetariilor unde acesta este disponibil
    FUNCTION cofetarii_joburi_disponibile (
        p_tip_job VARCHAR2
    ) RETURN lista IS
        v_cofetarii lista;
    BEGIN
        SELECT id_cofetarie
        BULK COLLECT INTO v_cofetarii
        FROM COFETARII
        WHERE id_cofetarie NOT IN (
            SELECT DISTINCT a.id_cofetarie
            FROM ANGAJATI a
            WHERE a.tip_angajat = p_tip_job
        );

        RETURN v_cofetarii;
    END cofetarii_joburi_disponibile;

--primeste ca parametru o cofetarie si returneaza posturile libere din aceasta apeland functia cofetarii_joburi_disponibile
 PROCEDURE posturi_disponibile (
    p_id_cofetarie NUMBER
) IS
    v_manager lista;
    v_cofetar lista;
    v_vanzator lista;
    v_contabil lista;
    v_posturi_disponibile BOOLEAN := FALSE; 
BEGIN
    v_manager := cofetarii_joburi_disponibile('manager');
    FOR i IN 1..v_manager.COUNT LOOP
        IF v_manager(i) = p_id_cofetarie THEN
            DBMS_OUTPUT.PUT_LINE('Post disponibil: Manager');
            v_posturi_disponibile := TRUE; 
        END IF;
    END LOOP;

    v_cofetar := cofetarii_joburi_disponibile('cofetar');
    FOR i IN 1..v_cofetar.COUNT LOOP
        IF v_cofetar(i) = p_id_cofetarie THEN
            DBMS_OUTPUT.PUT_LINE('Post disponibil: Cofetar');
            v_posturi_disponibile := TRUE; 
        END IF;
    END LOOP;

    v_vanzator := cofetarii_joburi_disponibile('vanzator');
    FOR i IN 1..v_vanzator.COUNT LOOP
        IF v_vanzator(i) = p_id_cofetarie THEN
            DBMS_OUTPUT.PUT_LINE('Post disponibil: Vanzator');
            v_posturi_disponibile := TRUE; 
        END IF;
    END LOOP;

    v_contabil := cofetarii_joburi_disponibile('contabil');
    FOR i IN 1..v_contabil.COUNT LOOP
        IF v_contabil(i) = p_id_cofetarie THEN
            DBMS_OUTPUT.PUT_LINE('Post disponibil: Contabil');
            v_posturi_disponibile := TRUE; 
        END IF;
    END LOOP;

    IF NOT v_posturi_disponibile THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista posturi disponibile pentru aceasta cofetarie.');
    END IF;

END posturi_disponibile;

    --verifica daca exista un eveniment la o data introdusa ca parametru
    FUNCTION eveniment_existent (
        p_data_eveniment DATE
    ) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM EVENIMENTE
        WHERE data_eveniment = p_data_eveniment;

        RETURN v_count > 0; 
    END eveniment_existent;
 
    ---adauga un eveniment doar daca nu exista si altul in acea zi apeland functia eveniment_existent  si procedura adaiga_eveniment
    PROCEDURE verifica_si_adauga_eveniment (
        p_eveniment tip_eveniment
    ) IS
    BEGIN
        IF eveniment_existent(p_eveniment.data_eveniment) THEN
            DBMS_OUTPUT.PUT_LINE('Exista deja un eveniment pentru data ' || p_eveniment.data_eveniment);
        ELSE
            adauga_eveniment(p_eveniment);
        END IF;
    END verifica_si_adauga_eveniment;

    ---afisaza toate evenimentele viitoare cu care colaboreaza cofetaria
FUNCTION evenimente_viitoare RETURN lista IS
    v_evenimente lista := lista(); 
    CURSOR c_evenimente IS
        SELECT id_eveniment
        FROM EVENIMENTE
        WHERE data_eveniment > SYSDATE;

BEGIN
    FOR r_eveniment IN c_evenimente LOOP
        v_evenimente.EXTEND; 
        v_evenimente(v_evenimente.COUNT) := r_eveniment.id_eveniment; 
    END LOOP;

    RETURN v_evenimente; 
END evenimente_viitoare;


END pachet_platforma_cofetarie;
/

CALL pachet_platforma_cofetarie.adauga_client(pachet_platforma_cofetarie.tip_client(101, 'Calin', 'Andreea', '0712345678', 'ion.popescu@example.com', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Tort de ciocolat?', 'Card'));

CALL pachet_platforma_cofetarie.adauga_furnizor(pachet_platforma_cofetarie.tip_furnizor(102, 'Str. Lalelelor, Nr. 4, Bucuresti', 'ustensile@gmail.com', 'ustensile'));
CALL pachet_platforma_cofetarie.adauga_firma_livrare(pachet_platforma_cofetarie.tip_firma_livrare('Livrari rapide', '0734556512', 30));


--verificare functie cofetarii_joburi_disponibile
DECLARE
    v_cofetarii pachet_platforma_cofetarie.lista;
BEGIN
    v_cofetarii := pachet_platforma_cofetarie.cofetarii_joburi_disponibile('contabil');

    FOR i IN 1..v_cofetarii.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Cofetarie disponibila cu ID: ' || v_cofetarii(i));
    END LOOP;
END;
/

--apelare procedura posturi_disponibile
BEGIN
    pachet_platforma_cofetarie.posturi_disponibile(101);
END;
/

----verificare functie eveniment_existent
DECLARE
    v_data_eveniment DATE := TO_DATE('2024-06-27', 'YYYY-MM-DD'); 
    v_existent BOOLEAN;
BEGIN
    v_existent := pachet_platforma_cofetarie.eveniment_existent(v_data_eveniment);
    
    IF v_existent THEN
        DBMS_OUTPUT.PUT_LINE('Exista un eveniment pe data ' || v_data_eveniment);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu exista evenimente pe data ' || v_data_eveniment);
    END IF;
END;
/

---apel procedura verifica_si_adauga_eveniment
DECLARE
    v_eveniment pachet_platforma_cofetarie.tip_eveniment;
BEGIN
    v_eveniment.tip_eveniment := 'Aniversare';
    v_eveniment.data_eveniment := TO_DATE('2025-04-12', 'YYYY-MM-DD'); 
    v_eveniment.numar_telefon := '0712345631'; 
    v_eveniment.stare_eveniment := 'planificat';

    pachet_platforma_cofetarie.verifica_si_adauga_eveniment(v_eveniment);
END;
/

----apel functie evenimente_viitoare
DECLARE
    v_evenimente pachet_platforma_cofetarie.lista;
BEGIN
    v_evenimente := pachet_platforma_cofetarie.evenimente_viitoare;

    IF v_evenimente.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista evenimente viitoare.');
    ELSE
        FOR i IN 1..v_evenimente.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('ID Eveniment Viitor: ' || v_evenimente(i));
        END LOOP;
    END IF;
END;
/


------------
 
SELECT *
FROM EVENIMENTE
ORDER BY id_eveniment;




