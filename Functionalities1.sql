
--Cererea 1: Afi?a?i numeme, prenumele ?i salariul angaja?ilor, care au fost angaja?i în ultimele 9 luni care lucreaz? la o cofetarie unde
--se vinde tort cu fructe de p?dure. (subcerere sincronizat? in care intervin 3 tabele si o functie pe data calendaristica
SELECT 
    A.nume, 
    A.prenume,
    A.salariu
FROM 
    ANGAJATI A
WHERE 
    A.data_angajarii > ADD_MONTHS(SYSDATE, -9)
    AND EXISTS (
        SELECT 1
        FROM COFETARII C
        JOIN DETALII_VANZARE DV ON C.id_cofetarie = DV.id_cofetarie
        JOIN PRODUSE P ON DV.id_produs = P.id_produs
        WHERE 
            A.id_cofetarie = C.id_cofetarie
            AND P.nume = 'Tort cu fructe de padure'
    );


-- Cererea 2: S? se afi?eze id-ul, numele, prenumele, salariul, angaja?ilor al c?ror prenume încep cu liera ”A”. Daca angajatul este manager se va afi?a titlul
--altfel se va afi?a ”Angajat Non-Manager”, respectiv num?rul de anagaja?i supraveghea?i sau 0 dac? nu e manager. Rezultatele se vor ordona crescator
--dup? nume ?i descresc?tor dup? salariu.
--ordon?ri ?i utilizarea func?iilor NVL ?i DECODE (în cadrul aceleia?i cereri) ?i o func?ie pentru ?iruri de caractere
SELECT 
    a.id_angajat, 
    a.nume, 
    a.prenume, 
    NVL(m.titlu_manager, 'Angajat Non-Manager') AS titlu_manager, 
    NVL(m.numar_angajati_supravegheati, 0) AS numar_angajati_supravegheati, 
    DECODE(m.titlu_manager, 
        NULL, 'Nu', 
        'Da') AS este_manager,
    a.salariu
FROM 
    ANGAJATI a
LEFT JOIN 
    MANAGER m ON a.id_angajat = m.id_angajat
WHERE 
    SUBSTR(a.prenume, 1, 1) = 'A'
ORDER BY 
    a.salariu DESC, 
    a.nume ASC;

-----Cererea 3: Afi?a?i id-ul, num?rul de telefon ?i adresa de mail pentru cofet?riile care vând cel pu?in un produs care are o promo?ie care dureaz? mai mult de doua
----luni ?i ale c?ror re?ete au un timp de preparare mai mare decat media.
---Am folosit o subcerere nesincronizat? în clauza FROM, o func?ie pe date calendaristice(MONTHS_BETWEEN), ordonare folosind ORDER BY 
SELECT 
    c.id_cofetarie, 
    c.numar_de_telefon, 
    c.adresa_mail
FROM COFETARII c
WHERE c.id_cofetarie IN (
    SELECT DISTINCT dv.id_cofetarie 
    FROM DETALII_VANZARE dv
    JOIN PROMOTII p ON dv.id_produs = p.id_produs
    WHERE MONTHS_BETWEEN(p.data_sfarsit, p.data_inceput) > 2
)
AND c.id_cofetarie IN (
    SELECT dv.id_cofetarie
    FROM (
        SELECT 
            r.id_produs
        FROM 
            RETETA r
        WHERE 
            r.timp_preparare > (
                SELECT AVG(timp_preparare) 
                FROM RETETA
            )
    ) lungime_prep_reteta
    JOIN DETALII_VANZARE dv ON lungime_prep_reteta.id_produs = dv.id_produs
)
ORDER BY c.id_cofetarie;


-----

--- Cererea 4: S? se afi?eze pentru fiecare produs în fun?tie de valoarea calorica daca este S?natos(sub 100 de kcal), Moderat caloric(intre 100 ?i 300 de kcal) ?i 
---Bogat în calorii(peste 300 de kcal). Se va specfifca ?i daca produsul este unul cu ciocolata ?i dac? este sub sau peste media caloric? a tuturor produselor.
---utilizarea a cel pu?in 1 bloc de cerere (clauza WITH), func?ie grup AVG, func?ie pe ?iruri de caractere UPPER,utilizarea a cel pu?in unei expresii CASE 
WITH ClasificareProduse AS (
    SELECT 
        p.id_produs,
        p.nume,
        inf.valoare_calorica,
        CASE
            WHEN inf.valoare_calorica <= 100 THEN 'Sanatos'
            WHEN inf.valoare_calorica <= 300 THEN 'Moderat caloric'
            ELSE 'Bogat în calorii'
        END AS categorie_calorii,
        CASE
            WHEN UPPER(p.nume) LIKE '%CIOCOLATA%' THEN 'Contine ciocolata'
            ELSE 'Nu contine ciocolata'
        END AS contine_ciocolata
    FROM PRODUSE p
    JOIN INFORMATII_NUTRITIONALE inf ON p.id_produs = inf.id_produs
)
SELECT 
 cp.nume,
 cp.valoare_calorica,
 cp.categorie_calorii,
 NVL(cp.contine_ciocolata, 'Informatie indisponibila') AS contine_ciocolata,
   CASE
    WHEN cp.valoare_calorica < (SELECT AVG(valoare_calorica) FROM INFORMATII_NUTRITIONALE) THEN 'Sub media calorica'
    WHEN cp.valoare_calorica = (SELECT AVG(valoare_calorica) FROM INFORMATII_NUTRITIONALE) THEN 'Egal cu media calorica'
    ELSE 'Peste media caloric?'
 END AS comparatie_cu_media
FROM ClasificareProduse cp
ORDER BY cp.nume;
---------------


--Cererea 5: S? se afi?eze id-ul, numele ?i data expir?riii garan?iei ustensilelor folosite de angaja?ii care lucreaz? la cofet?rii care vând cel pu?in un produs
-- care are scorul de s?n?tate(se calculeaz? din suma valoruu calorice ?i a cantita?ii de grasimi pe 100) mai mare decât media scorului de s?n?tate al produselor 
--vândute
--Am folosit filtrare la nivel de grupuri cu subcereri nesincronizate (în clauza de HAVING) în care intervin cel pu?in 3 tabele (in cadrul aceleia?i cereri) 
--(DETALII_VANZARE, INFORMATII_NUTRITIONALE, COFETARII), func?ie grup AVG, grupare de date cu GROUP BY 

SELECT u.id_ustensila, u.data_expirarii_garantiei, u.nume_ustensila
FROM USTENSILE u
INNER JOIN DETALII_USTENSILE du ON u.id_ustensila = du.id_ustensila
INNER JOIN ANGAJATI a ON du.id_angajat = a.id_angajat
INNER JOIN COFETARII c ON a.id_cofetarie = c.id_cofetarie
INNER JOIN DETALII_VANZARE dv ON c.id_cofetarie = dv.id_cofetarie
INNER JOIN INFORMATII_NUTRITIONALE inf ON dv.id_produs = inf.id_produs
GROUP BY u.id_ustensila, u.data_expirarii_garantiei, u.nume_ustensila
HAVING AVG(inf.valoare_calorica + inf.cant_grasimi) / 100 > (
    SELECT AVG(scor_sanatate)
    FROM (
        SELECT AVG(inf1.valoare_calorica + inf1.cant_grasimi) / 100 AS scor_sanatate
        FROM DETALII_VANZARE dv1
        INNER JOIN INFORMATII_NUTRITIONALE inf1 ON dv1.id_produs = inf1.id_produs
        INNER JOIN COFETARII c1 ON dv1.id_cofetarie = c1.id_cofetarie
        GROUP BY c1.id_cofetarie
    ) 
);
-----------
---Ex 13:
---1.?tergerea înregistr?rilor din tabela COMENZI pentru comenzile care au fost livrate unui eveniment care a fost finalizat.

DELETE FROM COMENZI
WHERE id_eveniment IN (
    SELECT id_eveniment
    FROM EVENIMENTE
    WHERE stare_eveniment = 'finalizat'
);

---2.?tergerea înregistr?rilor din tabela INGREDIENTE pentru ingredientele care au expirat.
DELETE FROM INGREDIENTE
WHERE id_ingredient IN (
    SELECT id_ingredient
    FROM INGREDIENTE
    WHERE data_expirare < TRUNC(SYSDATE)
);

---3.Actualizarea tabelului RETETA astfel incat, re?eta s? fie usoara dac? timpul de preparare este mai mic de 45 de minute, medie dac? timpul de preparare este
---între 45 ?i 90 de minute ?i dificila dac? timpul de preparare este peste 90 de minute.
UPDATE RETETA
SET dificultate = (
    CASE
        WHEN timp_preparare < 45 THEN 'usor'
        WHEN timp_preparare BETWEEN 45 AND 90 THEN 'mediu'
        ELSE 'dificil'
    END
)
WHERE timp_preparare IS NOT NULL;


--------


-----Cererea 3: Afi?a?i id-ul, num?rul de telefon ?i adresa de mail pentru cofet?riile care vând cel pu?in un produs care are o promo?ie care dureaz? mai mult de doua
----luni ?i ale c?ror re?ete au un timp de preparare mai mare decat media.
---Am folosit o subcerere nesincronizat? în clauza FROM, o func?ie pe date calendaristice(MONTHS_BETWEEN), ordonare folosind ORDER BY 
SELECT 
    c.id_cofetarie, 
    c.numar_de_telefon, 
    c.adresa_mail
FROM COFETARII c
WHERE c.id_cofetarie IN (
    SELECT DISTINCT dv.id_cofetarie 
    FROM DETALII_VANZARE dv
    JOIN PROMOTII p ON dv.id_produs = p.id_produs
    WHERE MONTHS_BETWEEN(p.data_sfarsit, p.data_inceput) > 2
)
AND c.id_cofetarie IN (
    SELECT dv.id_cofetarie
    FROM (
        SELECT 
            r.id_produs
        FROM 
            RETETA r
        WHERE 
            r.timp_preparare > (
                SELECT AVG(timp_preparare) 
                FROM RETETA
            )
    ) lungime_prep_reteta
    JOIN DETALII_VANZARE dv ON lungime_prep_reteta.id_produs = dv.id_produs
)
ORDER BY c.id_cofetarie;


-----Ex 14: Vizualizare
CREATE VIEW Vizualizare_Performanta_Angajati AS
SELECT id_angajat, nume, prenume, salariu, numar_ore_lucru_zi, 
       DECODE(
           SIGN(salariu - 3000) + SIGN(numar_ore_lucru_zi - 8),
           2, 'Performan?? excelent?',
           1, 'Performan?? bun?',
           0, 'Performan?? medie',
           -1, 'Performan?? sub medie'
       ) AS nivel_performanta
FROM ANGAJATI;

SELECT *
FROM Vizualizare_Performanta_Angajati;

---Operatie LMD nepermisa
UPDATE Vizualizare_Performanta_Angajati
SET nivel_performanta = 'Performan?? bun?'
WHERE id_angajat = 10;

---Operatie LMD permisa
UPDATE Angajati
SET salariu = salariu * 1.1
WHERE id_angajat IN (
    SELECT id_angajat
    FROM Vizualizare_Performanta_Angajati
    WHERE nivel_performanta = 'Performan?? bun?'
);


SELECT id_angajat, nume, prenume, salariu, numar_ore_lucru_zi, Performanta_Angajat(salariu, numar_ore_lucru_zi) AS nivel_performanta
FROM ANGAJATI;


-----ex.15.Sa se afiseze id-ul, nunele, adresa si adresa de email a primilor 3 furnizori care colaboreaza cu o cofetarei care vinde cel putin un produs 
---care are pretul mai mare decat pretul mediu.
SELECT F.id_furnizor, F.nume, F.adresa, F.adresa_mail
FROM FURNIZOR F
JOIN COFETARII C ON F.id_cofetarie = C.id_cofetarie
JOIN DETALII_VANZARE DV ON C.id_cofetarie = DV.id_cofetarie
JOIN PRODUSE P ON DV.id_produs = P.id_produs
WHERE P.pret > (SELECT AVG(pret) FROM produse)
GROUP BY F.id_furnizor, F.nume, F.adresa, F.adresa_mail, ROWNUM
HAVING ROWNUM <= 3;

-----15. S? se afi?eze numele ?i id-ul tuturor produselor care se afla înnr-o  comanda în care e asociat? o firm? de livrare care are pretul de livrare mai mare decât
---cel mediu. (DIVISION)

SELECT DISTINCT p.nume, p.id_produs
FROM PRODUSE p
WHERE NOT EXISTS (
    SELECT *
    FROM COMENZI c
    WHERE c.id_produs = p.id_produs
    AND NOT EXISTS (
        SELECT *
        FROM FIRMA_LIVRARE fl
        WHERE fl.id_firma_livrare = c.id_firma_livrare
        AND fl.pret_livrare >= (
            SELECT AVG(pret_livrare)
            FROM FIRMA_LIVRARE
        )
    )
);

     
SELECT nume, id_firma_livrare
FROM FIRMA_LIVRARE
WHERE pret_livrare >= (SELECT AVG(pret_livrare) FROM FIRMA_LIVRARE);
 


SELECT *
FROM COFETAR;
        
---------
----15.Sa se afiseze numele, prenumele, experienta de lucru(pote fi null daca cofetarul nu a lucrat cel puin un an), reteta de specialitzte ale cofetarilor
----care lucreaz? la o cofetarie care vinde cel pu?in un produs care con?ine lapte. De asemenea se va afi?a ?i numele produsului vândut si adresa de email
----a cofet?riei respective.
SELECT 

    a.nume AS nume_angajat,
    a.prenume AS prenume_angajat,
    c.experienta_lucru,
    c.reteta_specialitate,
    p.nume AS nume_produs,
    cft.adresa_mail
FROM 
    COFETAR c
LEFT JOIN 
    ANGAJATI a ON c.id_angajat = a.id_angajat
LEFT JOIN 
    COFETARII cft ON a.id_cofetarie = cft.id_cofetarie
LEFT JOIN 
    DETALII_VANZARE dv ON cft.id_cofetarie = dv.id_cofetarie
LEFT JOIN 
    PRODUSE p ON dv.id_produs = p.id_produs
LEFT JOIN 
    DETALII_COMPOZITIE dc ON p.id_produs = dc.id_produs
LEFT JOIN 
    INGREDIENTE i ON dc.id_ingredient = i.id_ingredient
WHERE 
    i.nume = 'Lapte';


---Ex 17
SELECT DISTINCT u.id_ustensila
FROM ANGAJATI a
JOIN DETALII_USTENSILE du ON a.id_angajat = du.id_angajat
JOIN USTENSILE u ON du.id_ustensila = u.id_ustensila
WHERE a.tip_angajat = 'cofetar';

---Ex 16
SELECT DISTINCT p.nume
FROM PRODUSE p, INGREDIENTE i
WHERE (p.id_produs, i.id_ingredient) IN 
    (SELECT dc.id_produs, dc.id_ingredient
     FROM DETALII_COMPOZITIE dc, INGREDIENTE i 
     WHERE dc.id_ingredient = i.id_ingredient
     AND i.pret > 4);

SELECT DISTINCT p.nume
FROM PRODUSE p
JOIN DETALII_COMPOZITIE dc ON p.id_produs = dc.id_produs
JOIN INGREDIENTE i ON dc.id_ingredient = i.id_ingredient
WHERE i.pret > 4;




