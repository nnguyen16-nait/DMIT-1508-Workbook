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
            -- IDENTITY (INITIAL VALUE, INCREMENTS(
        IDENTITY(20200001,1)         NOT NULL,
    GivenName        varchar(50)     NOT NULL,
    Surname          varchar(50)     NOT NULL,
    DateOfBirth      datetime        NOT NULL,
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
    Credits         decimal(3,1)    NOT NULL,
    [Hours]         tinyint         NOT NULL,
    Active          bit             
        CONSTRAINT DF_COURSES_Active
            Default (1)             NOT NULL,
    Cost            money           NOT NULL
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
    FinalMarks      tinyint         NOT NULL,
    [Status]        char(1)         NOT NULL,
    -- Table-level definition for Composite Primary Keys
    CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
        PRIMARY KEY (StudentID, CourseNumber)
)