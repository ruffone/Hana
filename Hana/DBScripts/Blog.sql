/****** Object:  Database [Hana]    Script Date: 12/10/2009 15:57:51 ******/
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbo].[sp_fulltext_database] @action = 'enable'
end
GO
/****** Object:  ForeignKey [FK_Categories_Posts_Categories]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Categories_Posts_Categories]') AND parent_object_id = OBJECT_ID(N'[dbo].[Categories_Posts]'))
ALTER TABLE [dbo].[Categories_Posts] DROP CONSTRAINT [FK_Categories_Posts_Categories]
GO
/****** Object:  ForeignKey [FK_Categories_Posts_Posts]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Categories_Posts_Posts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Categories_Posts]'))
ALTER TABLE [dbo].[Categories_Posts] DROP CONSTRAINT [FK_Categories_Posts_Posts]
GO
/****** Object:  ForeignKey [FK_Comments_Posts]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Comments_Posts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Comments]'))
ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_Comments_Posts]
GO
/****** Object:  ForeignKey [FK_Tags_Posts_Posts]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tags_Posts_Posts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tags_Posts]'))
ALTER TABLE [dbo].[Tags_Posts] DROP CONSTRAINT [FK_Tags_Posts_Posts]
GO
/****** Object:  ForeignKey [FK_Tags_Posts_Tags]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tags_Posts_Tags]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tags_Posts]'))
ALTER TABLE [dbo].[Tags_Posts] DROP CONSTRAINT [FK_Tags_Posts_Tags]
GO
/****** Object:  Table [dbo].[Categories_Posts]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories_Posts]') AND type in (N'U'))
DROP TABLE [dbo].[Categories_Posts]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Comments]') AND type in (N'U'))
DROP TABLE [dbo].[Comments]
GO
/****** Object:  UserDefinedFunction [dbo].[SearchPosts]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchPosts]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[SearchPosts]
GO
/****** Object:  Table [dbo].[Tags_Posts]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tags_Posts]') AND type in (N'U'))
DROP TABLE [dbo].[Tags_Posts]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tags]') AND type in (N'U'))
DROP TABLE [dbo].[Tags]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
DROP TABLE [dbo].[Categories]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 12/10/2009 15:57:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posts]') AND type in (N'U'))
DROP TABLE [dbo].[Posts]
GO
/****** Object:  FullTextCatalog [HanaCatalog]    Script Date: 12/10/2009 15:57:51 ******/
IF EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'HanaCatalog')
DROP FULLTEXT CATALOG [HanaCatalog]
GO
/****** Object:  FullTextCatalog [HanaCatalog]    Script Date: 12/10/2009 15:57:51 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'HanaCatalog')
CREATE FULLTEXT CATALOG [HanaCatalog]
AUTHORIZATION [dbo]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 12/10/2009 15:57:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Posts](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[Author] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PublishedOn] [datetime] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
	[Title] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CategorySlug] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Slug] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Body] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Tags] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Excerpt] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CommentCount] [int] NOT NULL,
	[IsPublished] [bit] NOT NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[Posts]'))
CREATE FULLTEXT INDEX ON [dbo].[Posts]
KEY INDEX [PK_Posts] ON [HanaCatalog]
WITH CHANGE_TRACKING AUTO
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/10/2009 15:57:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Slug] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 12/10/2009 15:57:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tags]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tags](
	[TagID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Slug] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[TagID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
/****** Object:  Table [dbo].[Tags_Posts]    Script Date: 12/10/2009 15:57:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tags_Posts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Tags_Posts](
	[TagID] [int] NOT NULL,
	[PostID] [int] NOT NULL,
 CONSTRAINT [PK_Tags_Posts] PRIMARY KEY CLUSTERED 
(
	[TagID] ASC,
	[PostID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO

/****** Object:  Table [dbo].[Comments]    Script Date: 12/10/2009 15:57:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Comments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Comments](
	[CommentID] [int] NOT NULL,
	[PostID] [int] NOT NULL,
	[Author] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IP] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[URL] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[Body] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ParentID] [int] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
/****** Object:  Table [dbo].[Categories_Posts]    Script Date: 12/10/2009 15:57:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories_Posts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Categories_Posts](
	[CategoryID] [int] NOT NULL,
	[PostID] [int] NOT NULL,
 CONSTRAINT [PK_Categories_Posts] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC,
	[PostID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
/****** Object:  ForeignKey [FK_Categories_Posts_Categories]    Script Date: 12/10/2009 15:57:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Categories_Posts_Categories]') AND parent_object_id = OBJECT_ID(N'[dbo].[Categories_Posts]'))
ALTER TABLE [dbo].[Categories_Posts]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Posts_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Categories_Posts_Categories]') AND parent_object_id = OBJECT_ID(N'[dbo].[Categories_Posts]'))
ALTER TABLE [dbo].[Categories_Posts] CHECK CONSTRAINT [FK_Categories_Posts_Categories]
GO
/****** Object:  ForeignKey [FK_Categories_Posts_Posts]    Script Date: 12/10/2009 15:57:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Categories_Posts_Posts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Categories_Posts]'))
ALTER TABLE [dbo].[Categories_Posts]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Posts_Posts] FOREIGN KEY([PostID])
REFERENCES [dbo].[Posts] ([PostID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Categories_Posts_Posts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Categories_Posts]'))
ALTER TABLE [dbo].[Categories_Posts] CHECK CONSTRAINT [FK_Categories_Posts_Posts]
GO
/****** Object:  ForeignKey [FK_Comments_Posts]    Script Date: 12/10/2009 15:57:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Comments_Posts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Comments]'))
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Posts] FOREIGN KEY([PostID])
REFERENCES [dbo].[Posts] ([PostID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Comments_Posts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Comments]'))
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Posts]
GO
/****** Object:  ForeignKey [FK_Tags_Posts_Posts]    Script Date: 12/10/2009 15:57:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tags_Posts_Posts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tags_Posts]'))
ALTER TABLE [dbo].[Tags_Posts]  WITH CHECK ADD  CONSTRAINT [FK_Tags_Posts_Posts] FOREIGN KEY([PostID])
REFERENCES [dbo].[Posts] ([PostID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tags_Posts_Posts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tags_Posts]'))
ALTER TABLE [dbo].[Tags_Posts] CHECK CONSTRAINT [FK_Tags_Posts_Posts]
GO
/****** Object:  ForeignKey [FK_Tags_Posts_Tags]    Script Date: 12/10/2009 15:57:51 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tags_Posts_Tags]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tags_Posts]'))
ALTER TABLE [dbo].[Tags_Posts]  WITH CHECK ADD  CONSTRAINT [FK_Tags_Posts_Tags] FOREIGN KEY([TagID])
REFERENCES [dbo].[Tags] ([TagID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Tags_Posts_Tags]') AND parent_object_id = OBJECT_ID(N'[dbo].[Tags_Posts]'))
ALTER TABLE [dbo].[Tags_Posts] CHECK CONSTRAINT [FK_Tags_Posts_Tags]
GO
