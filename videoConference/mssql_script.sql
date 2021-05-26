USE [master]
GO
/****** Object:  Database [smarwork]    Script Date: 2021-05-26 오후 1:35:21 ******/
CREATE DATABASE [smarwork]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'smarwork', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\smarwork.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'smarwork_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\smarwork_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [smarwork] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [smarwork].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [smarwork] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [smarwork] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [smarwork] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [smarwork] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [smarwork] SET ARITHABORT OFF 
GO
ALTER DATABASE [smarwork] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [smarwork] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [smarwork] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [smarwork] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [smarwork] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [smarwork] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [smarwork] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [smarwork] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [smarwork] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [smarwork] SET  ENABLE_BROKER 
GO
ALTER DATABASE [smarwork] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [smarwork] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [smarwork] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [smarwork] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [smarwork] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [smarwork] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [smarwork] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [smarwork] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [smarwork] SET  MULTI_USER 
GO
ALTER DATABASE [smarwork] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [smarwork] SET DB_CHAINING OFF 
GO
ALTER DATABASE [smarwork] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [smarwork] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [smarwork] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [smarwork] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [smarwork] SET QUERY_STORE = OFF
GO
USE [smarwork]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_ATTENTLIST]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[FN_ATTENTLIST] (@in_AttendList VARCHAR(30))
returns varchar(200)
begin
    DECLARE  @v_AttendList VARCHAR(50);
    

    SET @v_AttendList  = ( SELECT CASE WHEN ( (SELECT CHARINDEX(',' , @in_AttendList)) > 0) THEN 
                                              ( SELECT CONCAT((
											                   SELECT EMPNAME 
											                   FROM  TB_EMPINFO 
														       WHERE EMPNO = (SUBSTRING(@in_AttendList,1, CHARINDEX(',', @in_AttendList)))
															   ), '외', (LEN(@v_AttendList)-LEN(REPLACE(@v_AttendList,',',''))), '명')
                                               )
			                            ELSE 
			                              (SELECT EMPNAME FROM  TB_EMPINFO where EMPNO = @v_AttendList)
		                    END
							)

   

   RETURN @v_AttendList;


end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_AVAYAREQID]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create function [dbo].[FN_AVAYAREQID]()
 returns char(16)
 begin
  
   declare @RTN_AVAYREQID varchar(16);
   set    @RTN_AVAYREQID = ( 
							 SELECT CONCAT(format(getdate(),'yyyyMMddHHmmss') , ( select  CONCAT( REPLICATE('0', 2 - LEN( isnull(count(*),0) +1)), (isnull(count(*),0) +1))
                             FROM TB_AVAYASENDMESSAGE 
                             WHERE format( REQ_REGDATE,'yyyyMMddHHmmss') = format(getdate(),'yyyyMMddHHmmss')))
                           );
  return @RTN_AVAYREQID;

 end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_CENTERID]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_CENTERID] ()
returns CHAR(9)
as
begin

	 DECLARE @RTN_CENTERID char(9);
     
     set @RTN_CENTERID = (SELECT CONCAT('C',convert(varchar(8), getdate(),12) , ( select  CONCAT( REPLICATE('0', 2 - LEN( isnull(count(*),0) +1)), (isnull(count(*),0) +1))
                          FROM tb_centerinfo 
                          WHERE convert(varchar(8), CENTER_REGDATE,12) = convert(varchar(8), getdate(),12)))
						  )

     RETURN    @RTN_CENTERID;

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_DETAILCODENM]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_DETAILCODENM] (@AS_CODE varchar(30))
returns VARCHAR(60)
begin

    DECLARE @RTN_CDOENM VARCHAR(60);
    SET @RTN_CDOENM = (SELECT CODE_NM  FROM LETTCCMMNDETAILCODE WHERE CODE = @AS_CODE);
    RETURN @RTN_CDOENM;

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_DETAILCODENMETC]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_DETAILCODENMETC] (@AS_CODE varchar(30))
returns VARCHAR(60)
begin

    DECLARE @RTN_CDOENM VARCHAR(60);
    SET @RTN_CDOENM = (SELECT CODE  FROM LETTCCMMNDETAILCODE WHERE CODE_DC = @AS_CODE);
    RETURN @RTN_CDOENM;

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_DETAILCOODEID]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[FN_DETAILCOODEID]( @AS_parentCode varchar(20))
returns varchar(20)
begin

   declare @RTN_CODE VARCHAR(20);
   set @RTN_CODE = ( SELECT CONCAT (@AS_parentCode , '_' , 
                    isnull(  max(cast(REPLACE( code, CONCAT(@AS_parentCode,'_'), '') as int)),0) + 1) 
                    FROM  LETTCCMMNDETAILCODE WHERE CODE_ID = @AS_parentCode);

    RETURN @RTN_CODE;

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_FLOORNM]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create function  [dbo].[FN_FLOORNM]( @PLAY_FLOOR varchar(200))
 returns varchar(1200)
 begin
      DECLARE @v_floorTxt varchar(1000); 
	  SET @v_floorTxt = (SELECT STRING_AGG(FLOOR_NAME, ',') WITHIN GROUP(ORDER BY FLOOR_NAME) FLOOR_NAME
						 FROM tb_floorinfo 
						 WHERE FLOOR_SEQ IN (select dbo.UF_SPLICT(@PLAY_FLOOR, ','))
						 );
	  RETURN @v_floorTxt;


 end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_JOBNMFN_JOBNM]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[FN_JOBNMFN_JOBNM](@AS_ORGCODE varchar(30))
returns VARCHAR(60)
begin

    DECLARE @RTN_ORGNAME VARCHAR(60);
    SET @RTN_ORGNAME = (SELECT JOB_NM  FROM TB_JOB_INFO WHERE JOB_CD = @AS_ORGCODE);
    RETURN @RTN_ORGNAME;

end 

GO
/****** Object:  UserDefinedFunction [dbo].[FN_MEETINGID_INSERT]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create function [dbo].[FN_MEETINGID_INSERT](@AS_FLOORSEQ int, @AS_NUMBER int)
 returns varchar(18)
 begin
     
   DECLARE @flootInfo char(15);
   DECLARE @RTN_SEATID char(18);
   
   SET @flootInfo = (
				     SELECT CONCAT( CENTER_ID, '_', REPLICATE('0',3 - LEN( b.CODE_DC)) ,'_M')  
				     FROM TB_FLOORINFO a, LETTCCMMNDETAILCODE b
				     WHERE a.FLOOR_INFO = b.CODE 
				           AND FLOOR_SEQ = @AS_FLOORSEQ
   );
   SET @RTN_SEATID = (SELECT CONCAT(@flootInfo, REPLICATE('0', 3- LEN(@AS_NUMBER))));
   
   
  return @RTN_SEATID;

 end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_MEETINGNM]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create function [dbo].[FN_MEETINGNM] (@MEETINGID varchar(20))
 returns varchar(60) 
 begin

    declare @RTN_SEATNM VARCHAR(60);
    set @RTN_SEATNM = (SELECT ISNULL( MEETING_NAME , '타이틀없음')  FROM TB_MEETING_ROOM WHERE MEETING_ID = @MEETINGID);
    RETURN @RTN_SEATNM;

 end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_MESSAGECONTENT]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_MESSAGECONTENT] ( @as_code varchar(30))
returns VARCHAR(2000)
as
begin

   DECLARE @RTN_CDOENM VARCHAR(2000);
   SET @RTN_CDOENM = (SELECT isnull( MSG_CONTENT , '내용 없음' ) FROM TB_MESSAGEINFO WHERE MSG_SEQ = @as_code);
   RETURN @RTN_CDOENM; 

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_MESSAGETITLE]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_MESSAGETITLE] ( @as_code varchar(30))
returns VARCHAR(2000)
as
begin

   DECLARE @RTN_CDOENM VARCHAR(2000);
   SET @RTN_CDOENM = (SELECT isnull( MSG_TITLE , '내용 없음' ) FROM TB_MESSAGEINFO WHERE MSG_SEQ = @as_code);
   RETURN @RTN_CDOENM; 

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_NOIMAGEFN_NO]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_NOIMAGEFN_NO](@AS_imageNm varchar(30))
returns VARCHAR(30)
begin
     DECLARE @OT_IMAGEFILE VARCHAR(30);
	 SET @OT_IMAGEFILE = ( select case  when len(@AS_imageNm) > 0 then 
						               @AS_imageNm
						           else  
						               'no_image.gif'
						           end  );
	RETURN @OT_IMAGEFILE;
    

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_ORGNM]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_ORGNM] (@AS_ORGCODE varchar(30))
returns VARCHAR(60)
begin
    DECLARE @RTN_ORGNAME VARCHAR(60);
    SET @RTN_ORGNAME = (SELECT DEPTNAME  FROM tb_orginfo WHERE DEPTCODE = @AS_ORGCODE);
    RETURN @RTN_ORGNAME;

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_SEATID]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create function [dbo].[FN_SEATID] (@AS_FLOORSEQ int)
 returns varchar(17)
 begin

   declare @flootInfo char(14);
   declare @RTN_SEATID char(17);
   
   SET @flootInfo = (
				     SELECT CONCAT( CENTER_ID, '_', REPLICATE('0',3 - LEN( b.CODE_DC)) ,'_')  
				     FROM TB_FLOORINFO a, LETTCCMMNDETAILCODE b
				     WHERE a.FLOOR_INFO = b.CODE 
				          AND FLOOR_SEQ = @AS_FLOORSEQ
                     );
   SET @RTN_SEATID = (SELECT CONCAT(@flootInfo, 
                             REPLICATE('0',3 - LEN( ISNULL( cast( replace(MAX(SEAT_ID), @flootInfo, '') as int ) , 0)))
							 )
					  FROM TB_SEATINFO 
					  WHERE FLOOR_SEQ = @AS_FLOORSEQ
					 );
   
  return @RTN_SEATID;

 end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_UPSTIMEDOWN]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_UPSTIMEDOWN](@IN_ENDTIME varchar(30))
returns varchar(4)
as 
begin

     DECLARE @V_RETURN_ENDTIME VARCHAR(4);

	 
	 set @V_RETURN_ENDTIME = ( SELECT  CONCAT( REPLICATE('0', 4 - LEN( X.endTime)), X.endTime) 
							   FROM  (SELECT CASE when substring(@IN_ENDTIME ,3,2) = '30' then 
											  (@IN_ENDTIME + 100) - 30
										 ELSE 
											   @IN_ENDTIME + 30  
										 END endTime
									  )X
						      );

  
	  return   @V_RETURN_ENDTIME;

end 
GO
/****** Object:  UserDefinedFunction [dbo].[UF_SPLICT]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create  function [dbo].[UF_SPLICT] (@STRMORE AS VARCHAR(8000), @STRDELIMETER AS VARCHAR(10))

RETURNS  @RETURN_TABLE TABLE 
(
    idx int identity(1,1),
    strVALUE varchar(500)

)

as

BEGIN

declare    @NINDEX int, @DEL_LENGTH int,  @STRVALUE varchar(1000)

set @DEL_LENGTH = len(@STRDELIMETER)


while len(@STRMORE) > 0

          begin 

        
             SET @NINDEX = CHARINDEX(@STRDELIMETER, @STRMORE)

             IF (@NINDEX = 0 ) BEGIN

                INSERT @RETURN_TABLE (strVALUE) VALUES (@STRMORE)
            
             RETURN
          
             END 

             ELSE IF(@NINDEX = 1) BEGIN
    
             SET @STRMORE = SUBSTRING(@STRMORE, @DEL_LENGTH + 1, LEN(@STRMORE))

             CONTINUE 

             END 


             SET @STRVALUE = SUBSTRING(@STRMORE, 0, @NINDEX)
             SET @STRMORE = SUBSTRING(@STRMORE, @NINDEX + @DEL_LENGTH, LEN(@STRMORE) - @NINDEX )
             INSERT @RETURN_TABLE (strVALUE) VALUES (@STRVALUE)  


     end

RETURN

END 
GO
/****** Object:  Table [dbo].[COMTECOPSEQ]    Script Date: 2021-05-26 오후 1:35:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMTECOPSEQ](
	[TABLE_NAME] [varchar](20) NULL,
	[NEXT_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COMTNLOGINLOG]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMTNLOGINLOG](
	[LOG_ID] [char](20) NOT NULL,
	[CONECT_ID] [varchar](20) NULL,
	[CONECT_IP] [varchar](23) NULL,
	[CONECT_MTHD] [char](4) NULL,
	[ERROR_OCCRRNC_AT] [char](1) NULL,
	[ERROR_CODE] [char](3) NULL,
	[CREAT_DT] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LOG_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COMTNSYSLOG]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMTNSYSLOG](
	[REQUST_ID] [char](20) NOT NULL,
	[JOB_SE_CODE] [char](3) NULL,
	[OCCRRNC_DE] [char](8) NULL,
	[SRVC_NM] [varchar](200) NULL,
	[METHOD_NM] [varchar](200) NULL,
	[PROCESS_SE_CODE] [char](3) NULL,
	[PROCESS_CO] [int] NULL,
	[PROCESS_TIME] [varchar](10) NULL,
	[ERROR_SE] [char](1) NULL,
	[ERROR_CODE] [char](3) NULL,
	[ERROR_CO] [int] NULL,
	[RSPNS_CODE] [char](3) NULL,
	[INSTT_CODE] [char](7) NULL,
	[TRGET_MENU_NM] [varchar](200) NULL,
	[RQESTER_IP] [varchar](128) NULL,
	[RQESTER_ID] [varchar](20) NULL,
	[SQLID] [varchar](100) NULL,
	[SQL_PARAM] [text] NULL,
	[SQL_QUERY] [text] NULL,
	[METHOD_RESULT] [text] NULL,
	[OCCRRNC_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[REQUST_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IDS]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IDS](
	[TABLE_NAME] [varchar](20) NOT NULL,
	[NEXT_ID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LETTCCMMNCLCODE]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LETTCCMMNCLCODE](
	[CL_CODE] [char](3) NOT NULL,
	[CL_CODE_NM] [varchar](60) NULL,
	[CL_CODE_DC] [varchar](200) NULL,
	[USE_AT] [char](1) NULL,
	[FRST_REGIST_PNTTM] [datetime] NULL,
	[FRST_REGISTER_ID] [varchar](20) NULL,
	[LAST_UPDT_PNTTM] [datetime] NULL,
	[LAST_UPDUSR_ID] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LETTCCMMNCODE]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LETTCCMMNCODE](
	[CODE_ID] [varchar](20) NOT NULL,
	[CODE_ID_NM] [varchar](60) NULL,
	[CODE_ID_DC] [varchar](200) NULL,
	[USE_AT] [char](1) NULL,
	[CL_CODE] [char](3) NULL,
	[FRST_REGIST_PNTTM] [datetime] NULL,
	[FRST_REGISTER_ID] [varchar](20) NULL,
	[LAST_UPDT_PNTTM] [datetime] NULL,
	[LAST_UPDUSR_ID] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[CODE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LETTCCMMNDETAILCODE]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LETTCCMMNDETAILCODE](
	[CODE_ID] [varchar](20) NOT NULL,
	[CODE] [varchar](20) NOT NULL,
	[CODE_NM] [varchar](60) NULL,
	[CODE_DC] [varchar](200) NULL,
	[CODE_ETC1] [varchar](200) NULL,
	[CODE_ETC2] [varchar](200) NULL,
	[CODE_ETC3] [varchar](200) NULL,
	[USE_AT] [char](1) NULL,
	[FRST_REGIST_PNTTM] [datetime] NULL,
	[FRST_REGISTER_ID] [varchar](20) NULL,
	[LAST_UPDT_PNTTM] [datetime] NULL,
	[LAST_UPDUSR_ID] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LETTNAUTHORINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LETTNAUTHORINFO](
	[AUTHOR_CODE] [varchar](30) NOT NULL,
	[AUTHOR_NM] [varchar](60) NOT NULL,
	[AUTHOR_DC] [varchar](200) NULL,
	[AUTHOR_CREAT_DE] [char](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LETTNFILEDETAIL]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LETTNFILEDETAIL](
	[ATCH_FILE_ID] [char](20) NOT NULL,
	[FILE_STRE_COURS] [varchar](2000) NOT NULL,
	[STRE_FILE_NM] [varchar](255) NOT NULL,
	[ORIGNL_FILE_NM] [varchar](255) NULL,
	[FILE_EXTSN] [varchar](20) NOT NULL,
	[FILE_SIZE] [int] NULL,
	[CON_SEQ] [int] NULL,
	[FILE_ORDER] [int] NULL,
	[DETAIL_SEQ] [varchar](10) NULL,
	[FILE_THUMNAIL] [varchar](40) NULL,
	[PLAY_TIME] [varchar](20) NULL,
	[FILE_WIDTH] [varchar](10) NULL,
	[FILE_HEIGHT] [varchar](20) NULL,
	[USEYN] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ATCH_FILE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RTETCCODE]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RTETCCODE](
	[CODE_ID] [varchar](20) NULL,
	[CODE_NM] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RTETNAUTH]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RTETNAUTH](
	[MNGR_SE] [varchar](20) NULL,
	[URL] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_ADMIN]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_ADMIN](
	[ADMIN_ID] [varchar](20) NOT NULL,
	[ADMIN_NAME] [varchar](30) NULL,
	[ADMIN_PASSWORD] [varchar](255) NOT NULL,
	[EMP_NO] [varchar](10) NULL,
	[DEPT_ID] [varchar](20) NULL,
	[DEPT_NAME] [varchar](30) NULL,
	[ADMIN_EMAIL] [varchar](250) NULL,
	[ADMIN_TEL] [varchar](15) NULL,
	[REG_DATE] [datetime] NULL,
	[UPDATE_PASSWORD] [datetime] NULL,
	[ADMIN_LEVEL] [varchar](15) NULL,
	[LOCK_YN] [char](1) NULL,
	[USE_YN] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ADMIN_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_ATTENDANCE]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_ATTENDANCE](
	[RES_SEQ] [int] NOT NULL,
	[ATT_SEQ] [int] NOT NULL,
	[USER_ID] [varchar](20) NULL,
	[RES_DAY] [char](8) NULL,
	[ROOM_INTIME] [char](5) NULL,
	[ROOM_OTTIME] [char](5) NULL,
	[NOTIN_TIME] [char](5) NULL,
	[NOTOT_TIME] [char](5) NULL,
	[ATT_REGDATE] [datetime] NULL,
	[ATT_UPDATE] [datetime] NULL,
	[LOGIN] [datetime] NULL,
	[LOGOUT] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_AVAYASENDMESSAGE]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_AVAYASENDMESSAGE](
	[REQUESTID] [varchar](16) NOT NULL,
	[REQ_MESSAGE] [varchar](50) NOT NULL,
	[REQ_MESSAGE_TXT] [text] NULL,
	[RES_MESSAGE] [varchar](50) NULL,
	[RES_MESSAGE_TXT] [text] NULL,
	[REQ_REGDATE] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_BOARD]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_BOARD](
	[BOARD_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[BOARD_TITLE] [varchar](120) NULL,
	[BOARD_NOTICE_USEYN] [char](1) NULL,
	[BOARD_NOTICE_STARTDAY] [varchar](8) NULL,
	[BOARD_NOTICE_ENDDAY] [varchar](8) NULL,
	[BOARD_GUBUN] [char](3) NOT NULL,
	[BOARD_CONTENT] [text] NULL,
	[BOARD_RETURN_CONTENT] [text] NULL,
	[BOARD_REGDATE] [datetime] NULL,
	[BOARD_REG_ID] [varchar](30) NULL,
	[BOARD_UPDATE_DATE] [date] NULL,
	[BOARD_UPDATE_ID] [varchar](30) NULL,
	[BOARD_FILE01] [varchar](255) NULL,
	[BOARD_FILE02] [varchar](255) NULL,
	[BOARD_VIEW_YN] [char](1) NULL,
	[BOARD_FAQ_GUBUN] [varchar](20) NULL,
	[BOARD_VISITED] [int] NULL,
	[BOARD_TOP_SEQ] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[BOARD_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_CALENDER]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_CALENDER](
	[DATES] [char](8) NULL,
	[YEAR] [char](4) NULL,
	[MONTH] [char](2) NULL,
	[DAY] [char](2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_CENTERINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_CENTERINFO](
	[CENTER_ID] [char](9) NOT NULL,
	[CENTER_NM] [varchar](30) NULL,
	[CENTER_ZIPCODE] [char](7) NULL,
	[CENTER_ADDR1] [varchar](200) NULL,
	[CENTER_ADDR2] [varchar](200) NULL,
	[CENTER_TEL] [varchar](15) NULL,
	[CENTER_FAX] [varchar](15) NULL,
	[CENTER_USER_ID] [varchar](30) NULL,
	[CENTER_REGDATE] [datetime] NULL,
	[CENTER_UPDATE_USER_ID] [varchar](30) NULL,
	[CENTER_UPDATE_DATE] [datetime] NULL,
	[CENTER_IMG] [varchar](50) NULL,
	[CENTER_URL] [varchar](250) NULL,
	[CENTER_SEAT_IMG] [varchar](50) NULL,
	[CENTER_USE_YN] [char](1) NOT NULL,
	[REST_INFO] [varchar](1200) NULL,
	[MEETINGROOM_INFO] [varchar](1200) NULL,
	[CENTER_INFO] [text] NULL,
	[ADMIN_APPROVAL_YN] [char](1) NULL,
	[FLOOR_INFO] [varchar](50) NULL,
	[START_FLOOR] [varchar](30) NULL,
	[END_FLOOR] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[CENTER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_COMPANYINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_COMPANYINFO](
	[COM_CODE] [char](10) NOT NULL,
	[COM_NUMBER] [varchar](20) NULL,
	[COM_NAME] [varchar](20) NULL,
	[COM_GUBUN] [varchar](30) NULL,
	[COM_BUSCONDITION] [varchar](250) NULL,
	[COM_ITEM] [varchar](250) NULL,
	[COM_CEO_NAME] [varchar](30) NULL,
	[COM_TEL] [varchar](15) NULL,
	[COM_FAX] [varchar](15) NULL,
	[COM_ZIPCODE] [varchar](7) NULL,
	[COM_ADDR1] [varchar](250) NULL,
	[COM_ADDR2] [varchar](250) NULL,
	[COM_HOMEPAGE] [varchar](250) NULL,
	[COM_STATE] [varchar](30) NULL,
	[COM_LOGO] [varchar](50) NULL,
	[CENTER_ID] [char](9) NOT NULL,
	[FLOOR_SEQ] [int] NOT NULL,
	[TENN_USEYN] [char](1) NULL,
	[COM_PLAY_FLOOR] [varchar](20) NULL,
	[COM_REGDATE] [datetime] NULL,
	[COM_REGID] [varchar](30) NULL,
	[COM_UPDATE] [datetime] NULL,
	[COM_UPDATEID] [varchar](30) NULL,
	[COM_MEMO] [text] NULL,
 CONSTRAINT [PK__TB_COMPA__5EC42AD2F41A0E32] PRIMARY KEY CLUSTERED 
(
	[COM_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_COMPAY_TENNANT]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_COMPAY_TENNANT](
	[TENN_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[COM_CODE] [char](10) NULL,
	[TENN_REC_DATE] [datetime] NULL,
	[TENN_REC_COUNT] [int] NULL,
	[TENN_REC_PLAY_CNT] [int] NULL,
	[TENN_REC_NOW_CNT] [int] NULL,
	[TENN_REC_END] [varchar](20) NULL,
	[TENN_REMARK] [varchar](1200) NULL,
	[REG_ID] [datetime] NULL,
	[REG_DATE] [varchar](30) NULL,
	[UPDATE_ID] [datetime] NULL,
	[UPDATE_DATE] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[TENN_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_COMPAY_TENNANT_HISTORY]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_COMPAY_TENNANT_HISTORY](
	[HIS_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[COM_CODE] [char](10) NULL,
	[TENN_SEQ] [int] NOT NULL,
	[REG_ID] [varchar](30) NULL,
	[REG_DATE] [datetime] NULL,
	[TENN_CNT] [int] NULL,
	[TENN_PLAY_GUBUN] [varchar](30) NULL,
	[TENN_APPRIVAL] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[HIS_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_DEVICEINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_DEVICEINFO](
	[DEVICE_ID] [char](15) NOT NULL,
	[DEVICE_NM] [varchar](30) NULL,
	[DEVICE_IP] [varchar](20) NULL,
	[DEVICE_MAC] [varchar](20) NULL,
	[DEVICE_URL] [varchar](200) NULL,
	[DEVICE_OS] [varchar](30) NULL,
	[DEVICE_STARTTIME] [varchar](5) NULL,
	[DEVICE_ENDTIME] [varchar](5) NULL,
	[DEVICE_STATUS] [varchar](30) NULL,
	[USE_YN] [char](1) NULL,
	[MEETING_ID] [varchar](20) NULL,
	[CENTER_ID] [char](9) NULL,
	[FLOOR_SEQ] [int] NULL,
	[PART_SEQ] [int] NULL,
	[REG_ID] [varchar](30) NULL,
	[REG_DATE] [datetime] NULL,
	[UPDATE_ID] [varchar](30) NULL,
	[UPDATE_DATE] [datetime] NULL,
	[DEVICE_REMARK] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[DEVICE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_EMPINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_EMPINFO](
	[EMPID] [varchar](20) NULL,
	[EMPNO] [varchar](30) NULL,
	[EMPNAME] [varchar](10) NULL,
	[DEPTNAME] [varchar](30) NULL,
	[DEPTCODE] [varchar](10) NULL,
	[EMPGARD] [varchar](15) NULL,
	[EMPGARDCODE] [varchar](20) NULL,
	[EMPJIKW] [varchar](20) NULL,
	[EMPJIKWCODE] [varchar](20) NULL,
	[EMPHANDPHONE] [varchar](15) NULL,
	[EMPTELPHONE] [varchar](15) NULL,
	[EMPMAIL] [varchar](255) NULL,
	[ADMIN_GUBUN] [varchar](20) NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
	[AVAYA_USERID] [varchar](30) NULL,
	[DT_COENT] [varchar](8) NULL,
	[CD_LVLGRD] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_EQUIPMENTINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_EQUIPMENTINFO](
	[EQUP_CODE] [char](15) NOT NULL,
	[EQUIPMENT_ID] [varchar](15) NOT NULL,
	[EQUIPMENT_NAME] [varchar](20) NOT NULL,
	[CENTER_ID] [varchar](15) NOT NULL,
	[EQUP_SEIAL] [varchar](30) NULL,
	[SWC_SEQ] [int] NULL,
	[USER_ID] [varchar](20) NULL,
	[REG_DATE] [datetime] NULL,
	[COMPANY] [varchar](50) NULL,
	[REMARK] [varchar](2000) NULL,
	[EQUP_INDATE] [datetime] NOT NULL,
	[EQUP_OTDATE] [datetime] NULL,
	[USE_YN] [char](1) NULL,
	[EQUIP_STATE] [varchar](30) NULL,
	[EQUIP_IMG] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EQUP_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_FLOORINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_FLOORINFO](
	[FLOOR_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[CENTER_ID] [char](9) NOT NULL,
	[FLOOR_INFO] [varchar](30) NULL,
	[FLOOR_MAP] [varchar](50) NULL,
	[FLOOR_MAP1] [varchar](50) NULL,
	[FLOOR_NAME] [varchar](50) NULL,
	[SEAT_CNT] [int] NULL,
	[MEET_CNT] [int] NULL,
	[FLOOR_USEYN] [char](1) NULL,
	[FLOOR_PART] [varchar](30) NULL,
	[REG_DATE] [datetime] NULL,
	[REG_ID] [varchar](30) NULL,
	[UPDATE_DATE] [datetime] NULL,
	[UPDATE_ID] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[FLOOR_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_FLOORPART]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_FLOORPART](
	[PART_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[CENTER_ID] [char](9) NOT NULL,
	[FLOOR_SEQ] [int] NULL,
	[PART_MAP1] [varchar](50) NULL,
	[PART_MAP2] [varchar](50) NULL,
	[PART_CSS] [varchar](50) NULL,
	[PART_NAME] [varchar](50) NULL,
	[PART_SEATRULE] [varchar](10) NULL,
	[PART_MINI_CSS] [varchar](50) NULL,
	[PART_MINI_TOP] [int] NULL,
	[PART_MINI_LEFT] [int] NULL,
	[PART_USEYN] [char](1) NULL,
	[PART_ORDER] [int] NULL,
	[REG_DATE] [datetime] NULL,
	[REG_ID] [varchar](30) NULL,
	[UPDATE_DATE] [datetime] NULL,
	[UPDATE_ID] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[PART_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_JOBINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_JOBINFO](
	[EMPJIKW] [varchar](30) NULL,
	[EMPJIKWCODE] [varchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_MEETING_ROOM]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_MEETING_ROOM](
	[MEETING_ID] [char](18) NOT NULL,
	[MEETING_NAME] [varchar](50) NULL,
	[CENTER_ID] [char](9) NULL,
	[FLOOR_SEQ] [int] NULL,
	[PART_SEQ] [int] NULL,
	[ROOM_TYPE] [varchar](30) NULL,
	[MAX_CNT] [int] NULL,
	[MEETING_USEYN] [char](1) NULL,
	[MEETING_EQUPGUBUN] [varchar](30) NULL,
	[MEETING_IMG1] [varchar](50) NULL,
	[MEETING_IMG2] [varchar](50) NULL,
	[MEETING_CONFIRMGUBUN] [varchar](30) NULL,
	[MEETING_ADMINID] [varchar](30) NULL,
	[AVAYA_USERID] [varchar](30) NULL,
	[AVAYA_CONFI_ID] [varchar](30) NULL,
	[TERMINAL_ID] [varchar](10) NULL,
	[END_NAME] [varchar](10) NULL,
	[TERMINAL_NUMBER] [varchar](10) NULL,
	[TERMINAL_TEL] [varchar](20) NULL,
	[USER_FIRST_NM] [varchar](50) NULL,
	[USER_LAST_NM] [varchar](50) NULL,
	[USER_EMAIL] [varchar](250) NULL,
	[MEETING_VIEW] [char](1) NULL,
	[MEETING_MAINVIEW] [char](1) NULL,
	[MEETING_ORDER] [int] NULL,
	[MAIL_SENDCHECK] [char](1) NULL,
	[SMS_SENDCHECK] [char](1) NULL,
	[RES_MESSAGE_MAIL] [int] NULL,
	[RES_MESSAGE_SMS] [int] NULL,
	[CAN_MESSAGE_MAIL] [int] NULL,
	[CAN_MESSAGE_SMS] [int] NULL,
	[PAY_CLASSIFICATION] [varchar](30) NULL,
	[PAY_GUBUN] [varchar](30) NULL,
	[PAY_COST] [int] NULL,
	[REG_ID] [varchar](30) NULL,
	[REG_DATE] [datetime] NULL,
	[UPDATE_ID] [varchar](30) NULL,
	[UPDATE_DATE] [datetime] NULL,
	[MEETINGROOM_REMARK] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[MEETING_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_MESSAGEINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_MESSAGEINFO](
	[MSG_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[MSG_GUBUN] [varchar](20) NOT NULL,
	[MSG_TITLE] [varchar](100) NOT NULL,
	[MSG_SENDTYPE] [varchar](20) NOT NULL,
	[MSG_STARTDAY] [char](8) NULL,
	[MSG_ENDDAY] [char](8) NULL,
	[MSG_CONTENT] [text] NULL,
	[MSG_REG_ID] [varchar](20) NULL,
	[MSG_REG_DATE] [datetime] NULL,
	[MSG_UPDATE_ID] [varchar](20) NULL,
	[MSG_UPDATE_DATE] [datetime] NULL,
	[MSG_VARINFO] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MSG_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_ORGINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_ORGINFO](
	[DEPTCODE] [varchar](50) NULL,
	[DEPTNAME] [varchar](50) NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
	[USE_YN] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SEATINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SEATINFO](
	[CENTER_ID] [char](9) NULL,
	[FLOOR_SEQ] [int] NULL,
	[PART_SEQ] [int] NULL,
	[SEAT_ID] [char](17) NOT NULL,
	[SEAT_NAME] [varchar](30) NULL,
	[SEAT_USEYN] [char](1) NULL,
	[SEAT_TOP] [int] NULL,
	[SEAT_LEFT] [int] NULL,
	[SEAT_FIX_USERYN] [char](1) NULL,
	[SEAT_FIX_USER_ID] [varchar](30) NULL,
	[ORG_CD] [varchar](30) NULL,
	[SEAT_QR_CODE] [varchar](50) NULL,
	[SEAT_QR_CODE_PATH] [varchar](60) NULL,
	[SEAT_QR_CODE_FULL_PATH] [varchar](100) NULL,
	[SEAT_ORDER] [int] NULL,
	[SEAT_NUMBER] [varchar](15) NULL,
	[SEAT_GUBUN] [varchar](30) NULL,
	[PAY_CLASSIFICATION] [varchar](30) NULL,
	[PAY_GUBUN] [varchar](30) NULL,
	[PAY_COST] [int] NULL,
	[SEAT_CONFIRMGUBUN] [varchar](30) NULL,
	[SEAT_FIX_GUBUN] [varchar](30) NULL,
	[REG_ID] [varchar](30) NULL,
	[REG_DATE] [datetime] NULL,
	[UPDATE_ID] [varchar](30) NULL,
	[UPDATE_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SEAT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SWC_ROOM]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SWC_ROOM](
	[SWC_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[SEAT_NAME] [varchar](80) NULL,
	[CENTER_PARTID] [varchar](20) NULL,
	[ROOM_NAME] [varchar](80) NULL,
	[CENTER_ID] [char](9) NOT NULL,
	[EQUIPMENT_STATE] [varchar](2000) NULL,
	[ROOM_TYPE] [varchar](25) NULL,
	[MAX_CNT] [int] NULL,
	[SWC_USEYN] [char](1) NULL,
	[FRST_REGIST_PNTTM] [datetime] NULL,
	[FRST_REGISTER_ID] [varchar](20) NULL,
	[LAST_UPDT_PNTTM] [datetime] NULL,
	[LAST_UPDUSR_ID] [varchar](20) NULL,
	[SEAT_VIEW] [char](1) NULL,
	[SEAT_ORDER] [int] NULL,
	[SEAT_IMG1] [varchar](50) NULL,
	[SEAT_IMG2] [varchar](50) NULL,
	[TERMINAL_NUMBER] [varchar](10) NULL,
	[TERMINAL_ID] [varchar](10) NULL,
	[TERMINAL_TEL] [varchar](20) NULL,
	[AVAYA_USERID] [varchar](30) NULL,
	[AVAYA_CONFI_ID] [varchar](30) NULL,
	[END_NAME] [varchar](10) NULL,
	[USER_EMAIL] [varchar](250) NULL,
	[USER_LAST_NM] [varchar](50) NULL,
	[USER_FIRST_NM] [varchar](50) NULL,
	[AVAYA_ROOMCODE] [varchar](50) NULL,
	[SEAT_CONFIRMGUBUN] [varchar](30) NULL,
	[SEAT_EQUPGUBUN] [varchar](30) NULL,
	[SEAT_ADMINID] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[SWC_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SWCINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SWCINFO](
	[SWC_INTERVAL] [int] NULL,
	[START_TIME] [varchar](5) NULL,
	[END_TIME] [varchar](5) NULL,
	[TENN_RETRIEVE] [int] NULL,
	[COM_TITLE] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SWCRESERVATION]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SWCRESERVATION](
	[RES_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[SWC_SEQ] [int] NOT NULL,
	[CENTER_ID] [char](9) NOT NULL,
	[RES_GUBUN] [varchar](30) NULL,
	[USER_ID] [varchar](30) NULL,
	[DEPT_ID] [varchar](30) NULL,
	[RANK_ID] [varchar](30) NULL,
	[RES_STARTDAY] [char](8) NULL,
	[RES_ENDDAY] [char](8) NULL,
	[RES_STARTTIME] [char](4) NULL,
	[RES_ENDTIME] [char](4) NULL,
	[REG_DATE] [datetime] NULL,
	[RESERV_PROCESS_GUBUN] [varchar](30) NULL,
	[RESERVATION_REASON] [varchar](1000) NULL,
	[CANCEL_REASON] [varchar](1000) NULL,
	[CANCEL_CODE] [varchar](30) NULL,
	[RES_REMARK] [varchar](1000) NULL,
	[PROXY_YN] [char](1) NULL,
	[PROXY_USER_ID] [varchar](30) NULL,
	[UPDATE_DATE] [datetime] NULL,
	[UPDATE_ID] [varchar](30) NULL,
	[RES_REPLY_DATE] [datetime] NULL,
	[ADMIN_REPLY_DATE] [datetime] NULL,
	[ADMIN_PROCESS_GUBUN] [char](20) NULL,
	[ADMIN_CANCELCODE] [char](20) NULL,
	[USE_YN] [char](1) NULL,
	[RES_TITLE] [varchar](100) NULL,
	[RES_PASSWORD] [varchar](255) NULL,
	[MEETING_SEQ] [varchar](100) NULL,
	[RES_ATTENDLIST] [varchar](1000) NULL,
	[MEETINGLOG] [text] NULL,
	[RES_FILE1] [varchar](20) NULL,
	[RES_FILE2] [varchar](20) NULL,
	[CONFERENCE_ID] [varchar](10) NULL,
	[CON_NUMBER] [varchar](10) NULL,
	[CON_PIN] [varchar](8) NULL,
	[CON_VIRTUAL_PIN] [varchar](8) NULL,
	[CON_ALLOWSTREAM] [varchar](10) NULL,
	[CON_BLACKDIAL] [varchar](10) NULL,
	[CON_SENDNOTI] [varchar](10) NULL,
	[RES_SEND_RESULT] [varchar](20) NULL,
	[RES_SEND_RESULT_TXT] [varchar](100) NULL,
	[RES_EQUPINFO] [varchar](1000) NULL,
	[TENN_CNT] [int] NULL,
	[FLOOR_SEQ] [int] NULL,
	[IN_TIME] [datetime] NULL,
	[OT_TIME] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RES_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SWCTIME]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SWCTIME](
	[TIME_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[CENTER_ID] [char](9) NOT NULL,
	[SWC_RESDAY] [char](8) NOT NULL,
	[SWC_TIME] [varchar](4) NULL,
	[RES_SEQ] [int] NULL,
	[APPRIVAL] [char](1) NULL,
	[USE_YN] [char](1) NULL,
	[ITEM_ID] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TIME_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_USERINFO]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_USERINFO](
	[USER_ID] [varchar](20) NOT NULL,
	[USER_NAME] [varchar](30) NULL,
	[USER_NO] [varchar](20) NOT NULL,
	[COM_CODE] [char](10) NULL,
	[USER_RANK] [varchar](50) NULL,
	[USER_POSITION] [varchar](50) NULL,
	[USER_EMAIL] [varchar](250) NULL,
	[USER_TEL] [varchar](15) NULL,
	[USER_STATE] [varchar](30) NULL,
	[USER_CELLPHONE] [varchar](15) NULL,
	[USER_REGDATE] [datetime] NULL,
	[USER_REGID] [varchar](30) NULL,
	[USER_UPDATE] [datetime] NULL,
	[USER_UPDATEID] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[USER_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[COMTNLOGINLOG] ADD  DEFAULT (NULL) FOR [CONECT_ID]
GO
ALTER TABLE [dbo].[COMTNLOGINLOG] ADD  DEFAULT (NULL) FOR [CONECT_IP]
GO
ALTER TABLE [dbo].[COMTNLOGINLOG] ADD  DEFAULT (NULL) FOR [CONECT_MTHD]
GO
ALTER TABLE [dbo].[COMTNLOGINLOG] ADD  DEFAULT (NULL) FOR [ERROR_OCCRRNC_AT]
GO
ALTER TABLE [dbo].[COMTNLOGINLOG] ADD  DEFAULT (NULL) FOR [ERROR_CODE]
GO
ALTER TABLE [dbo].[COMTNLOGINLOG] ADD  DEFAULT (getdate()) FOR [CREAT_DT]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [JOB_SE_CODE]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [OCCRRNC_DE]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [SRVC_NM]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [METHOD_NM]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [PROCESS_SE_CODE]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [PROCESS_CO]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [PROCESS_TIME]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [ERROR_SE]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [ERROR_CODE]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [ERROR_CO]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [RSPNS_CODE]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [INSTT_CODE]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [TRGET_MENU_NM]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [RQESTER_IP]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [RQESTER_ID]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [SQLID]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [SQL_PARAM]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [SQL_QUERY]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (NULL) FOR [METHOD_RESULT]
GO
ALTER TABLE [dbo].[COMTNSYSLOG] ADD  DEFAULT (getdate()) FOR [OCCRRNC_DATE]
GO
ALTER TABLE [dbo].[IDS] ADD  DEFAULT ('') FOR [TABLE_NAME]
GO
ALTER TABLE [dbo].[IDS] ADD  DEFAULT ((0)) FOR [NEXT_ID]
GO
ALTER TABLE [dbo].[LETTCCMMNCLCODE] ADD  DEFAULT (NULL) FOR [CL_CODE_NM]
GO
ALTER TABLE [dbo].[LETTCCMMNCLCODE] ADD  DEFAULT (NULL) FOR [CL_CODE_DC]
GO
ALTER TABLE [dbo].[LETTCCMMNCLCODE] ADD  DEFAULT (NULL) FOR [USE_AT]
GO
ALTER TABLE [dbo].[LETTCCMMNCLCODE] ADD  DEFAULT (NULL) FOR [FRST_REGIST_PNTTM]
GO
ALTER TABLE [dbo].[LETTCCMMNCLCODE] ADD  DEFAULT (NULL) FOR [FRST_REGISTER_ID]
GO
ALTER TABLE [dbo].[LETTCCMMNCLCODE] ADD  DEFAULT (NULL) FOR [LAST_UPDT_PNTTM]
GO
ALTER TABLE [dbo].[LETTCCMMNCLCODE] ADD  DEFAULT (NULL) FOR [LAST_UPDUSR_ID]
GO
ALTER TABLE [dbo].[LETTCCMMNCODE] ADD  DEFAULT (NULL) FOR [CODE_ID_NM]
GO
ALTER TABLE [dbo].[LETTCCMMNCODE] ADD  DEFAULT (NULL) FOR [CODE_ID_DC]
GO
ALTER TABLE [dbo].[LETTCCMMNCODE] ADD  DEFAULT (NULL) FOR [USE_AT]
GO
ALTER TABLE [dbo].[LETTCCMMNCODE] ADD  DEFAULT (NULL) FOR [CL_CODE]
GO
ALTER TABLE [dbo].[LETTCCMMNCODE] ADD  DEFAULT (getdate()) FOR [FRST_REGIST_PNTTM]
GO
ALTER TABLE [dbo].[LETTCCMMNCODE] ADD  DEFAULT (NULL) FOR [FRST_REGISTER_ID]
GO
ALTER TABLE [dbo].[LETTCCMMNCODE] ADD  DEFAULT (NULL) FOR [LAST_UPDUSR_ID]
GO
ALTER TABLE [dbo].[LETTCCMMNDETAILCODE] ADD  DEFAULT (NULL) FOR [CODE_NM]
GO
ALTER TABLE [dbo].[LETTCCMMNDETAILCODE] ADD  DEFAULT (NULL) FOR [CODE_DC]
GO
ALTER TABLE [dbo].[LETTCCMMNDETAILCODE] ADD  DEFAULT (NULL) FOR [CODE_ETC1]
GO
ALTER TABLE [dbo].[LETTCCMMNDETAILCODE] ADD  DEFAULT (NULL) FOR [CODE_ETC2]
GO
ALTER TABLE [dbo].[LETTCCMMNDETAILCODE] ADD  DEFAULT (NULL) FOR [CODE_ETC3]
GO
ALTER TABLE [dbo].[LETTCCMMNDETAILCODE] ADD  DEFAULT (NULL) FOR [USE_AT]
GO
ALTER TABLE [dbo].[LETTCCMMNDETAILCODE] ADD  DEFAULT (getdate()) FOR [FRST_REGIST_PNTTM]
GO
ALTER TABLE [dbo].[LETTCCMMNDETAILCODE] ADD  DEFAULT (NULL) FOR [FRST_REGISTER_ID]
GO
ALTER TABLE [dbo].[LETTCCMMNDETAILCODE] ADD  DEFAULT (NULL) FOR [LAST_UPDUSR_ID]
GO
ALTER TABLE [dbo].[LETTNAUTHORINFO] ADD  DEFAULT (NULL) FOR [AUTHOR_DC]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT (NULL) FOR [ORIGNL_FILE_NM]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT (NULL) FOR [FILE_SIZE]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT ((0)) FOR [CON_SEQ]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT ((0)) FOR [FILE_ORDER]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT (NULL) FOR [DETAIL_SEQ]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT (NULL) FOR [FILE_THUMNAIL]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT (NULL) FOR [PLAY_TIME]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT (NULL) FOR [FILE_WIDTH]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT (NULL) FOR [FILE_HEIGHT]
GO
ALTER TABLE [dbo].[LETTNFILEDETAIL] ADD  DEFAULT ('N') FOR [USEYN]
GO
ALTER TABLE [dbo].[RTETCCODE] ADD  DEFAULT (NULL) FOR [CODE_ID]
GO
ALTER TABLE [dbo].[RTETCCODE] ADD  DEFAULT (NULL) FOR [CODE_NM]
GO
ALTER TABLE [dbo].[RTETNAUTH] ADD  DEFAULT (NULL) FOR [MNGR_SE]
GO
ALTER TABLE [dbo].[RTETNAUTH] ADD  DEFAULT (NULL) FOR [URL]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [ADMIN_NAME]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [EMP_NO]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [DEPT_ID]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [DEPT_NAME]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [ADMIN_EMAIL]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [ADMIN_TEL]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [UPDATE_PASSWORD]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [ADMIN_LEVEL]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [LOCK_YN]
GO
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [USE_YN]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [USER_ID]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [RES_DAY]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [ROOM_INTIME]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [ROOM_OTTIME]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [NOTIN_TIME]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [NOTOT_TIME]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [ATT_REGDATE]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [ATT_UPDATE]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [LOGIN]
GO
ALTER TABLE [dbo].[TB_ATTENDANCE] ADD  DEFAULT (NULL) FOR [LOGOUT]
GO
ALTER TABLE [dbo].[TB_AVAYASENDMESSAGE] ADD  DEFAULT (NULL) FOR [REQ_MESSAGE_TXT]
GO
ALTER TABLE [dbo].[TB_AVAYASENDMESSAGE] ADD  DEFAULT (NULL) FOR [RES_MESSAGE]
GO
ALTER TABLE [dbo].[TB_AVAYASENDMESSAGE] ADD  DEFAULT (NULL) FOR [RES_MESSAGE_TXT]
GO
ALTER TABLE [dbo].[TB_AVAYASENDMESSAGE] ADD  DEFAULT (getdate()) FOR [REQ_REGDATE]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_TITLE]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT ('N') FOR [BOARD_NOTICE_USEYN]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_NOTICE_STARTDAY]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_NOTICE_ENDDAY]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_CONTENT]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_RETURN_CONTENT]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (getdate()) FOR [BOARD_REGDATE]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_REG_ID]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_UPDATE_ID]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_FILE01]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_FILE02]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT ('N') FOR [BOARD_VIEW_YN]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_FAQ_GUBUN]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT ((0)) FOR [BOARD_VISITED]
GO
ALTER TABLE [dbo].[TB_BOARD] ADD  DEFAULT (NULL) FOR [BOARD_TOP_SEQ]
GO
ALTER TABLE [dbo].[TB_CALENDER] ADD  DEFAULT (NULL) FOR [DATES]
GO
ALTER TABLE [dbo].[TB_CALENDER] ADD  DEFAULT (NULL) FOR [YEAR]
GO
ALTER TABLE [dbo].[TB_CALENDER] ADD  DEFAULT (NULL) FOR [MONTH]
GO
ALTER TABLE [dbo].[TB_CALENDER] ADD  DEFAULT (NULL) FOR [DAY]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_NM]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_ZIPCODE]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_ADDR1]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_ADDR2]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_TEL]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_FAX]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_USER_ID]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (getdate()) FOR [CENTER_REGDATE]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_UPDATE_USER_ID]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_IMG]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_URL]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_SEAT_IMG]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT ('1') FOR [CENTER_USE_YN]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [REST_INFO]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [MEETINGROOM_INFO]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT (NULL) FOR [CENTER_INFO]
GO
ALTER TABLE [dbo].[TB_CENTERINFO] ADD  DEFAULT ('1') FOR [ADMIN_APPROVAL_YN]
GO
ALTER TABLE [dbo].[TB_COMPANYINFO] ADD  CONSTRAINT [DF__TB_COMPAN__TENN___42ACE4D4]  DEFAULT ('N') FOR [TENN_USEYN]
GO
ALTER TABLE [dbo].[TB_COMPANYINFO] ADD  CONSTRAINT [DF__TB_COMPAN__COM_R__43A1090D]  DEFAULT (getdate()) FOR [COM_REGDATE]
GO
ALTER TABLE [dbo].[TB_COMPAY_TENNANT] ADD  DEFAULT (getdate()) FOR [TENN_REC_DATE]
GO
ALTER TABLE [dbo].[TB_COMPAY_TENNANT] ADD  DEFAULT (getdate()) FOR [REG_ID]
GO
ALTER TABLE [dbo].[TB_COMPAY_TENNANT_HISTORY] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_COMPAY_TENNANT_HISTORY] ADD  DEFAULT ('Y') FOR [TENN_APPRIVAL]
GO
ALTER TABLE [dbo].[TB_DEVICEINFO] ADD  DEFAULT ('Y') FOR [USE_YN]
GO
ALTER TABLE [dbo].[TB_DEVICEINFO] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPID]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPNO]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPNAME]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [DEPTNAME]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [DEPTCODE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPGARD]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPGARDCODE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPJIKW]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPJIKWCODE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPHANDPHONE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPTELPHONE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [EMPMAIL]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [ADMIN_GUBUN]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (getdate()) FOR [UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [AVAYA_USERID]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [DT_COENT]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  DEFAULT (NULL) FOR [CD_LVLGRD]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT (NULL) FOR [EQUP_SEIAL]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT ((0)) FOR [SWC_SEQ]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT (NULL) FOR [USER_ID]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT (NULL) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT (NULL) FOR [COMPANY]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT (NULL) FOR [REMARK]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT (getdate()) FOR [EQUP_INDATE]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT (NULL) FOR [EQUP_OTDATE]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT ('N') FOR [USE_YN]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT (NULL) FOR [EQUIP_STATE]
GO
ALTER TABLE [dbo].[TB_EQUIPMENTINFO] ADD  DEFAULT (NULL) FOR [EQUIP_IMG]
GO
ALTER TABLE [dbo].[TB_FLOORINFO] ADD  DEFAULT ((0)) FOR [SEAT_CNT]
GO
ALTER TABLE [dbo].[TB_FLOORINFO] ADD  DEFAULT ((0)) FOR [MEET_CNT]
GO
ALTER TABLE [dbo].[TB_FLOORINFO] ADD  DEFAULT ('Y') FOR [FLOOR_USEYN]
GO
ALTER TABLE [dbo].[TB_FLOORINFO] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_FLOORPART] ADD  DEFAULT ('Y') FOR [PART_USEYN]
GO
ALTER TABLE [dbo].[TB_FLOORPART] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_JOBINFO] ADD  DEFAULT (NULL) FOR [EMPJIKW]
GO
ALTER TABLE [dbo].[TB_JOBINFO] ADD  DEFAULT (NULL) FOR [EMPJIKWCODE]
GO
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT ('N') FOR [MEETING_USEYN]
GO
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT ('Y') FOR [MEETING_VIEW]
GO
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT ('Y') FOR [MEETING_MAINVIEW]
GO
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT ('N') FOR [MAIL_SENDCHECK]
GO
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT ('N') FOR [SMS_SENDCHECK]
GO
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_MESSAGEINFO] ADD  DEFAULT (NULL) FOR [MSG_STARTDAY]
GO
ALTER TABLE [dbo].[TB_MESSAGEINFO] ADD  DEFAULT (NULL) FOR [MSG_ENDDAY]
GO
ALTER TABLE [dbo].[TB_MESSAGEINFO] ADD  DEFAULT (NULL) FOR [MSG_CONTENT]
GO
ALTER TABLE [dbo].[TB_MESSAGEINFO] ADD  DEFAULT (NULL) FOR [MSG_REG_ID]
GO
ALTER TABLE [dbo].[TB_MESSAGEINFO] ADD  DEFAULT (getdate()) FOR [MSG_REG_DATE]
GO
ALTER TABLE [dbo].[TB_MESSAGEINFO] ADD  DEFAULT (NULL) FOR [MSG_UPDATE_ID]
GO
ALTER TABLE [dbo].[TB_MESSAGEINFO] ADD  DEFAULT (NULL) FOR [MSG_UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_MESSAGEINFO] ADD  DEFAULT (NULL) FOR [MSG_VARINFO]
GO
ALTER TABLE [dbo].[TB_ORGINFO] ADD  DEFAULT (NULL) FOR [DEPTCODE]
GO
ALTER TABLE [dbo].[TB_ORGINFO] ADD  DEFAULT (NULL) FOR [DEPTNAME]
GO
ALTER TABLE [dbo].[TB_ORGINFO] ADD  DEFAULT (getdate()) FOR [UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_ORGINFO] ADD  DEFAULT ('Y') FOR [USE_YN]
GO
ALTER TABLE [dbo].[TB_SEATINFO] ADD  DEFAULT ('Y') FOR [SEAT_USEYN]
GO
ALTER TABLE [dbo].[TB_SEATINFO] ADD  DEFAULT ('Y') FOR [SEAT_FIX_USERYN]
GO
ALTER TABLE [dbo].[TB_SEATINFO] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [SEAT_NAME]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [CENTER_PARTID]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [ROOM_NAME]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [EQUIPMENT_STATE]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [ROOM_TYPE]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [MAX_CNT]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [SWC_USEYN]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (getdate()) FOR [FRST_REGIST_PNTTM]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [FRST_REGISTER_ID]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [LAST_UPDT_PNTTM]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [LAST_UPDUSR_ID]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT ('N') FOR [SEAT_VIEW]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT ((0)) FOR [SEAT_ORDER]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [SEAT_IMG1]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [SEAT_IMG2]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [TERMINAL_NUMBER]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [TERMINAL_ID]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [TERMINAL_TEL]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [AVAYA_USERID]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [AVAYA_CONFI_ID]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [END_NAME]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [USER_EMAIL]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [USER_LAST_NM]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [USER_FIRST_NM]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [AVAYA_ROOMCODE]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [SEAT_CONFIRMGUBUN]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [SEAT_EQUPGUBUN]
GO
ALTER TABLE [dbo].[TB_SWC_ROOM] ADD  DEFAULT (NULL) FOR [SEAT_ADMINID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_GUBUN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [USER_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [DEPT_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RANK_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_STARTDAY]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_ENDDAY]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_STARTTIME]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_ENDTIME]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RESERV_PROCESS_GUBUN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RESERVATION_REASON]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [CANCEL_REASON]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [CANCEL_CODE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_REMARK]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [PROXY_YN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [PROXY_USER_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [UPDATE_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_REPLY_DATE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [ADMIN_REPLY_DATE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [ADMIN_PROCESS_GUBUN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [ADMIN_CANCELCODE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [USE_YN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_TITLE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_PASSWORD]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [MEETING_SEQ]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_ATTENDLIST]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [MEETINGLOG]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_FILE1]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_FILE2]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [CONFERENCE_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [CON_NUMBER]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [CON_PIN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [CON_VIRTUAL_PIN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [CON_ALLOWSTREAM]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [CON_BLACKDIAL]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [CON_SENDNOTI]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_SEND_RESULT]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_SEND_RESULT_TXT]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  DEFAULT (NULL) FOR [RES_EQUPINFO]
GO
ALTER TABLE [dbo].[TB_SWCTIME] ADD  DEFAULT (NULL) FOR [SWC_TIME]
GO
ALTER TABLE [dbo].[TB_SWCTIME] ADD  DEFAULT (NULL) FOR [RES_SEQ]
GO
ALTER TABLE [dbo].[TB_SWCTIME] ADD  DEFAULT (NULL) FOR [APPRIVAL]
GO
ALTER TABLE [dbo].[TB_SWCTIME] ADD  DEFAULT (NULL) FOR [USE_YN]
GO
ALTER TABLE [dbo].[TB_USERINFO] ADD  DEFAULT (getdate()) FOR [USER_REGDATE]
GO
/****** Object:  StoredProcedure [dbo].[sp_Calender]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[sp_Calender]
 as
 begin
     DECLARE @v_sdate char(8);
     DECLARE @v_edate char(8);
   
     SET @v_sdate = '20200101';
     SET @v_edate = '20991231';
  
     WHILE (@v_sdate <= @v_sdate) 
	 begin 
        insert INTO TB_CALENDER values(@v_sdate, substring(@v_sdate, 1, 4),  substring(@v_sdate,5,2), substring(@v_sdate,7,2));
        set @v_sdate = (select convert( varchar(8), dateadd(DD, 1, '20210526'), 112) );
     end;


 end 
GO
/****** Object:  StoredProcedure [dbo].[sp_ComboBox]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 CREATE PROCEDURE [dbo].[sp_ComboBox] (@IS_FIELID VARCHAR(30), @IS_FIELNM VARCHAR(30) , @IS_TABLE VARCHAR(50), @IS_CONDITION VARCHAR(1000))
 as
 begin

    DECLARE @stmt nvarchar(4000);
	SET @stmt = ' select'+ @IS_FIELID+','+ @IS_FIELNM+' from '+ @IS_TABLE+' WHERE '+ replace(@IS_CONDITION, '[','''') ;
	EXEC sp_executesql @stmt

    

 end 
GO
/****** Object:  StoredProcedure [dbo].[SP_MAXVAL]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MAXVAL] (@IS_FIELD VARCHAR(30), @IS_TABLE varchar(50))
as
begin

   declare @stmt nvarchar(4000);
   set @stmt = 'select isnull(max(' + @IS_FIELD + '),0) from '+ @IS_TABLE  ;
    exec sp_executesql @stmt

end 
GO
/****** Object:  StoredProcedure [dbo].[sp_Room_TimeCreate]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_Room_TimeCreate] 
as

begin



    DECLARE  @vt_nowDay CHAR(8);
    DECLARE  @vt_nextDay CHAR(8);
    DECLARE  @vt_TableCount int;
    DECLARE  @vt_RoomNowCount int;
    DECLARE  @vt_startTime int;
    DECLARE  @vt_roomStart int;
    DECLARE  @vt_SWCRoomCount int;
    DECLARE  @vt_swc_roomID varchar(18);
    DECLARE  @vt_centerID varchar(9);
	DECLARE  @vt_roomEnd int

	SET @vt_RoomNowCount = 0;
    SET @vt_roomStart = (SELECT CAST( CONCAT('1', START_TIME) as int) FROM TB_SWCINFO) ;
	SET @vt_roomEnd = (SELECT CAST( CONCAT('1', END_TIME) as int) FROM TB_SWCINFO);

	SET @vt_nextDay = (select convert(varchar(8),  DATEADD(DAY,  SWC_INTERVAL, GETDATE()) ,112)from TB_SWCINFO);
    SET @vt_nowDay = (select  convert(varchar(8), getdate(), 112));

	WHILE (@vt_nowDay < @vt_nextDay) 
	BEGIN
	     SET @vt_nowDay =  (select  CONVERT(varchar(8),DATEADD(DAY,  1, @vt_nowDay), 112));
         SET @vt_SWCRoomCount = (SELECT isnull(COUNT(*),0) FROM TB_MEETING_ROOM WHERE MEETING_USEYN = 'Y');
		 SET @vt_RoomNowCount = 0;

		 WHILE (@vt_RoomNowCount < @vt_SWCRoomCount) 
		 BEGIN
		     BEGIN
			 -- 회의실 정리 
		     IF (@vt_RoomNowCount = 0) 
				 BEGIN
				     SET @vt_swc_roomID = (SELECT X.MEETING_ID  FROM ( 
                                            SELECT TOP 1 MEETING_ID  FROM TB_MEETING_ROOM WHERE MEETING_USEYN = 'Y'  ORDER BY MEETING_ID ASC  ) X
                                           )
				 END 
			 ELSE 
				 BEGIN
				     SET @vt_swc_roomID = (SELECT X.MEETING_ID   FROM ( 
                                              SELECT TOP 1 MEETING_ID FROM tb_meeting_room WHERE MEETING_USEYN = 'Y'  ORDER BY MEETING_ID ASC  ) X 
										   WHERE   X.MEETING_ID > @vt_swc_roomID  );
				 END 
             END 

			 SET @vt_centerID = (SELECT CENTER_ID FROM TB_MEETING_ROOM  WHERE  MEETING_ID = @vt_swc_roomID);
             SET @vt_TableCount = (SELECT isnull(COUNT(*),0)   FROM TB_SWCTIME WHERE SWC_RESDAY =  @vt_nowDay AND ITEM_ID = @vt_swc_roomID);

			 IF (@vt_TableCount =0) 
			 BEGIN
			     WHILE (@vt_roomStart  < @vt_roomEnd) 
				 BEGIN 
	                    INSERT INTO TB_SWCTIME (CENTER_ID, SWC_RESDAY, SWC_TIME, RES_SEQ, APPRIVAL, USE_YN, ITEM_ID)
                        VALUES (  @vt_centerID, @vt_nowDay, substring(CAST(@vt_roomStart AS VARCHAR(5)), 2,4)  ,0, 'N', 'N', @vt_swc_roomID);
	              
                        BEGIN 
							IF  substring(CAST(@vt_roomStart AS VARCHAR(5)), 4,2) = '30' 
								set @vt_roomStart = ((@vt_roomStart + 100) - 30);
							ELSE
								set @vt_roomStart = (@vt_roomStart +  30);
                        END 
                        
	              END
				  SET @vt_roomStart = (SELECT CAST( CONCAT('1', START_TIME) as int) FROM TB_SWCINFO);

			 END 
	         set @vt_RoomNowCount = @vt_RoomNowCount +1;    

		 END 
		 
	END 
    

end 



GO
/****** Object:  StoredProcedure [dbo].[SP_UNICHECK]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[SP_UNICHECK] (@isColumn varchar(25), @isTable VARCHAR(255), @isCondition varchar(1000) )
 as
 begin
     
	   
	   DECLARE @stmt nvarchar(4000);
	   SET @stmt = ' SELECT ISNULL(COUNT( '+ @isColumn + '  ),0)   FROM '+ @isTable + '  where ' +    replace(    @isCondition  , '[','''') ;
       EXEC sp_executesql @stmt  

 end 
GO
/****** Object:  StoredProcedure [dbo].[SP_UNIDEL]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create PROCEDURE [dbo].[SP_UNIDEL](@IS_table varchar(50), @IS_CONDITION varchar(50))
as
begin
   
   DECLARE @stmt nvarchar(4000);
   SET @stmt = 'delete from '+ @IS_table +' where ' + replace(@IS_CONDITION, '[','''');
   EXEC sp_executesql @stmt   
   

end 
GO
/****** Object:  StoredProcedure [dbo].[SP_UNISELECT]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[SP_UNISELECT] (@isColumn varchar(60), @isTable varchar(60), @isCondition varchar(200))
 AS
 BEGIN

    DECLARE @stmt nvarchar(4000);
	set @stmt = ' SELECT ' + @isColumn + '  FROM '+ @isTable + '  WHERE ' + replace(@isCondition, '[','''')
	EXEC sp_executesql @stmt   
  

 END 

 
GO
/****** Object:  StoredProcedure [dbo].[SP_UNIUPDATE]    Script Date: 2021-05-26 오후 1:35:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[SP_UNIUPDATE] (@isColumn VARCHAR(100), @isTable VARCHAR(50), @isCondition VARCHAR(1000))
 as

 begin
    
	DECLARE @stmt nvarchar(4000);
	SET @stmt = ' UPDATE '+ @isColumn+ ' SET '+ @isTable+  ' WHERE '+ replace(@isCondition, '[','''');
	EXEC sp_executesql @stmt   
       


 end 
GO
USE [master]
GO
ALTER DATABASE [smarwork] SET  READ_WRITE 
GO
