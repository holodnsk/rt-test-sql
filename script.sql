/*подготовка БД*/
CREATE DATABASE test;
USE test;

CREATE TABLE developers(
  developer_id INT AUTO_INCREMENT PRIMARY KEY ,
  name VARCHAR(100)
);
CREATE TABLE projects(
  project_id INT AUTO_INCREMENT PRIMARY KEY ,
  name VARCHAR(100)
);
CREATE TABLE dev_prj(
  dev_prj_id INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  developer_id INT NOT NULL ,
  project_id INT NOT NULL ,
  FOREIGN KEY (developer_id) REFERENCES developers(developer_id),
  FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO developers (name) VALUE ("dev0");
INSERT INTO developers (name) VALUE ("dev1");
INSERT INTO developers (name) VALUE ("dev2");
INSERT INTO developers (name) VALUE ("dev3");

INSERT INTO projects (name) VALUE ("proj0");
INSERT INTO projects (name) VALUE ("proj1");
INSERT INTO projects (name) VALUE ("proj2");
INSERT INTO projects (name) VALUE ("proj3");

INSERT INTO dev_prj (developer_id, project_id)  VALUES (1,1);
INSERT INTO dev_prj (developer_id, project_id)  VALUES (2,1);
INSERT INTO dev_prj (developer_id, project_id)  VALUES (3,1);

INSERT INTO dev_prj (developer_id, project_id)  VALUES (3,2);
INSERT INTO dev_prj (developer_id, project_id)  VALUES (4,2);

INSERT INTO dev_prj (developer_id, project_id)  VALUES (1,3);
INSERT INTO dev_prj (developer_id, project_id)  VALUES (2,3);
INSERT INTO dev_prj (developer_id, project_id)  VALUES (3,3);
INSERT INTO dev_prj (developer_id, project_id)  VALUES (4,3);

/*Задача 1
Вывести список проектов, в которых нет разработчиков*/
SELECT  projects.name
FROM projects
  LEFT JOIN dev_prj
    ON projects.project_id = dev_prj.project_id
WHERE dev_prj_id IS NULL;

/*Задача 2 
Вывести список проектов, в которых участвуют все разработчики*/
SELECT projects.name
FROM projects
WHERE project_id=(
  SELECT dev_prj.project_id
  FROM dev_prj
  GROUP BY project_id
  HAVING count(project_id)=(
    SELECT count(*)
    FROM developers
  )
);

/*задача3 
Вывести список проектов (с указанием количества разработчиков), в которых принимает
участие четное количество разработчиков и этих разработчиков больше, чем двое.*/
SELECT projects.name AS 'project',count(dev_prj.project_id) AS 'number of developers'
FROM projects
  LEFT JOIN dev_prj
    ON projects.project_id = dev_prj.project_id
GROUP BY dev_prj.project_id;
