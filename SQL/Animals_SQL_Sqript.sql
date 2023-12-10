-- 7. В подключенном MySQL репозитории создать базу данных “Друзья человека”
-- 8. Создать таблицы с иерархией из диаграммы в БД
-- 9. Заполнить низкоуровневые таблицы именами(животных), командами которые они выполняют и датами рождения

CREATE SCHEMA `people_friends` ;

USE peoplefriends;

CREATE TABLE cat (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE dog (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE hamster (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE horse (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE camel (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

CREATE TABLE donkey (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE
);

INSERT INTO cat (animal_name, commands, date_of_birth) VALUES 
	('Boris', 'meow, sit', '2019-02-06'),
	('Ryzik', 'meow, stand', '2015-10-10'),
	('Bob', 'meow', '2020-05-29');
   
INSERT INTO dog (animal_name, commands, date_of_birth) VALUES 
	('Beckham,', 'woof, sit, stand, give hand', '2022-08-22'),
	('Jordan', 'woof, sit, stand, give hand', '2022-06-16'),
    ('baton', 'sit', '2018-02-28');
    
INSERT INTO hamster (animal_name, commands, date_of_birth) VALUES 
	('Jesus', 'sleep', '2020-08-15'),
	('Dead', 'eat', '2018-12-31'),
    ('Black', 'stay', '2023-01-01');
    
INSERT INTO horse (animal_name, commands, date_of_birth) VALUES 
	('Valera', 'nearby, gallop, sleep', '2020-01-01'),
	('Igor', 'nearby, gallop, eat', '2018-10-12'),
    ('Lightning', 'nearby, gallop', '2020-02-02');
    
INSERT INTO camel (animal_name, commands, date_of_birth) VALUES 
	('Pih', 'eat, sleep', '2023-01-02'),
	('Pux', 'eat', '2019-12-03'),
    ('Pip', 'stay', '2021-02-15');
    
INSERT INTO donkey (animal_name, commands, date_of_birth) VALUES 
	('Biba', 'nearby, sleep', '2023-05-01'),
	('Boba', 'nearby, eat', '2022-08-10'),
    ('Lupa', 'Come for a salary', '2018-05-21'),
    ('Pupa', 'Come for a salary', '2019-07-04');
   
-- 10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.

CREATE TABLE PackAnimals (
	animal_name CHAR(30),
	commands TEXT,
	date_of_birth DATE
);

TRUNCATE camel;

INSERT INTO packanimals (animal_name, commands, date_of_birth)
SELECT animal_name, commands, date_of_birth
FROM horse;

INSERT INTO packanimals (animal_name, commands, date_of_birth)
SELECT animal_name, commands, date_of_birth
FROM donkey;

-- 11.Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице

CREATE TABLE young_animal (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE,
    age INT
);

INSERT INTO young_animal (animal_name, commands, date_of_birth, age)
SELECT animal_name, commands, date_of_birth, YEAR(CURDATE()) - YEAR(date_of_birth)
FROM cat
WHERE YEAR(CURDATE()) - YEAR(date_of_birth) BETWEEN 1 AND 3;

INSERT INTO young_animal (animal_name, commands, date_of_birth, age)
SELECT animal_name, commands, date_of_birth, YEAR(CURDATE()) - YEAR(date_of_birth)
FROM dog 
WHERE YEAR(CURDATE()) - YEAR(date_of_birth) BETWEEN 1 AND 3;

INSERT INTO young_animal (animal_name, commands, date_of_birth, age)
SELECT animal_name, commands, date_of_birth, YEAR(CURDATE()) - YEAR(date_of_birth)
FROM hamster 
WHERE YEAR(CURDATE()) - YEAR(date_of_birth) BETWEEN 1 AND 3;

INSERT INTO young_animal (animal_name, commands, date_of_birth, age)
SELECT animal_name, commands, date_of_birth, YEAR(CURDATE()) - YEAR(date_of_birth)
FROM packanimals 
WHERE YEAR(CURDATE()) - YEAR(date_of_birth) BETWEEN 1 AND 3;

-- 12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.

CREATE TABLE animals (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date_of_birth DATE,
    age TEXT,
    animal_type ENUM('cat', 'dog', 'hamster', 'horse', 'donkey', 'camel') NOT NULL
);

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, YEAR(CURDATE()) - YEAR(date_of_birth), 'cat'
FROM cat;

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, YEAR(CURDATE()) - YEAR(date_of_birth), 'dog'
FROM dog;

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, YEAR(CURDATE()) - YEAR(date_of_birth), 'hamster'
FROM hamster;

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, YEAR(CURDATE()) - YEAR(date_of_birth), 'horse'
FROM horse;

INSERT INTO animals (animal_name, commands, date_of_birth, age, animal_type)
SELECT animal_name, commands, date_of_birth, YEAR(CURDATE()) - YEAR(date_of_birth), 'donkey'
FROM donkey;
