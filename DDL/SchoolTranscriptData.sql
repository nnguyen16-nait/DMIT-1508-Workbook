USE SchoolTranscript
GO

INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
Values ('Nelson', 'Nguyen', '20000202 08:20:00 PM', 1),
       ('Jim', 'Smith', '19990804 05:30:00 AM', 1)

INSERT INTO Students(GivenName, Surname, DateOfBirth)
Values ('Dawson', 'Creek', '19620705 11:40:00 PM')

SELECT * FROM Students