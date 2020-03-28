CREATE TABLE VYKLAD
(
    VNOM int NOT NULL,
    VFAM varchar(100),
    VIMA varchar(100),
    VOTCH varchar(100),
    KAF varchar(100),
    POSADA varchar(100),
    OKLAD DECIMAL(4,2),
    PRIMARY KEY (VNOM)
);

CREATE TABLE PREDMET
(
    PNOM int,
    PNAME varchar(100),
    VNOM int ,
    GOD int,
    SEMESTR int CHECK (SEMESTR >= 1 & SEMESTR <= 10),
    PRIMARY KEY (PNOM),
    FOREIGN KEY (VNOM)  REFERENCES VYKLAD (VNOM)
);

CREATE TABLE STUDENTS
(
    SNOM int NOT NULL,
    SFAM varchar(100),
    SIMA varchar(100),
    SOTCH varchar(100),
    STIP DECIMAL(10,2),
    GRUP varchar(100) DEFAULT 'ПМ-31',
    FORM ENUM('платна','бюджет'),
    FOTO BLOB,
    PRIMARY KEY (SNOM)
);

CREATE TABLE USPISH
(
    NOM int unsigned NOT NULL auto_increment,
    DATA DATE,
    SNOM int,
    PNOM int,
    OCINKA ENUM('1','2','3','4','5','NULL') DEFAULT 'NULL',
    PRIMARY KEY (NOM),
    FOREIGN KEY (SNOM) REFERENCES STUDENTS (SNOM),
    FOREIGN KEY (PNOM) REFERENCES PREDMET (PNOM)
);
