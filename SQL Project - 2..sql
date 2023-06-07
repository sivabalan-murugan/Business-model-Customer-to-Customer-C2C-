CREATE SCHEMA alumni;

USE alumni;
----- Q3. Run SQL command to see the structure of six tables -----

DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

----- Q6. Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. -----

CREATE VIEW college_a_hs_v AS
    SELECT 
        *
    FROM
        college_a_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL;

SELECT * FROM college_a_hs_v;

----- Q7. Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.-----

CREATE VIEW college_a_se_v AS
    SELECT 
        *
    FROM
        college_a_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL;

SELECT * FROM college_a_se_v;

----- Q8. Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.-----

CREATE VIEW college_a_sj_v AS
    SELECT 
        *
    FROM
        college_a_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL;

SELECT * FROM college_a_sj_v;

----- Q9. Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.-----

CREATE VIEW college_b_hs_v AS
    SELECT 
        *
    FROM
        college_b_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL;

SELECT * FROM college_b_hs_v;

----- Q10. Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values. -----

CREATE VIEW college_b_se_v AS
    SELECT 
        *
    FROM
        college_b_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL;
            
SELECT * FROM college_b_se_v;

----- Q11. Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.-----

CREATE VIEW college_b_sj_v AS
    SELECT 
        *
    FROM
        college_b_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
			AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL;

SELECT * FROM college_b_sj_v;

----- Q12. Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views -----

Delimiter $$
CREATE PROCEDURE lower_case() 
BEGIN
SELECT 
    LOWER(Name) Name,
    LOWER(FatherName) FatherName,
    LOWER(MotherName) MotherName
FROM
    college_a_hs_v 
UNION SELECT 
    LOWER(Name) Name,
    LOWER(FatherName) FatherName,
    LOWER(MotherName) MotherName
FROM
    college_a_se_v 
UNION SELECT 
    LOWER(Name) Name,
    LOWER(FatherName) FatherName,
    LOWER(MotherName) MotherName
FROM
    college_a_sj_v 
UNION SELECT 
    LOWER(Name) Name,
    LOWER(FatherName) FatherName,
    LOWER(MotherName) MotherName
FROM
    college_b_hs_v 
UNION SELECT 
    LOWER(Name) Name,
    LOWER(FatherName) FatherName,
    LOWER(MotherName) MotherName
FROM
    college_b_se_v 
UNION SELECT 
    LOWER(Name) Name,
    LOWER(FatherName) FatherName,
    LOWER(MotherName) MotherName
FROM
    college_b_sj_v;
END $$
Delimiter ;

CALL lower_case;

----- Q14. Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.-----


DELIMITER $$
CREATE PROCEDURE get_name_collegeA
(INOUT Namea MEDIUMTEXT) 

BEGIN

DECLARE finished INT DEFAULT 0;
DECLARE name1list TEXT (17000) DEFAULT "";

DECLARE namedetail 
CURSOR FOR
SELECT Name FROM college_a_hs UNION SELECT Name FROM college_a_se UNION SELECT Name FROM college_a_sj;

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET Finished = 1;

OPEN namedetail;

getfullname: 
LOOP
FETCH namedetail INTO name1list;
IF finished = 1 THEN 
LEAVE getfullname;
END IF;
SET Namea = CONCAT(name1list, " ; " , Namea);
END LOOP getfullname;
CLOSE namedetail;
END $$
DELIMITER $$;

SET @Namea = "";
CALL get_name_collegeA (@Namea);
SELECT @Namea College_A;

----- Q15. Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B. -----

DELIMITER $$
CREATE PROCEDURE get_name_collegeB 
(INOUT Name1 MEDIUMTEXT) 

BEGIN

DECLARE finished INT DEFAULT 0;
DECLARE namelist VARCHAR (400) DEFAULT "";

DECLARE namedetail1
CURSOR FOR
SELECT Name FROM college_b_hs UNION SELECT Name FROM college_b_se UNION SELECT Name FROM college_b_sj;

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET finished = 1;

OPEN namedetail1;

getfullnameb: 
LOOP
FETCH namedetail1 INTO namelist;
IF finished = 1 THEN 
LEAVE getfullnameb;
END IF;
SET Name1 = CONCAT(namelist, " ; " , Name1);
END LOOP getfullnameb;
CLOSE namedetail1;
END $$
DELIMITER $$;

SET @Name1 = "";
CALL get_name_collegeB (@Name1);
SELECT @Name1 College_B;

----- Q16. Calculate the percentage of career choice of College A and College B Alumni -----

SELECT 
    'HigherStudies',
    (SELECT 
            COUNT(*)
        FROM
            college_a_hs) / ((SELECT 
            COUNT(*)
        FROM
            college_a_hs) + (SELECT 
            COUNT(*)
        FROM
            college_a_se) + (SELECT 
            COUNT(*)
        FROM
            college_a_sj)) * 100 'College A Percentage',
    (SELECT 
            COUNT(*)
        FROM
            college_b_hs) / ((SELECT 
            COUNT(*)
        FROM
            college_b_hs) + (SELECT 
            COUNT(*)
        FROM
            college_b_se) + (SELECT 
            COUNT(*)
        FROM
            college_b_sj)) * 100 'College A Percentage'

UNION SELECT 
    'SelfEmployed',
    (SELECT 
            COUNT(*)
        FROM
            college_a_se) / ((SELECT 
            COUNT(*)
        FROM
            college_a_hs) + (SELECT 
            COUNT(*)
        FROM
            college_a_se) + (SELECT 
            COUNT(*)
        FROM
            college_a_sj)) * 100 'College A Percentage',
    (SELECT 
            COUNT(*)
        FROM
            college_b_se) / ((SELECT 
            COUNT(*)
        FROM
            college_b_hs) + (SELECT 
            COUNT(*)
        FROM
            college_b_se) + (SELECT 
            COUNT(*)
        FROM
            college_b_sj)) * 100 'College A Percentage'

UNION SELECT 
    'SelfEmployed',
    (SELECT 
            COUNT(*)
        FROM
            college_a_sj) / ((SELECT 
            COUNT(*)
        FROM
            college_a_hs) + (SELECT 
            COUNT(*)
        FROM
            college_a_se) + (SELECT 
            COUNT(*)
        FROM
            college_a_sj)) * 100 'College A Percentage',
    (SELECT 
            COUNT(*)
        FROM
            college_b_sj) / ((SELECT 
            COUNT(*)
        FROM
            college_b_hs) + (SELECT 
            COUNT(*)
        FROM
            college_b_se) + (SELECT 
            COUNT(*)
        FROM
            college_b_sj)) * 100 'College A Percentage';
