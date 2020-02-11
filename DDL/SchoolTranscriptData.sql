USE SchoolTranscript
GO

INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
Values ('Nelson', 'Nguyen', '20000202 08:20:00 PM', 1),
       ('Jim', 'Smith', '19990804 05:30:00 AM', 1)

INSERT INTO Students(GivenName, Surname, DateOfBirth)
Values ('Dawson', 'Creek', '19620705 11:40:00 PM')

SELECT * FROM Students -- using the * to identify all columnes is "Quick n Dirty'
-- in our select statements for this course we will avoid the use of *
-- marks will be deducted

SELECT Number, [Name], Credits, [Hours]
FROM Courses
WHERE [Name] LIKE '%fun%'
ORDER BY [Name]

-- Write a query to get the first/last names of all students 
-- whose lasy name startes with "H"

SELECT GivenName, Surname
FROM Students
WHERE SURNAME LIKE 'H%'