-- Active: 1729949546443@@127.0.0.1@5432@university_db



-- 1 Create a fresh database titled "university_db"
CREATE DATABASE university_db;

-- 2 Table Creation:
-- Create a "students" table with the following fields:
-- student_id (Primary Key): Integer, unique identifier for students.
-- student_name: String, representing the student's name.
-- age: Integer, indicating the student's age.
-- email: String, storing the student's email address.
-- frontend_mark: Integer, indicating the student's frontend assignment marks.
-- backend_mark: Integer, indicating the student's backend assignment marks.
-- status: String, storing the student's result status.

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INT CHECK (age > 0) NOT NULL,
    email VARCHAR(255) NOT NULL,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

-- 3 Create a "courses" table with the following fields:

-- course_id (Primary Key): Integer, unique identifier for courses.
-- course_name: String, indicating the course's name.
-- credits: Integer, signifying the number of credits for the course.
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits > 0) NOT NULL
);


-- 4 Create an "enrollment" table with the following fields:

-- enrollment_id (Primary Key): Integer, unique identifier for enrollments.
-- student_id (Foreign Key): Integer, referencing student_id in the "Students" table.
-- course_id (Foreign Key): Integer, referencing course_id in the "Courses" table.

CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
);


-- 5 Insert sample into the "students" table:
INSERT INTO students ( student_name, age, email, frontend_mark, backend_mark, status) VALUES 
    ( 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
    ( 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
    ( 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
    ( 'Rafi', 24, 'rafi@example.com', 41, 40, NULL),
    ( 'Sophia', 22, 'sophia@example.com', 50, 52, NULL),
    ( 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);


-- 6 Insert sample "courses" table:
INSERT INTO courses ( course_name, credits) VALUES 
    ( 'Next.js', 3),
    ( 'React.js', 4),
    ( 'Databases', 3),
    ( 'Prisma', 3);


-- 7 Insert sample data into "enrollment" table:
INSERT INTO enrollment ( student_id, course_id) VALUES 
    ( 1, 1),
    ( 1, 2),
    ( 2, 1),
    ( 3, 2);    


-- Query 1:
-- Insert a new student record :    
insert into students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Ferdous Alam', 35, 'bhaiparag@gmail.com', 50, 55, NULL);

-- Query 2:
-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT s.student_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';

-- Query 3:
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
-- Query 3:
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
    SELECT MAX(frontend_mark + backend_mark) FROM students
);

-- Query 4:
-- Delete all courses that have no students enrolled.

DELETE FROM courses
WHERE course_id NOT IN (
    SELECT course_id FROM enrollment
);

-- Query 5:
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name
FROM students
ORDER BY student_id
OFFSET 2 LIMIT 2;

-- Query 6:
-- Retrieve the course names and the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Query 7:
-- Calculate and display the average age of all students.
SELECT ROUND(AVG(age), 2) as average_age
FROM students;

-- Query 8:
-- Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';







