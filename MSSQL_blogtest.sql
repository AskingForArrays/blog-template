USE master
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE NAME = 'blogtemplate')
BEGIN
	CREATE DATABASE [blogtemplate]

END

GO
	USE [blogtemplate]
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='users')
BEGIN
	CREATE TABLE users (
	  UserID int PRIMARY KEY,
	  LastName varchar(30) DEFAULT NULL,
	  FirstName varchar(30) NOT NULL,
	  UserName varchar(80) NOT NULL,
	  Password varchar(255) NOT NULL,
	  AccessLevel varchar(1) NOT NULL
	);
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='blog')
BEGIN
	CREATE TABLE dbo.blog (
	  BlogID int PRIMARY KEY,
	  Title varchar(255) NOT NULL,
	  Date datetime NOT NULL,
	  UserID int FOREIGN KEY REFERENCES [users] (UserID) NOT NULL,
	  Textbox varchar(max) NOT NULL,
	  Picture1 varchar(255) NOT NULL,
	  Picture2 varchar(255) DEFAULT NULL,
	  Picture3 varchar(255) DEFAULT NULL,
	  Picture4 varchar(255) DEFAULT NULL,
	  
	);
END


IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='comments')
BEGIN
	CREATE TABLE comments (
	  CommentID int PRIMARY KEY,
	  Date datetime NOT NULL,
	  UserName int FOREIGN KEY REFERENCES users (UserID) NOT NULL,
	  Textbox text NOT NULL,
	  BlogID int FOREIGN KEY REFERENCES blog (BlogID) NOT NULL
	);
END


