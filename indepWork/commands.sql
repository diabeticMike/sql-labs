CREATE TRIGGER CheckMinCores BEFORE INSERT ON processors
    FOR EACH ROW
    BEGIN
        IF(NEW.core = 0) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'can not add processor with 0 cores';
        end if;
    end;

CREATE TRIGGER CheckMatrix BEFORE INSERT ON monitors
    FOR EACH ROW
    BEGIN
        IF(NEW.matrix NOT IN ('IPS','LED')) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'nonexistent matrix';
        end if;
    end;

CREATE TRIGGER SetSmallMonitorPrice BEFORE INSERT ON monitors
    FOR EACH ROW
    BEGIN
        IF(NEW.diagonal < 13) THEN
            SET NEW.resolution = '800x400';
        end if;
    end;

CREATE PROCEDURE IndexAllPrices(IN coef double)
    UPDATE motherBoards SET price=price*coef;
    UPDATE memories SET price=price*coef;
    UPDATE processors SET price=price*coef;
    UPDATE monitors SET price=price*coef;
    UPDATE videoCards SET price=price*coef;

CREATE PROCEDURE CheckDoesSockedExist(IN sock varchar(20))
    SELECT NAME FROM motherBoards WHERE socket = sock;

CREATE PROCEDURE MinProcessorPrice(OUT MinPrice DECIMAL(8,2))
    SELECT MIN(price) FROM processors INTO MinStip;
    SELECT MinPrice;
