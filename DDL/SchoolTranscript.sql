/* ********************
* File: SchoolTranscript.sql
* Author: Nelson Nguyen
*
* CREATE DATABASE SchoolTranscript
************************ */
USE SchoolTranscript
GO

/* ---- Drop Tables ---- */

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'StudentCourses')
    DROP TABLE StudentCourses
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Courses')
    DROP TABLE Courses  
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
    DROP TABLE Students

/* ---- Create Tables ---- */

CREATE TABLE Students
(
    -- Comma  -separated list of:
    -- Column-level and table-level definitions
    StudentID        int
        CONSTRAINT PK_STUDENTS_StudentID             
            PRIMARY KEY
            -- IDENTITY (INITIAL VALUE, INCREMENTS)
        IDENTITY(20200001,1)         NOT NULL,
    GivenName        varchar(50)     NOT NULL,
    Surname          varchar(50)
		CONSTRAINT CK_Student_Surname
--			CHECK (Surname LIKE '__%')     -- like allows us to do a "pattern-match, % is a wildcare for zero or more characters (letter digit, or other character, _is a wildcare for a single chracter (letter digit or other character, [] are used to represent a range or set of characters that are allowed
			CHECK (Surname LIKE '[a-z][a-z]%') -- two letters plus any other characters						 
									 NOT NULL,
    DateOfBirth      datetime
		CONSTRAINT CK_Students_DateOfBirth
			CHECK (DateOfBirth < GETDATE())
							         NOT NULL,
    Enrolled         bit             
        CONSTRAINT DF_Students_Enrolled -- DF = Default
            DEFAULT (1)              NOT NULL,   
)
CREATE TABLE Courses
(
    Number          varchar(10)     
        CONSTRAINT PK_COURSES_Number 
            PRIMARY KEY             NOT NULL,
    [Name]          varchar(10)     NOT NULL,
    Credits         decimal(3,1)
		CONSTRAINT CK_COURSES_Credits
			CHECK (Credits > 0)		NOT NULL,
    [Hours]         tinyint
		CONSTRAINT CK_COURSES_HOURS
			CHECK ([HOURS] BETWEEN 15 AND 100)
									NOT NULL,
    Active          bit             
        CONSTRAINT DF_COURSES_Active
            Default (1)             NOT NULL,
    Cost            money
		CONSTRAINT CK_COURSES_COST
			CHECK (COST > 0)        NOT NULL
)
CREATE TABLE StudentCourses
(
    StudentID       int            
        CONSTRAINT FK_StudentCourses_StudentID_Students_StudentID -- where the original primary key is
            FOREIGN KEY REFERENCES Students(StudentID) -- reference of where the original primary key is
                                    NOT NULL,
    CourseNumber    varchar(10)
        CONSTRAINT FK_CoursesNumber_Number_Courses_Number
            FOREIGN KEY REFERENCES Courses(Number)
                                    NOT NULL,
    [Year]          tinyint         NOT NULL,
    Term            char(3)         NOT NULL,
    FinalMarks      tinyint             NULL,
    [Status]        char(1)
		CONSTRAINT CK_StudentCourses_Status
			CHECK ([Status] = 'E' OR
				   [Status] = 'C' OR
				   [Status] = 'W')
			-- Check ([Status] IN ('E', 'C', 'W'))
--		CONSTRAINT DF_StudentCourses_Status
--			DEFAULT ('E')
							        NOT NULL,
    -- Table-level definition for Composite Primary Keys
    CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
        PRIMARY KEY (StudentID, CourseNumber)
)
/*ALTER TABLE Students
	ADD CONTSTRAINT CK_STUDENTS_PostalCode
		CHECK (POSTALCode LIKE '[A-Z][0-9]{A-Z][0-9][A-Z][0-9]')*/

ALTER TABLE StudentCourses
	ADD CONSTRAINT DF_StudentCourses_Status
		DEFAULT ('E') FOR [Status] -- In an alter Table statement the comumn must be specified for the default value
GO

/* -------------------------------- Odds and Ends-----------------------------*/
sp_help Students -- Get schema information for the students table

-- in a table, we can have some columns be 'calculated' or 'derived' columns
-- where the value of the column is a calculation from other columns
CREATE TABLE Invoice
(
	InvoiceID		int			NOT NULL,
	Subtotal		money		NOT NULL,
	GST				money		NOT NULL,
	Total			AS Subtotal + GST -- this is a computed column
)