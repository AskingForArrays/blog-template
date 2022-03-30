USE master
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE NAME = 'blogtemplate')

BEGIN
	DROP DATABASE [blogtemplate]
	
	CREATE DATABASE [blogtemplate]

END

GO
	USE [blogtemplate]
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='user')
BEGIN
	CREATE TABLE user (
	  UserID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	  LastName varchar(30) DEFAULT NULL,
	  FirstName varchar(30) NOT NULL,
	  Username varchar(80) NOT NULL UNIQUE,
	  Password varchar(255) NOT NULL,
	  AccessLevel varchar(1) NOT NULL
	);
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='blog')
BEGIN
	CREATE TABLE dbo.blog (
	  BlogID int PRIMARY KEY NOT NULL IDENTITY,
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


IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='comment')
BEGIN
	CREATE TABLE comment (
	  CommentID int PRIMARY KEY NOT NULL IDENTITY,
	  Date datetime NOT NULL,
	  Username int FOREIGN KEY REFERENCES users (UserID) NOT NULL,
	  Textbox text NOT NULL,
	  BlogID int FOREIGN KEY REFERENCES blog (BlogID) NOT NULL
	);
END


INSERT INTO [user] ([LastName],[FirstName],[Username],[Password],[AccessLevel])
VALUES
  ('Mills','Kirsten','eleifend','BPF80NIJ5WJ','1'),
  ('Valentine','Yoshio','accumsan','JYR71ENW8KM','1'),
  ('Lawson','Mia','fermentum','HPQ26TMD3IW','2'),
  ('Cabrera','Wynter','Aliquam','BBM78CFY6TJ','2'),
  ('Snider','Stuart','urna,','NHF57NSZ7YU','1');


INSERT INTO [blog] ([Title],[Date],[UserID],[Textbox],[Picture1],[Picture2],[Picture3],[Picture4])
VALUES
  ('quis massa.','2022-07-18',1,'faucibus leo, in lobortis tellus justo sit amet nulla. Donec non justo. Proin non massa non ante bibendum ullamcorper. Duis cursus, diam at pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor dolor, tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec','EEX98XZB7CG','JOU73JVK8YI','OWB67OVP8VR','XVP04IDY8QK'),
  ('malesuada fringilla','2022-02-07',1,'semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae Phasellus ornare. Fusce mollis. Duis','ESQ93EWS7FI','WLS62UTO2OV','UKC34SVS1VM','MSS14ZAU9JO'),
  ('sem semper','2022-06-09',1,'tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor dolor, tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec dignissim magna a tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae Donec tincidunt. Donec vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper tellus id nunc interdum feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum eu, placerat eget, venenatis a, magna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam laoreet, libero et tristique pellentesque, tellus sem mollis dui, in sodales elit erat vitae risus. Duis a mi fringilla mi','NVH61JYL6BC','CJE72LJQ2XT','EVG66IGN2KM','HCB99RRI6TX'),
  ('ac, eleifend','2022-07-14',1,'Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget','TOR67PBZ4MA','TDF67EFM3JE','APH43NWV1SY','ISN89DQY7VL'),
  ('velit eget','2021-09-20',1,'ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum','CHH24MJN5TA','GXF84COR9IC','VAI15QNQ8VP','HJE88IIN1IV');

INSERT INTO comment([Date],[Username],[TextBox],[BlogID])
VALUES
  ('Sep 12, 2021',2,'Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue',1),
  ('Jan 31, 2023',3,'molestie tellus. Aenean egestas hendrerit neque. In ornare sagittis felis.',4),
  ('Apr 2, 2021',4,'et magnis dis parturient montes, nascetur ridiculus mus. Proin vel',6),
  ('Nov 5, 2022',2,'rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed',2),
  ('Feb 6, 2022',2,'dapibus id, blandit at, nisi. Cum sociis natoque penatibus et',2);
