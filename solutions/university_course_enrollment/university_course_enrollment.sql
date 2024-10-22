-- 1. Create Tables

-- Students table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,                        -- Auto-incrementing primary key
    first_name VARCHAR(50),                       -- Student's first name
    last_name VARCHAR(50),                        -- Student's last name
    email VARCHAR(100) UNIQUE NOT NULL,           -- Student's email (must be unique and not null)
    school_enrollment_date DATE                   -- Date when the student enrolled
);

-- Professors table
CREATE TABLE professors (
    id SERIAL PRIMARY KEY,                        -- Auto-incrementing primary key
    first_name VARCHAR(50),                       -- Professor's first name
    last_name VARCHAR(50),                        -- Professor's last name
    department VARCHAR(100)                       -- Department the professor belongs to
);

-- Courses table
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,                        -- Auto-incrementing primary key
    course_name VARCHAR(100),                     -- Name of the course
    course_description TEXT,                      -- Description of the course
    professor_id INT,                             -- Foreign key referencing professors
    FOREIGN KEY (professor_id) REFERENCES professors(id)
);

-- Enrollments table (composite primary key)
CREATE TABLE enrollments (
    student_id INT,                               -- Foreign key referencing students
    course_id INT,                                -- Foreign key referencing courses
    enrollment_date DATE,                         -- Date of enrollment
    PRIMARY KEY (student_id, course_id),          -- Composite primary key
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- 2. Insert Data

-- Insert data into students
INSERT INTO students (first_name, last_name, email, school_enrollment_date)
VALUES
    ('Alice', 'Smith', 'alice.smith@example.com', '2022-09-01'),
    ('Bob', 'Johnson', 'bob.johnson@example.com', '2022-09-01'),
    ('Charlie', 'Williams', 'charlie.williams@example.com', '2023-01-15'),
    ('Diana', 'Brown', 'diana.brown@example.com', '2023-02-01'),
    ('Ethan', 'Davis', 'ethan.davis@example.com', '2023-03-01');

-- Insert data into professors
INSERT INTO professors (first_name, last_name, department)
VALUES
    ('John', 'Jones', 'Physics'),
    ('Joel', 'Miller', 'Mathematics'),
    ('Emily', 'Clark', 'Computer Science'),
    ('Paul', 'Walker', 'History');

-- Insert data into courses
INSERT INTO courses (course_name, course_description, professor_id)
VALUES
    ('Physics 101', 'Introduction to Physics', 1),
    ('Calculus I', 'Introduction to Differential Calculus', 2),
    ('History of Europe', 'Survey of European History', 4);

-- Insert data into enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES
    (1, 1, '2023-09-01'),  -- Alice in Physics 101
    (2, 1, '2023-09-01'),  -- Bob in Physics 101
    (3, 2, '2023-09-01'),  -- Charlie in Calculus I
    (4, 3, '2023-09-01'),  -- Diana in History of Europe
    (5, 1, '2023-09-02');  -- Ethan in Physics 101

-- 3. SQL Queries

-- Query 1: Retrieve the full names of all students enrolled in "Physics 101"
SELECT CONCAT(s.first_name, ' ', s.last_name) AS full_name
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE c.course_name = 'Physics 101';

-- Query 2: Retrieve a list of all courses along with the professor's full name
SELECT c.course_name, CONCAT(p.first_name, ' ', p.last_name) AS professor_name
FROM courses c
JOIN professors p ON c.professor_id = p.id;

-- Query 3: Retrieve all courses that have students enrolled in them
SELECT DISTINCT c.course_name
FROM courses c
JOIN enrollments e ON c.id = e.course_id;

-- 4. Update Data

-- Update Bob Johnson's email
UPDATE students
SET email = 'new_bob.johnson@example.com'
WHERE first_name = 'Bob' AND last_name = 'Johnson';

-- 5. Delete Data

-- Delete Ethan's enrollment from Physics 101
DELETE FROM enrollments
WHERE student_id = 5 AND course_id = 1;
