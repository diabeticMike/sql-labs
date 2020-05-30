CREATE TRIGGER InsertPreventTrigger BEFORE INSERT ON STUDENTS
    FOR EACH ROW 
    BEGIN
        IF((SELECT COUNT(*) FROM STUDENTS) >= 30) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'There is no place for new student';
        end if;
    end;

CREATE TRIGGER InsertSetStip BEFORE INSERT ON STUDENTS
    FOR EACH ROW
    BEGIN
        IF(NEW.FORM = 'бюджет') THEN
            SET NEW.STIP = 900;
        end if;
    end;

CREATE TRIGGER StudentFormException BEFORE INSERT ON STUDENTS
    FOR EACH ROW
    BEGIN
        IF(NEW.FORM NOT IN ('бюджет','платна')) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Study form is incorrect';
        end if;
    end;

CREATE TRIGGER CascadeRemoveUspishStudents BEFORE DELETE ON STUDENTS
    FOR EACH ROW
    BEGIN
        DELETE FROM USPISH WHERE SNOM = OLD.SNOM;
    end;

CREATE TRIGGER NullKeyBeforeRemovingPredmet BEFORE DELETE ON PREDMET
    FOR EACH ROW
    BEGIN
        UPDATE PREDMET SET PNOM = NULL WHERE PNOM = OLD.PNOM;
    end;

CREATE TRIGGER HelloBeforePredmetInsert BEFORE INSERT ON PREDMET
    FOR EACH ROW
    BEGIN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Hello Before';
    end;

CREATE TRIGGER UpdateVykladPredmet BEFORE DELETE ON VYKLAD
    FOR EACH ROW
    BEGIN
        UPDATE PREDMET SET VNOM = NULL WHERE VNOM = OLD.VNOM;
    end;

INSERT INTO PREDMET (PNOM, PNAME, VNOM, GOD, SEMESTR) VALUES
(312, 'Бази данних', 10001, 200, 6);
