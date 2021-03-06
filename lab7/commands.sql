CREATE PROCEDURE MinStip(IN GroupName VARCHAR(10), OUT MinStip DECIMAL (8,2))
    SELECT MIN(STIP) FROM STUDENTS WHERE GRUP = GroupName INTO MinStip;
    SELECT MinStip;

CREATE PROCEDURE MaxStip(IN GroupName VARCHAR(10))
    SELECT SFAM FROM STUDENTS WHERE STIP IN
                                    (SELECT MAX(STIP) FROM STUDENTS WHERE GRUP = GroupName);

CREATE PROCEDURE IndexStip(IN coef double)
    UPDATE STUDENTS SET STIP=STIP*coef;

CREATE PROCEDURE ShowStudByStip(IN stip DECIMAL(8,2))
    SELECT SFAM FROM STUDENTS WHERE STIP = stip;
