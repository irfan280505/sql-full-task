CREATE DATABASE sql_casestudy;
USE sql_casestudy;

--drop
DROP TABLE Student;
DROP TABLE Course;
DROP TABLE Enrollment;

--student table
CREATE TABLE Student ( StudentID INT PRIMARY KEY IDENTITY(1, 1), FirstName VARCHAR(50) NOT NULL, LastName VARCHAR(50) NOT NULL, 
DateOfBirth DATE,  EnrollmentDate DATE);
INSERT INTO Student ( FirstName, LastName, DateOfBirth, EnrollmentDate) VALUES
( 'Alessia', 'Richard', '2000-01-15', '2022-08-20'), ( 'Briar', 'Barajas', '1999-05-22', '2022-08-20'), 
( 'Gabriella', 'Ochoa', '2001-11-30', '2022-08-20'), ( 'Heaven', 'Conner', '2000-01-15', '2022-08-20'), 
( 'Jedidiah', 'Foley', '1999-05-22', '2022-08-20'), ( 'Leonel', 'Marsh', '2001-11-30', '2022-08-20');
SELECT * FROM  Student;

--course table
CREATE TABLE Course ( CourseID INT PRIMARY KEY IDENTITY(101,1), CourseName VARCHAR(255), Credits INT );
INSERT INTO Course ( CourseName, Credits ) VALUES
( 'Cloud_Computing', 8), ( 'Data_Science', 9), ( 'Cyber_Security', 10),
( 'Data_Science', 9), ( 'Cloud_Computing', 8), ( 'Cyber_Security', 10);
SELECT * FROM Course;

--enrollment table
CREATE TABLE Enrollment ( EnrollmentID INT PRIMARY KEY, StudentID INT, CourseID INT, EnrollmentDate DATE,
FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
FOREIGN KEY (CourseID) REFERENCES Course(CourseID));
INSERT INTO Enrollment (EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, 101, '2022-01-01'), (2, 2, 102, '2022-01-15'), (3, 3, 101, '2022-01-01'),
(4, 4, 103, '2022-02-01'), (5, 5, 102, '2022-01-15'), (6, 6, 101, '2022-01-01');
SELECT * FROM Enrollment;

-- step 2
SELECT * FROM Student;

--step 3
SELECT s.* FROM Student s JOIN Enrollment e ON s.StudentID = e.StudentID JOIN Course c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Cloud_Computing';


--step 4
SELECT c.CourseName, COUNT(e.EnrollmentID) AS EnrollmentCount FROM Course c
JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;

--step 5
SELECT s.StudentID, s.FirstName, s.LastName, COUNT(e.CourseID) AS CourseCount FROM Student s 
JOIN Enrollment e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(e.CourseID) > 1;

--step 6
SELECT s.FirstName, s.LastName, e.EnrollmentDate FROM Student s JOIN Enrollment e ON s.StudentID = e.StudentID 
JOIN Course c ON e.CourseID = c.CourseID WHERE c.CourseName = 'Cyber_Security';

--step 7
SELECT s.* FROM Student s  JOIN Enrollment e1 ON s.StudentID = e1.StudentID JOIN Enrollment e2 ON s.StudentID = e2.StudentID 
JOIN Course c1 ON e1.CourseID = c1.CourseID JOIN Course c2 ON e2.CourseID = c2.CourseID
WHERE c1.CourseName = 'Cloud_Computing' AND c2.CourseName = 'Data_Science';

--step 8
SELECT COUNT(*) AS TotalEnrollments FROM Enrollment;