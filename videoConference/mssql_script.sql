USE [master]
GO
/****** Object:  Database [SMART_WORK]    Script Date: 2021-07-01 오후 3:37:06 ******/
CREATE DATABASE [SMART_WORK]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SMART_WORK', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SMART_WORK.mdf' , SIZE = 103424KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SMART_WORK_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SMART_WORK_log.ldf' , SIZE = 3456KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SMART_WORK] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SMART_WORK].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SMART_WORK] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SMART_WORK] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SMART_WORK] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SMART_WORK] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SMART_WORK] SET ARITHABORT OFF 
GO
ALTER DATABASE [SMART_WORK] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SMART_WORK] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SMART_WORK] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SMART_WORK] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SMART_WORK] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SMART_WORK] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SMART_WORK] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SMART_WORK] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SMART_WORK] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SMART_WORK] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SMART_WORK] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SMART_WORK] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SMART_WORK] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SMART_WORK] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SMART_WORK] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SMART_WORK] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SMART_WORK] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SMART_WORK] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SMART_WORK] SET  MULTI_USER 
GO
ALTER DATABASE [SMART_WORK] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SMART_WORK] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SMART_WORK] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SMART_WORK] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SMART_WORK] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SMART_WORK]
GO
/****** Object:  User [smart_work]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE USER [smart_work] FOR LOGIN [smart_work] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [empuser01]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE USER [empuser01] FOR LOGIN [empuser01] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [smart_work]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_ATTENTLIST]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[FN_ATTENTLIST] (@in_AttendList VARCHAR(30))
returns varchar(200)
begin
    DECLARE  @v_AttendList VARCHAR(50);
    
	if (len(@in_AttendList) > 0)
	begin
		SET @v_AttendList  = ( SELECT CASE WHEN ( (SELECT CHARINDEX(',' , @in_AttendList)) > 0) THEN 
	                                         
												  ( SELECT CONCAT((
																   SELECT EMPNAME 
																   FROM  TB_EMPINFO 
																   WHERE EMPNO = (SUBSTRING(@in_AttendList,1, CHARINDEX(',', @in_AttendList)))
																   ), '외', (LEN(@in_AttendList)-LEN(REPLACE(@in_AttendList,',',''))), '명')
												   )
											ELSE 
											  (  SELECT EMPNAME FROM  TB_EMPINFO where EMPNO = @in_AttendList )
								END
								)

   end 

   RETURN @v_AttendList;


end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_AVAYAREQID]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_CENTERID]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_DETAILCODENM]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_DETAILCODENMETC]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_DETAILCOODEID]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_FLOORNM]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create function  [dbo].[FN_FLOORNM]( @PLAY_FLOOR varchar(200))
 returns varchar(1200)
 begin
      DECLARE @v_floorTxt varchar(1000); 
	  /* 2017 버전 이상 
	  SET @v_floorTxt = (SELECT STRING_AGG(FLOOR_NAME, ',') WITHIN GROUP(ORDER BY FLOOR_NAME) FLOOR_NAME
						 FROM tb_floorinfo 
						 WHERE FLOOR_SEQ IN (select  strVALUE from  dbo.UF_SPLICT(@PLAY_FLOOR, ','))
						 );
	  */
	  /* 2017 버전 이하 */
	  SET @v_floorTxt = (SELECT stuff( (SELECT ',' + cast(t.FLOOR_NAME as VARCHAR(max))
						                FROM tb_floorinfo t
						                WHERE FLOOR_SEQ IN (SELECT strVALUE from  dbo.UF_SPLICT(@PLAY_FLOOR, ',')) 
						                for xml path ('')
						  ), 1, 1, ''
						));
	  RETURN @v_floorTxt;

 end 

GO
/****** Object:  UserDefinedFunction [dbo].[FN_JOBNMFN_JOBNM]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_MEETINGID]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create function [dbo].[FN_MEETINGID] (@AS_FLOORSEQ int)
 returns varchar(18)
 begin

   declare @flootInfo char(15);
   declare @RTN_SEATID char(18);
   
   SET @flootInfo = (
				     SELECT CONCAT( CENTER_ID, '_', REPLICATE('0',3 - LEN( b.CODE_DC)) , b.CODE_DC ,'_M')  
				     FROM TB_FLOORINFO a, LETTCCMMNDETAILCODE b
				     WHERE a.FLOOR_INFO = b.CODE 
				          AND FLOOR_SEQ = @AS_FLOORSEQ
                     );
   SET @RTN_SEATID = (SELECT CONCAT(@flootInfo, 
                             REPLICATE('0',3 - LEN( ISNULL(  cast( replace(MAX(MEETING_ID), @flootInfo, '') as int ) , 0) + 1 ))
							 , ISNULL( cast( replace(MAX(MEETING_ID), @flootInfo, '') as int ) , 0) + 1
							 )
					  FROM TB_MEETING_ROOM 
					  WHERE FLOOR_SEQ = @AS_FLOORSEQ
					 );
   
  return @RTN_SEATID;

 end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_MEETINGID_INSERT]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE function [dbo].[FN_MEETINGID_INSERT](@AS_FLOORSEQ int, @AS_NUMBER int)
 returns varchar(18)
 begin
     
   DECLARE @flootInfo char(15);
   DECLARE @RTN_SEATID char(18);
   DECLARE @maxCnt int ;


   SET @flootInfo = (    
				      SELECT CONCAT( CENTER_ID, '_', REPLICATE('0',3 - LEN( b.CODE_DC)), b.CODE_DC ,'_M')
				      FROM tb_floorinfo a, lettccmmndetailcode b
				      WHERE a.FLOOR_INFO = b.CODE 
				           AND FLOOR_SEQ = @AS_FLOORSEQ
                     );
   SET @maxCnt = (SELECT CAST( REPLACE(isnull(max(MEETING_ID),0), @flootInfo, '') as int) 
                  FROM  TB_MEETING_ROOM	
                  WHERE substring(MEETING_ID, 1, 15) =@flootInfo);

   SET @RTN_SEATID = (SELECT CONCAT(@flootInfo, REPLICATE('0',3 - LEN(@AS_NUMBER + @maxCnt)), @AS_NUMBER + @maxCnt ));
    
   RETURN @RTN_SEATID;

 end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_MEETINGNM]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_MESSAGECONTENT]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_MESSAGETITLE]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_NOIMAGEFN_NO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_ORGNM]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_RESCUNT]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_RESCUNT](@AS_INTTIME varchar(4), @AS_OTTTIME varchar(4))
returns int
begin
   
    declare @cnt int 

	set @cnt = (SELECT ISNULL(COUNT(*), 0)
                FROM LETTCCMMNDETAILCODE
                WHERE CODE_ID = 'SWC_TIME'  
                      AND replace(CODE_NM, ':','') BETWEEN @AS_INTTIME AND @AS_OTTTIME);

	 return @cnt

end 
GO
/****** Object:  UserDefinedFunction [dbo].[fn_resNameInfo]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_resNameInfo] (@resSeq int, @reqFeild varchar(30) )
returns varchar(50)
as
begin

    declare @ITEM_NAME  varchar(50);
	if (@reqFeild = 'NAME')
	begin 
		set @ITEM_NAME =  ( select case  ITEM_GUBUN when 'ITEM_GUBUN_2' then 
									   (select  SEAT_NAME
									    from TB_SEATINFO
									    where SEAT_ID = a.ITEM_ID)
								   else 
								       (select  MEETING_NAME
									    from TB_MEETING_ROOM
									    where MEETING_ID= a.ITEM_ID)
									 
								   end 
							from TB_SWCRESERVATION a
							where a.RES_SEQ  = @resSeq
							)
		end 
	else 
	begin
	   set @ITEM_NAME =  ( select case  ITEM_GUBUN when 'ITEM_GUBUN_2' then 
									   (select  SEAT_CONFIRMGUBUN
									   from TB_SEATINFO
									   where SEAT_ID = a.ITEM_ID)
								   else 
								       (select  MEETING_CONFIRMGUBUN
									   from TB_MEETING_ROOM
									   where MEETING_ID= a.ITEM_ID)
									 
								   end 
							from TB_SWCRESERVATION a
							where a.RES_SEQ  = @resSeq
							)
	end 
	return 	 @ITEM_NAME;

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_ROWTABLE]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_ROWTABLE] (@strVal int, @endVal int)
RETURNS  @RETURN_TABLE TABLE 
(
   RN varchar(500)
)
begin
    WITH GEN AS (  
		SELECT @strVal AS NUM  
		UNION ALL  
		SELECT NUM+1 FROM GEN WHERE NUM+1 <= @endVal  
	 )
    INSERT @RETURN_TABLE (RN) 
    SELECT * FROM GEN   ;
    return 
end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_SCHCODE]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_SCHCODE] ()
returns varchar(15)
begin

   declare @schCode varchar(15)

   set @schCode = (SELECT  CONCAT( 'SCH_', SUBSTRING(CONVERT(VARCHAR(8), getdate(), 112),3,10) ,
                           REPLICATE('0',4 - LEN( ISNULL(COUNT(*),0) + 1  )), ISNULL(COUNT(*),0) + 1 )
                   FROM TB_SCHEDULRINFO a 
				   WHERE CONVERT(VARCHAR(8), SCH_REGDATE, 112) = CONVERT(VARCHAR(8), getdate(), 112)
				   )
    return @schCode

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_SEATID]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE function [dbo].[FN_SEATID] (@AS_FLOORSEQ int)
 returns varchar(17)
 begin

   declare @flootInfo char(14);
   declare @RTN_SEATID char(17);
   
   SET @flootInfo = (
				     SELECT CONCAT( CENTER_ID, '_', REPLICATE('0',3 - LEN( b.CODE_DC)) , b.CODE_DC ,'_')  
				     FROM TB_FLOORINFO a, LETTCCMMNDETAILCODE b
				     WHERE a.FLOOR_INFO = b.CODE 
				          AND FLOOR_SEQ = @AS_FLOORSEQ
                     );
   SET @RTN_SEATID = (SELECT CONCAT(@flootInfo, 
                             REPLICATE('0',3 - LEN( ISNULL(  cast( replace(MAX(SEAT_ID), @flootInfo, '') as int ) , 0) + 1 ))
							 , ISNULL( cast( replace(MAX(SEAT_ID), @flootInfo, '') as int ) , 0) + 1
							 )
					  FROM TB_SEATINFO 
					  WHERE FLOOR_SEQ = @AS_FLOORSEQ
					 );
   
  return @RTN_SEATID;

 end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_SEATID_INSERT]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_SEATID_INSERT] (@AS_FLOORSEQ int, @AS_NUMBER int )
returns varchar(17)
begin
   
   DECLARE @flootInfo char(14);
   DECLARE @RTN_SEATID char(17);
   DECLARE @maxCnt int ;
   SET @flootInfo = (    
				      SELECT CONCAT( CENTER_ID, '_', REPLICATE('0',3 - LEN( b.CODE_DC)), b.CODE_DC ,'_')
				      FROM tb_floorinfo a, lettccmmndetailcode b
				      WHERE a.FLOOR_INFO = b.CODE 
				           AND FLOOR_SEQ = @AS_FLOORSEQ
                     );
   SET @maxCnt = (SELECT CAST( REPLACE(isnull(max(SEAT_ID),0), @flootInfo, '') as int) 
                  FROM  tb_seatinfo	
                  WHERE substring(SEAT_ID, 1, 14) =@flootInfo);

   SET @RTN_SEATID = (SELECT CONCAT(@flootInfo, REPLICATE('0',3 - LEN(@AS_NUMBER + @maxCnt)), @AS_NUMBER + @maxCnt ));
    
   RETURN @RTN_SEATID;


end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_SWCRESTATE]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE function [dbo].[FN_SWCRESTATE] ( @MEETING_ID varchar(20), @RES_DAY varchar(8))
returns varchar(5)
begin

    declare @resState varchar(5)
	
	set @resState = ( SELECT case  
					          WHEN   CNT > 13  then 
					          'useU'
                               WHEN  CNT < 13 AND CNT > 0  then
							  'useD'
							   ELSE 
							  'unuse'
							end 
				      FROM 	
						 (SELECT isnull(count(APPRIVAL),0) CNT, APPRIVAL
						  FROM TB_SWCTIME
						  WHERE ITEM_ID = @MEETING_ID AND SWC_RESDAY = @RES_DAY
								AND SWC_TIME not in ('1130', '1200','1230')
								AND SWC_TIME between '0800' AND '1830'
								AND SWC_RESDAY NOT IN (SELECT HOLY_DAY FROM TB_HOLYINFO WHERE HOLY_DAY = SWC_RESDAY)
						  GROUP BY APPRIVAL
						  ) X
					  WHERE X.APPRIVAL = 'N' );
    
	set @resState = (select isnull(@resState, 'unuse'))

	return @resState;

end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TENNPLAYINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FN_TENNPLAYINFO] (@itemId varchar(20),
                                 @itemGubun varchar(20),
								 @in_resDay varchar(10),
                                 @in_StartTime varchar(20),                                 
								 @in_endTime varchar(20),
                                 @in_uesrNo varchar(20)
								 )
RETURNS	VARCHAR(100)
BEGIN

    DECLARE @tennCnt int;
    DECLARE @costTenn int;
	
   
    SET @tennCnt = (SELECT ISNULL( SUM(TENN_REC_NOW_CNT), 0)
                    FROM tb_companyinfo a, tb_userinfo b, tb_compay_tennant c
                    WHERE a.COM_CODE  = b.COM_CODE
                          AND a.COM_CODE  = c.COM_CODE
                          AND TENN_REC_END  = 'Y'
                          AND b.USER_NO = @in_uesrNo);
    IF (@itemGubun = 'ITEM_GUBUN_1')
	BEGIN 
        SET @costTenn = (SELECT CASE a.PAY_CLASSIFICATION WHEN 'PAY_CLASSIFICATION_2' THEN 0
                           ELSE 
                               CASE a.PAY_GUBUN WHEN 'PAY_GUBUN_2' THEN 
	                                 (SELECT ISNULL(COUNT(*), 0) 
								      FROM tb_swctime
								      WHERE SWC_RESDAY = @in_resDay
								           AND ITEM_ID = @itemId 
								           AND SWC_TIME BETWEEN @in_StartTime AND @in_endTime
								      ) * a.PAY_COST
                                  ELSE a.PAY_COST
                               end 
                           END COST 
                     FROM
					     (SELECT PAY_CLASSIFICATION, PAY_GUBUN, PAY_COST
					       FROM tb_meeting_room
					       WHERE MEETING_ID = @itemId
					     ) a 
						 
					);
	END 
	ELSE 
	BEGIN
	     SET @costTenn = (SELECT CASE a.PAY_CLASSIFICATION WHEN 'PAY_CLASSIFICATION_2' THEN 0
                           ELSE 
                               CASE a.PAY_GUBUN WHEN 'PAY_GUBUN_2' THEN 
	                                 (SELECT ISNULL(COUNT(*), 0) 
								      FROM tb_swctime
								      WHERE SWC_RESDAY = @in_resDay
								           AND ITEM_ID = @itemId 
								           AND SWC_TIME BETWEEN @in_StartTime AND @in_endTime
								      ) * a.PAY_COST
                                  ELSE a.PAY_COST
                               end 
                           END COST 
                     FROM
					     (SELECT PAY_CLASSIFICATION, PAY_GUBUN, PAY_COST
					       FROM TB_SEATINFO
					       WHERE SEAT_ID = @itemId
					     ) a 
						 
					);
	END 
	return concat(@tennCnt , '|', @costTenn);
 

    
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_TimeSplit]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fn_TimeSplit] (@AS_Time varchar(4))
returns varchar(5)
begin
  
   DECLARE @v_timeSplit VARCHAR(5);
   SET @v_timeSplit =  (select concat(substring(@AS_Time,1,2),':',substring(@AS_Time,3,2)) );
   RETURN @v_timeSplit;


end 
GO
/****** Object:  UserDefinedFunction [dbo].[FN_UPSTIMEDOWN]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  UserDefinedFunction [dbo].[FN_USERNM]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FN_USERNM] (@inEmpno varchar(30))
returns varchar(50)
begin

  declare @user_name varchar(50)
  set @user_name = ''
  if (len(@inEmpno) > 0)
  begin
     set @user_name = (SELECT ISNULL(EMPNAME, '기업 내용 없음')
	                   FROM TB_EMPINFO
	                   WHERE EMPNO = @inEmpno
					   )

  end 

  return @user_name;

end 
GO
/****** Object:  UserDefinedFunction [dbo].[UF_SPLICT]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  function [dbo].[UF_SPLICT] (@STRMORE AS VARCHAR(8000), @STRDELIMETER AS VARCHAR(10))

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
/****** Object:  Table [dbo].[COMTECOPSEQ]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMTECOPSEQ](
	[TABLE_NAME] [varchar](20) NULL,
	[NEXT_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COMTNLOGINLOG]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COMTNSYSLOG]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IDS]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IDS](
	[TABLE_NAME] [varchar](20) NOT NULL,
	[NEXT_ID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LETTCCMMNCLCODE]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  Table [dbo].[LETTCCMMNCODE]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LETTCCMMNDETAILCODE]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LETTNAUTHORINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  Table [dbo].[LETTNFILEDETAIL]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RTETCCODE]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RTETCCODE](
	[CODE_ID] [varchar](20) NULL,
	[CODE_NM] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RTETNAUTH]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RTETNAUTH](
	[MNGR_SE] [varchar](20) NULL,
	[URL] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_imsi]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_imsi](
	[imsi_seq] [int] IDENTITY(1,1) NOT NULL,
	[imsi_field] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[imsi_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_ADMIN]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
	[AUTHOR_CODE] [varchar](15) NULL,
	[LOCK_YN] [char](1) NULL,
	[USE_YN] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ADMIN_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_ATTENDANCE]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  Table [dbo].[TB_AVAYASENDMESSAGE]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  Table [dbo].[TB_BOARD]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_CALENDER]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  Table [dbo].[TB_CENTERINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_COMPANYINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_COMPAY_TENNANT]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_COMPAY_TENNANT](
	[TENN_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[COM_CODE] [char](10) NULL,
	[TENN_REC_DATE] [varchar](8) NULL,
	[TENN_REC_COUNT] [int] NULL,
	[TENN_REC_PLAY_CNT] [int] NULL,
	[TENN_REC_NOW_CNT] [int] NULL,
	[TENN_REC_END] [varchar](20) NULL,
	[TENN_REMARK] [varchar](1200) NULL,
	[REG_ID] [varchar](30) NULL,
	[REG_DATE] [datetime] NULL,
	[UPDATE_ID] [varchar](30) NULL,
	[UPDATE_DATE] [datetime] NULL,
 CONSTRAINT [PK__TB_COMPA__ED5402407A62993B] PRIMARY KEY CLUSTERED 
(
	[TENN_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_COMPAY_TENNANT_HISTORY]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
	[RES_SEQ] [int] NULL,
	[USER_NO] [varchar](20) NULL,
	[UPDATE_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[HIS_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_DEVICEINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
	[DEVICE_ENDCONNTIME] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DEVICE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_EMPINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_EMPINFO](
	[EMPID] [varchar](20) NOT NULL,
	[EMPNO] [varchar](30) NULL,
	[EMPNAME] [varchar](30) NULL,
	[DEPTNAME] [varchar](30) NULL,
	[DEPTCODE] [varchar](10) NULL,
	[EMPGRAD] [varchar](15) NULL,
	[EMPGRADCODE] [varchar](20) NULL,
	[EMPJIKW] [varchar](20) NULL,
	[EMPJIKWCODE] [varchar](20) NULL,
	[EMPHANDPHONE] [varchar](15) NULL,
	[EMPTELPHONE] [varchar](15) NULL,
	[EMPMAIL] [varchar](255) NULL,
	[ADMIN_GUBUN] [varchar](20) NULL,
	[UPDATE_DATE] [datetime] NOT NULL,
	[AVAYA_USERID] [varchar](30) NULL,
	[DT_COENT] [varchar](8) NULL,
	[CD_LVLGRD] [varchar](10) NULL,
	[AUTHOR_CODE] [varchar](20) NULL,
	[COM_CODE] [varchar](10) NULL,
	[EMP_STATE] [varchar](20) NULL,
	[PRE_WORKINFO] [varchar](30) NULL,
	[NOW_WORKINFO] [varchar](30) NULL,
	[EMP_PIC] [varchar](50) NULL,
 CONSTRAINT [PK_TB_EMPINFO] PRIMARY KEY CLUSTERED 
(
	[EMPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_EQUIPMENTINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_ERRRORINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_ERRRORINFO](
	[ERR_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[ERR_PROC] [varchar](100) NULL,
	[ERR_PROC_REGDATE] [datetime] NULL,
	[ERR_PROC_ERRORMESSAGE] [varchar](2000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ERR_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_FLOORINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_FLOORPART]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_HOLYINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_HOLYINFO](
	[HOLY_DAY] [char](8) NOT NULL,
	[HOLY_TITLE] [varchar](20) NULL,
	[HOLY_USEYN] [char](1) NULL,
	[REG_ID] [varchar](20) NULL,
	[REG_DATE] [datetime] NULL,
	[UPDATE_ID] [varchar](20) NULL,
	[UPDATE_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[HOLY_DAY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_HOLYWORKINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_HOLYWORKINFO](
	[HOLY_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[HOLY_DATE] [varchar](8) NULL,
	[HOLY_NM] [varchar](20) NULL,
	[HOLY_GUBUN] [varchar](30) NULL,
	[ORG_ID] [varchar](150) NULL,
	[EMP_NO] [varchar](1000) NULL,
	[REG_DATE] [datetime] NULL,
	[REG_ID] [varchar](30) NULL,
	[UPDATE_DATE] [datetime] NULL,
	[UPDATE_ID] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[HOLY_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_JOBINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_JOBINFO](
	[EMPJIKW] [varchar](30) NULL,
	[EMPJIKWCODE] [varchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_MEETING_ROOM]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
	[MEETING_TOP] [int] NULL,
	[MEETING_LEFT] [int] NULL,
	[AVAYA_ROOMCODE] [varchar](30) NULL,
	[RES_REQDAY] [int] NULL,
	[MEETING_FILE01] [varchar](50) NULL,
	[MEETING_FILE02] [varchar](50) NULL,
	[MEETING_IMG3] [varchar](50) NULL,
	[MEETING_REMARK01] [varchar](1500) NULL,
	[MEETING_REMARK02] [varchar](1500) NULL,
	[MEETING_REMARK03] [varchar](1500) NULL,
	[MEETING_REMARK04] [varchar](1500) NULL,
	[MEETING_REMARK05] [varchar](1500) NULL,
	[MEETING_REMARK06] [varchar](1500) NULL,
	[MEETING_REMARK07] [varchar](1500) NULL,
	[MEETING_REMARK08] [varchar](1500) NULL,
	[QR_PLAYYN] [char](1) NULL,
	[QR_UPDATE_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MEETING_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_MESSAGEINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
	[USEYN] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[MSG_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_ORGINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  Table [dbo].[TB_QRCODE]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_QRCODE](
	[ITME_ID] [varchar](20) NOT NULL,
	[QR_GUBUN] [varchar](30) NULL,
	[QR_CODE] [varchar](50) NULL,
	[QR_PATH] [varchar](60) NULL,
	[QR_FULL_PATH] [varchar](100) NULL,
	[QR_REGDATE] [datetime] NULL,
	[RQ_END] [char](1) NULL,
	[RQ_END_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ITME_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SCHEDULRINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SCHEDULRINFO](
	[SCH_CODE] [char](14) NOT NULL,
	[SCH_NAME] [varchar](50) NULL,
	[SCH_REGDATE] [datetime] NULL,
	[SCH_RESULT] [varchar](20) NULL,
	[SCH_RESULT_MESSAGE] [text] NULL,
 CONSTRAINT [PK_TB_SCHEDULRINFO] PRIMARY KEY CLUSTERED 
(
	[SCH_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SEATINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
	[RES_REQDAY] [int] NULL,
	[QR_PLAYYN] [char](1) NULL,
	[QR_UPDATE_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SEAT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SWC_ROOM]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SWCINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SWCINFO](
	[SWC_INTERVAL] [int] NULL,
	[START_TIME] [varchar](5) NULL,
	[END_TIME] [varchar](5) NULL,
	[TENN_RETRIEVE] [int] NULL,
	[COM_TITLE] [varchar](255) NULL,
	[TENN_MONTHCNT] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SWCRESERVATION]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SWCRESERVATION](
	[RES_SEQ] [int] IDENTITY(1,1) NOT NULL,
	[ITEM_ID] [varchar](20) NOT NULL,
	[ITEM_GUBUN] [varchar](30) NULL,
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
	[ADMIN_PROCESS_GUBUN] [varchar](50) NULL,
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
	[HIS_SEQ] [int] NULL,
	[SEND_MESSAGE] [char](1) NULL,
	[RES_EQUPCHECK] [varchar](30) NULL,
	[RES_PERSON] [varchar](30) NULL,
 CONSTRAINT [PK__TB_SWCRE__DBA0695F9BEF347F] PRIMARY KEY CLUSTERED 
(
	[RES_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SWCTIME]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_USERINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
	[AUTHOR_CODE] [varchar](30) NULL,
	[USER_PASSWORD] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[USER_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_empinfo]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_empinfo]
as 

   select EMPNO, EMPNAME, DEPTNAME, EMPGRAD, EMPJIKW, EMPMAIL, EMPTELPHONE, EMPHANDPHONE
   from TB_EMPINFO
   where AUTHOR_CODE != 'ROLE_USER'


GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_MEETING_ROOM]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE NONCLUSTERED INDEX [IX_TB_MEETING_ROOM] ON [dbo].[TB_MEETING_ROOM]
(
	[CENTER_ID] ASC,
	[FLOOR_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_SEATINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE NONCLUSTERED INDEX [IX_TB_SEATINFO] ON [dbo].[TB_SEATINFO]
(
	[CENTER_ID] ASC,
	[FLOOR_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_SWCRESERVATION]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE NONCLUSTERED INDEX [IX_TB_SWCRESERVATION] ON [dbo].[TB_SWCRESERVATION]
(
	[RES_STARTDAY] ASC,
	[RES_STARTTIME] ASC,
	[RES_ENDTIME] ASC,
	[CENTER_ID] ASC,
	[FLOOR_SEQ] ASC,
	[ITEM_ID] ASC,
	[ITEM_GUBUN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_SWCTIME]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE NONCLUSTERED INDEX [IX_TB_SWCTIME] ON [dbo].[TB_SWCTIME]
(
	[SWC_RESDAY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_SWCTIME_1]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE NONCLUSTERED INDEX [IX_TB_SWCTIME_1] ON [dbo].[TB_SWCTIME]
(
	[SWC_TIME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_SWCTIME_2]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE NONCLUSTERED INDEX [IX_TB_SWCTIME_2] ON [dbo].[TB_SWCTIME]
(
	[ITEM_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_SWCTIME_3]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE NONCLUSTERED INDEX [IX_TB_SWCTIME_3] ON [dbo].[TB_SWCTIME]
(
	[CENTER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TB_SWCTIME_4]    Script Date: 2021-07-01 오후 3:37:07 ******/
CREATE NONCLUSTERED INDEX [IX_TB_SWCTIME_4] ON [dbo].[TB_SWCTIME]
(
	[RES_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE [dbo].[TB_ADMIN] ADD  DEFAULT (NULL) FOR [AUTHOR_CODE]
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
ALTER TABLE [dbo].[TB_COMPAY_TENNANT] ADD  CONSTRAINT [DF__TB_COMPAY__TENN___4D2A7347]  DEFAULT (getdate()) FOR [TENN_REC_DATE]
GO
ALTER TABLE [dbo].[TB_COMPAY_TENNANT] ADD  CONSTRAINT [DF__TB_COMPAY__REG_I__4E1E9780]  DEFAULT (getdate()) FOR [REG_ID]
GO
ALTER TABLE [dbo].[TB_COMPAY_TENNANT_HISTORY] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_COMPAY_TENNANT_HISTORY] ADD  DEFAULT ('Y') FOR [TENN_APPRIVAL]
GO
ALTER TABLE [dbo].[TB_COMPAY_TENNANT_HISTORY] ADD  DEFAULT ((0)) FOR [RES_SEQ]
GO
ALTER TABLE [dbo].[TB_COMPAY_TENNANT_HISTORY] ADD  CONSTRAINT [DF_TB_COMPAY_TENNANT_HISTORY_UPDATE_DATE]  DEFAULT (getdate()) FOR [UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_DEVICEINFO] ADD  DEFAULT ('Y') FOR [USE_YN]
GO
ALTER TABLE [dbo].[TB_DEVICEINFO] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPID__489AC854]  DEFAULT (NULL) FOR [EMPID]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPNO__498EEC8D]  DEFAULT (NULL) FOR [EMPNO]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPNA__4A8310C6]  DEFAULT (NULL) FOR [EMPNAME]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__DEPTN__4B7734FF]  DEFAULT (NULL) FOR [DEPTNAME]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__DEPTC__4C6B5938]  DEFAULT (NULL) FOR [DEPTCODE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPGA__4D5F7D71]  DEFAULT (NULL) FOR [EMPGRAD]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPGA__4E53A1AA]  DEFAULT (NULL) FOR [EMPGRADCODE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPJI__4F47C5E3]  DEFAULT (NULL) FOR [EMPJIKW]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPJI__503BEA1C]  DEFAULT (NULL) FOR [EMPJIKWCODE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPHA__51300E55]  DEFAULT (NULL) FOR [EMPHANDPHONE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPTE__5224328E]  DEFAULT (NULL) FOR [EMPTELPHONE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__EMPMA__531856C7]  DEFAULT (NULL) FOR [EMPMAIL]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__ADMIN__540C7B00]  DEFAULT (NULL) FOR [ADMIN_GUBUN]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__UPDAT__55009F39]  DEFAULT (getdate()) FOR [UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__AVAYA__55F4C372]  DEFAULT (NULL) FOR [AVAYA_USERID]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__DT_CO__56E8E7AB]  DEFAULT (NULL) FOR [DT_COENT]
GO
ALTER TABLE [dbo].[TB_EMPINFO] ADD  CONSTRAINT [DF__TB_EMPINF__CD_LV__57DD0BE4]  DEFAULT (NULL) FOR [CD_LVLGRD]
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
ALTER TABLE [dbo].[TB_ERRRORINFO] ADD  DEFAULT (getdate()) FOR [ERR_PROC_REGDATE]
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
ALTER TABLE [dbo].[TB_HOLYINFO] ADD  DEFAULT ('N') FOR [HOLY_USEYN]
GO
ALTER TABLE [dbo].[TB_HOLYINFO] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_HOLYWORKINFO] ADD  DEFAULT (getdate()) FOR [REG_DATE]
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
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT ((0)) FOR [MEETING_TOP]
GO
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT ((0)) FOR [MEETING_LEFT]
GO
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT ((0)) FOR [RES_REQDAY]
GO
ALTER TABLE [dbo].[TB_MEETING_ROOM] ADD  DEFAULT ('N') FOR [QR_PLAYYN]
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
ALTER TABLE [dbo].[TB_MESSAGEINFO] ADD  DEFAULT ('N') FOR [USEYN]
GO
ALTER TABLE [dbo].[TB_ORGINFO] ADD  DEFAULT (NULL) FOR [DEPTCODE]
GO
ALTER TABLE [dbo].[TB_ORGINFO] ADD  DEFAULT (NULL) FOR [DEPTNAME]
GO
ALTER TABLE [dbo].[TB_ORGINFO] ADD  DEFAULT (getdate()) FOR [UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_ORGINFO] ADD  DEFAULT ('Y') FOR [USE_YN]
GO
ALTER TABLE [dbo].[TB_QRCODE] ADD  DEFAULT (getdate()) FOR [QR_REGDATE]
GO
ALTER TABLE [dbo].[TB_QRCODE] ADD  DEFAULT ('N') FOR [RQ_END]
GO
ALTER TABLE [dbo].[TB_SCHEDULRINFO] ADD  CONSTRAINT [DF__TB_SCHEDU__SCH_R__18B6AB08]  DEFAULT (getdate()) FOR [SCH_REGDATE]
GO
ALTER TABLE [dbo].[TB_SEATINFO] ADD  DEFAULT ('Y') FOR [SEAT_USEYN]
GO
ALTER TABLE [dbo].[TB_SEATINFO] ADD  DEFAULT ('Y') FOR [SEAT_FIX_USERYN]
GO
ALTER TABLE [dbo].[TB_SEATINFO] ADD  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_SEATINFO] ADD  DEFAULT ((0)) FOR [RES_REQDAY]
GO
ALTER TABLE [dbo].[TB_SEATINFO] ADD  DEFAULT ('N') FOR [QR_PLAYYN]
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
ALTER TABLE [dbo].[TB_SWCINFO] ADD  DEFAULT ((0)) FOR [TENN_MONTHCNT]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_G__14E61A24]  DEFAULT (NULL) FOR [RES_GUBUN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__USER___15DA3E5D]  DEFAULT (NULL) FOR [USER_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__DEPT___16CE6296]  DEFAULT (NULL) FOR [DEPT_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RANK___17C286CF]  DEFAULT (NULL) FOR [RANK_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_S__18B6AB08]  DEFAULT (NULL) FOR [RES_STARTDAY]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_E__19AACF41]  DEFAULT (NULL) FOR [RES_ENDDAY]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_S__1A9EF37A]  DEFAULT (NULL) FOR [RES_STARTTIME]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_E__1B9317B3]  DEFAULT (NULL) FOR [RES_ENDTIME]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__REG_D__1C873BEC]  DEFAULT (getdate()) FOR [REG_DATE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RESER__1D7B6025]  DEFAULT (NULL) FOR [RESERV_PROCESS_GUBUN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RESER__1E6F845E]  DEFAULT (NULL) FOR [RESERVATION_REASON]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__CANCE__1F63A897]  DEFAULT (NULL) FOR [CANCEL_REASON]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__CANCE__2057CCD0]  DEFAULT (NULL) FOR [CANCEL_CODE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_R__214BF109]  DEFAULT (NULL) FOR [RES_REMARK]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__PROXY__22401542]  DEFAULT (NULL) FOR [PROXY_YN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__PROXY__2334397B]  DEFAULT (NULL) FOR [PROXY_USER_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__UPDAT__24285DB4]  DEFAULT (NULL) FOR [UPDATE_DATE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__UPDAT__251C81ED]  DEFAULT (NULL) FOR [UPDATE_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_R__2610A626]  DEFAULT (NULL) FOR [RES_REPLY_DATE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__ADMIN__2704CA5F]  DEFAULT (NULL) FOR [ADMIN_REPLY_DATE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__ADMIN__27F8EE98]  DEFAULT (NULL) FOR [ADMIN_PROCESS_GUBUN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__USE_Y__29E1370A]  DEFAULT (NULL) FOR [USE_YN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_T__2AD55B43]  DEFAULT (NULL) FOR [RES_TITLE]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_P__2BC97F7C]  DEFAULT (NULL) FOR [RES_PASSWORD]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__MEETI__2CBDA3B5]  DEFAULT (NULL) FOR [MEETING_SEQ]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_A__2DB1C7EE]  DEFAULT (NULL) FOR [RES_ATTENDLIST]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__MEETI__2EA5EC27]  DEFAULT (NULL) FOR [MEETINGLOG]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_F__2F9A1060]  DEFAULT (NULL) FOR [RES_FILE1]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_F__308E3499]  DEFAULT (NULL) FOR [RES_FILE2]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__CONFE__318258D2]  DEFAULT (NULL) FOR [CONFERENCE_ID]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__CON_N__32767D0B]  DEFAULT (NULL) FOR [CON_NUMBER]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__CON_P__336AA144]  DEFAULT (NULL) FOR [CON_PIN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__CON_V__345EC57D]  DEFAULT (NULL) FOR [CON_VIRTUAL_PIN]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__CON_A__3552E9B6]  DEFAULT (NULL) FOR [CON_ALLOWSTREAM]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__CON_B__36470DEF]  DEFAULT (NULL) FOR [CON_BLACKDIAL]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__CON_S__373B3228]  DEFAULT (NULL) FOR [CON_SENDNOTI]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_S__382F5661]  DEFAULT (NULL) FOR [RES_SEND_RESULT]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_S__39237A9A]  DEFAULT (NULL) FOR [RES_SEND_RESULT_TXT]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__RES_E__3A179ED3]  DEFAULT (NULL) FOR [RES_EQUPINFO]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF_TB_SWCRESERVATION_HIS_SEQ]  DEFAULT ((0)) FOR [HIS_SEQ]
GO
ALTER TABLE [dbo].[TB_SWCRESERVATION] ADD  CONSTRAINT [DF__TB_SWCRES__SEND___24B26D99]  DEFAULT ('N') FOR [SEND_MESSAGE]
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
/****** Object:  StoredProcedure [dbo].[sp_Calender]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE proc [dbo].[sp_Calender]
 as
 begin
     DECLARE @v_sdate char(8);
     DECLARE @v_edate char(8);
   
     SET @v_sdate = '20210101';
     SET @v_edate = '20991231';
  
     WHILE (@v_sdate <= @v_edate) 
	 begin 
        insert INTO TB_CALENDER values(@v_sdate, substring(@v_sdate, 1, 4),  substring(@v_sdate,5,2), substring(@v_sdate,7,2));
        set @v_sdate = (select convert( varchar(8), dateadd(DD, 1, @v_sdate), 112) );
     end;


 end 
GO
/****** Object:  StoredProcedure [dbo].[sp_ComboBox]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EMPSEATINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_EMPSEATINFO] 
as

begin 



	SELECT b.DEPTNAME, b.EMPNAME, b.EMPTELPHONE as SEAT_NAME,  
		   SUBSTRING(c.CODE_NM, 0, CHARINDEX('~',c.CODE_NM )) RES_STARTTIME, 
		   SUBSTRING(c.CODE_NM, CHARINDEX('~',c.CODE_NM ) + 1, len(c.CODE_NM)) RES_ENDTIME

	FROM  TB_SEATINFO a, TB_EMPINFO b, LETTCCMMNDETAILCODE c
	WHERE a.SEAT_FIX_USERYN = 'Y'
		  AND a.SEAT_FIX_USER_ID = b.EMPNO
		  AND b.PRE_WORKINFO = c.CODE
	UNION ALL
	SELECT case b.AUTHOR_CODE when 'ROLE_USER' then 
	          (select COM_NAME from TB_COMPANYINFO e where b.COM_CODE = e.COM_CODE)
			  else b.DEPTNAME
			end DEPTNAME, 
	b.EMPNAME, CONCAT(d.FLOOR_NAME, ' ' , a.SEAT_NAME) SEAT_NAME, c.RES_STARTTIME, c.RES_ENDTIME
	FROM TB_SEATINFO a, TB_EMPINFO b, TB_SWCRESERVATION c, TB_FLOORINFO d
	WHERE a.SEAT_ID = c.ITEM_ID
		  AND b.EMPNO = c.USER_ID
		  AND a.FLOOR_SEQ = d.FLOOR_SEQ
		  AND c.RES_STARTDAY = convert(varchar(8), getdate(), 112)
		  AND REPLACE(SUBSTRING(CONVERT (VARCHAR(12),  GETDATE(), 114), 1,5), ':','')  between c.RES_STARTTIME and c.RES_ENDTIME

end 

GO
/****** Object:  StoredProcedure [dbo].[SP_KIOSKCALDARLIST]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_KIOSKCALDARLIST] @ITEM_ID varchar(30)

as
begin
        SELECT RES_TITLE,  dbo.FN_ATTENTLIST(a.RES_ATTENDLIST) RES_ATTENDLIST, 
		       CONCAT(CONVERT (DATE, a.RES_STARTDAY)   ,'T', dbo.FN_TIMESPLIT(a.RES_STARTTIME), ':00') RES_STARTTIME , 
               CONCAT(CONVERT (DATE, a.RES_STARTDAY)  ,'T', dbo.FN_TIMESPLIT(dbo.FN_UPSTIMEDOWN(a.RES_ENDTIME)), ':00') RES_ENDTIME,
		       CONCAT(b.EMPNAME, '|' , b.DEPTNAME)  EMPNAME,
		       a.RES_SEQ 
		FROM TB_SWCRESERVATION a , TB_EMPINFO   b
		WHERE ITEM_ID  = @ITEM_ID
              AND RES_STARTDAY = CONVERT(VARCHAR(8), GETDATE(), 112)
              AND  RES_ENDTIME >= REPLACE(SUBSTRING(CONVERT (VARCHAR(12), DATEADD(minute, -30, GETDATE()), 114), 1,5), ':','') 
              AND a.USER_ID = b.EMPNO 
              AND a.RESERV_PROCESS_GUBUN in ( 'PROCESS_GUBUN_1', 'PROCESS_GUBUN_2', 'PROCESS_GUBUN_4')


end 
GO
/****** Object:  StoredProcedure [dbo].[SP_MAXVAL]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_RESINFO]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_RESINFO] (@RES_SEQ int )
as
begin
    declare @ITEM_GUBUN varchar(20);

	set @ITEM_GUBUN = (select ITEM_GUBUN from TB_SWCRESERVATION where RES_SEQ = @RES_SEQ)

	if (@ITEM_GUBUN != 'ITEM_GUBUN_2')
		BEGIN
			 SELECT  a.RES_SEQ, a.ITEM_ID, a.ITEM_GUBUN, a.CENTER_ID, dbo.FN_DETAILCODENM(a.RES_GUBUN) resGubunTxt,   
					a.RES_GUBUN, a.USER_ID, a.DEPT_ID,  
					CONVERT (DATE, a.RES_STARTDAY) resStartday,
					CONVERT (DATE, a.RES_ENDDAY) resEndday,
					a.RES_ENDDAY, dbo.FN_TIMESPLIT(a.RES_STARTTIME) resStarttime , dbo.FN_TIMESPLIT(dbo.fn_upsTimedown(a.RES_ENDTIME)) resEndtime, 
					dbo.FN_DETAILCODENM(a.RESERV_PROCESS_GUBUN) AS reservProcessGubunTxt ,
					a.REG_DATE, a.RESERV_PROCESS_GUBUN, a.RESERVATION_REASON, a.CANCEL_REASON, 
					dbo.FN_DETAILCODENM(a.CANCEL_CODE) cancelCodeTxt, a.CANCEL_CODE, a.PROXY_YN, a.PROXY_USER_ID, a.UPDATE_DATE,
					a.UPDATE_ID, a.RES_REPLY_DATE, a.ADMIN_REPLY_DATE, a.ADMIN_PROCESS_GUBUN,  a.USE_YN,
					b.DEPTCODE, b.EMPMAIL, b.EMPNAME,  b.DEPTNAME, b.EMPHANDPHONE, b.EMPNO,
					b.AVAYA_USERID, a.RES_PASSWORD, a.MEETING_SEQ, a.RES_ATTENDLIST, a.RES_TITLE,
					a.MEETINGLOG, a.RES_FILE1, a.RES_FILE2, 
					dbo.FN_ATTENTLIST(a.RES_ATTENDLIST) attendListTxt    ,
					CASE WHEN a.RES_PASSWORD = 'N' THEN  '비공개' ELSE '공개' end as resPassTxt,
					CASE a.PROXY_YN WHEN 'N' THEN '대리예약'  ELSE '본인'  END proxyYnTxt,
					a.CONFERENCE_ID, a.CON_NUMBER, a.CON_PIN, 
                    a.TENN_CNT, a.FLOOR_SEQ, a.IN_TIME, a.OT_TIME, a.SEND_MESSAGE, a.RES_PERSON, a.RES_REMARK, 
					c.CENTER_NM, e.FLOOR_NAME,
                    a.CON_VIRTUAL_PIN, CON_ALLOWSTREAM, CON_BLACKDIAL, CON_SENDNOTI, 
					CONVERT(VARCHAR, CONVERT(DATETIME, CONCAT(a.RES_STARTDAY,' ', dbo.fn_TimeSplit(a.RES_STARTTIME), ':00')) , 20)  resDayInfo,
					CONVERT(VARCHAR, CONVERT(DATETIME, CONCAT(a.RES_STARTDAY,' ', dbo.fn_TimeSplit(dbo.fn_upsTimedown(a.RES_ENDTIME)) , ':00')) , 20)  resDayEndInfo,
					--dbo.FN_DURATION(dbo.FN_UPSTIMEDOWN(a.RES_ENDTIME ), a.RES_STARTTIME ) resDurationT,
					d.MEETING_NAME ITME_NAME, 
					d.AVAYA_CONFI_ID, d.AVAYA_USERID, d.TERMINAL_ID, d.END_NAME, d.TERMINAL_NUMBER,
					d.TERMINAL_TEL, d.USER_FIRST_NM, d.USER_LAST_NM, d.USER_EMAIL , 
					d.MEETING_CONFIRMGUBUN, d.MEETING_EQUPGUBUN, a.RES_EQUPINFO, a.RES_EQUPCHECK,
					d.MEETING_ADMINID, d.MAIL_SENDCHECK, d.SMS_SENDCHECK
					, CASE d.MAIL_SENDCHECK WHEN 'Y' THEN  dbo.FN_MESSAGETITLE( d.RES_MESSAGE_MAIL )
							ELSE '메세지 없음' 
						END resMessageMailTxt
					, CASE d.MAIL_SENDCHECK WHEN 'Y' THEN dbo.FN_MESSAGECONTENT( d.RES_MESSAGE_MAIL )
							ELSE '메세지 없음' 
						END resMessageMailContextTxt
					, CASE d.SMS_SENDCHECK WHEN 'Y' THEN dbo.FN_MESSAGETITLE( d.RES_MESSAGE_SMS )
							ELSE '메세지 없음' 
						END resMessageSmsTxt
					, CASE d.MAIL_SENDCHECK WHEN 'Y' THEN dbo.FN_MESSAGETITLE( d.CAN_MESSAGE_MAIL )
							ELSE '메세지 없음' 
						END canMessageMailTxt
					, CASE d.MAIL_SENDCHECK WHEN 'Y' THEN dbo.FN_MESSAGECONTENT( d.CAN_MESSAGE_MAIL )
							ELSE '메세지 없음' 
						END resMessageMailContextTxt
					, CASE d.SMS_SENDCHECK WHEN 'Y' THEN dbo.FN_MESSAGETITLE( d.CAN_MESSAGE_SMS )
							ELSE '메세지 없음' 
						END canMessageSmsTxt
			 FROM TB_SWCRESERVATION a, TB_EMPINFO b, TB_CENTERINFO c, TB_FLOORINFO e, TB_MEETING_ROOM d
			 WHERE a.USER_ID = b.EMPNO 
					AND a.ITEM_ID = d.MEETING_ID
					AND a.CENTER_ID = c.CENTER_ID
					AND a.FLOOR_SEQ = e.FLOOR_SEQ
					AND a.RES_SEQ = @RES_SEQ   

		END 
	else 
		BEGIN
			SELECT  a.RES_SEQ, a.ITEM_ID, a.ITEM_GUBUN, a.CENTER_ID, dbo.FN_DETAILCODENM(a.RES_GUBUN) resGubunTxt,   
					a.RES_GUBUN, a.USER_ID, a.DEPT_ID,  
					CONVERT (DATE, a.RES_STARTDAY) resStartday,
					a.RES_ENDDAY, dbo.FN_TIMESPLIT(a.RES_STARTTIME) resStarttime , dbo.FN_TIMESPLIT(dbo.fn_upsTimedown(a.RES_ENDTIME)) resEndtime, 
					dbo.FN_DETAILCODENM(a.RESERV_PROCESS_GUBUN) AS reservProcessGubunTxt ,
					a.REG_DATE, a.RESERV_PROCESS_GUBUN, a.RESERVATION_REASON, a.CANCEL_REASON, 
					dbo.FN_DETAILCODENM(a.CANCEL_CODE) cancelCodeTxt, a.CANCEL_CODE, a.PROXY_YN, a.PROXY_USER_ID, a.UPDATE_DATE,
					a.UPDATE_ID, a.RES_REPLY_DATE, a.ADMIN_REPLY_DATE, a.ADMIN_PROCESS_GUBUN, a.USE_YN,
					a.TENN_CNT, a.FLOOR_SEQ, a.IN_TIME, a.OT_TIME, a.SEND_MESSAGE, a.RES_PERSON, a.RES_REMARK,
					a.RES_TITLE,a.RES_PASSWORD, c.CENTER_NM, e.FLOOR_NAME,
                    b.DEPTCODE, b.EMPMAIL, b.EMPNAME, b.DEPTNAME, b.EMPHANDPHONE, b.EMPNO,
					a.MEETINGLOG, a.RES_FILE1, a.RES_FILE2,
					dbo.FN_ATTENTLIST(a.RES_ATTENDLIST) attendListTxt    ,
					CASE WHEN a.RES_PASSWORD = 'N' THEN  '비공개' ELSE '공개' end as resPassTxt,
					CASE a.PROXY_YN WHEN 'P' THEN '승인 요청'  ELSE '본인'  END proxyYnTxt,
					CONVERT(VARCHAR, CONVERT(DATETIME, CONCAT(a.RES_STARTDAY,' ', dbo.fn_TimeSplit(a.RES_STARTTIME), ':00')) , 20)  resDayInfo,
					CONVERT(VARCHAR, CONVERT(DATETIME, CONCAT(a.RES_STARTDAY,' ', dbo.fn_TimeSplit(dbo.fn_upsTimedown(a.RES_ENDTIME)) , ':00')) , 20)  resDayEndInfo,
					a.RES_EQUPINFO, a.RES_EQUPCHECK,
					d.SEAT_CONFIRMGUBUN, d.SEAT_NAME ITME_NAME
	    FROM TB_SWCRESERVATION a, TB_EMPINFO b,  TB_CENTERINFO c, TB_FLOORINFO e, TB_SEATINFO d
	    WHERE a.USER_ID = b.EMPNO 
			  AND a.ITEM_ID = d.SEAT_ID
			  AND a.CENTER_ID = c.CENTER_ID
			  AND a.FLOOR_SEQ = e.FLOOR_SEQ
			  AND a.RES_SEQ = @RES_SEQ 

		END 

end 
GO
/****** Object:  StoredProcedure [dbo].[sp_Room_TimeCreate]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Room_TimeCreate] 
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
				     SET @vt_swc_roomID = ( SELECT TOP 1 MEETING_ID  FROM TB_MEETING_ROOM WHERE MEETING_USEYN = 'Y'  ORDER BY MEETING_ID ASC  )
				 END 
			 ELSE 
				 BEGIN
				     SET @vt_swc_roomID = (  SELECT TOP 1 MEETING_ID FROM tb_meeting_room WHERE MEETING_USEYN = 'Y' AND MEETING_ID > @vt_swc_roomID  ORDER BY MEETING_ID ASC  );
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
  
	SET @vt_nowDay = (select  convert(varchar(8), getdate(), 112));
	WHILE (@vt_nowDay < @vt_nextDay) 
	BEGIN
	     SET @vt_nowDay =  (select  CONVERT(varchar(8),DATEADD(DAY,  1, @vt_nowDay), 112));
         SET @vt_SWCRoomCount = (SELECT isnull(COUNT(*),0) FROM TB_SEATINFO WHERE SEAT_USEYN = 'Y' AND SEAT_GUBUN = 'SEAT_GUBUN_2');
		 SET @vt_RoomNowCount = 0;

		 WHILE (@vt_RoomNowCount < @vt_SWCRoomCount) 
		 BEGIN
		      BEGIN
			 -- 좌석 정리 
		     IF (@vt_RoomNowCount = 0) 
				 BEGIN
				     SET @vt_swc_roomID = ( SELECT TOP 1 SEAT_ID  FROM TB_SEATINFO WHERE SEAT_USEYN = 'Y' AND SEAT_GUBUN = 'SEAT_GUBUN_2'  ORDER BY SEAT_ID ASC  )
				 END 
			 ELSE 
				 BEGIN
				     SET @vt_swc_roomID = (  SELECT TOP 1 SEAT_ID FROM TB_SEATINFO WHERE SEAT_USEYN = 'Y' AND SEAT_GUBUN = 'SEAT_GUBUN_2'  AND SEAT_ID > @vt_swc_roomID  ORDER BY SEAT_ID ASC  );
				 END 
             END 
			 SET @vt_centerID = (SELECT CENTER_ID FROM TB_SEATINFO  WHERE  SEAT_ID = @vt_swc_roomID);

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

END 



GO
/****** Object:  StoredProcedure [dbo].[SP_TENNPAYMENT]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_TENNPAYMENT] 
as
begin

    declare @tennCnt int
	set @tennCnt = (select TENN_MONTHCNT from TB_SWCINFO)


	                        
    
	  --  이전 달 테넌트 회수 
	 INSERT INTO TB_COMPAY_TENNANT_HISTORY (TENN_SEQ, COM_CODE, USER_NO, REG_DATE, TENN_CNT, TENN_PLAY_GUBUN, TENN_APPRIVAL, RES_SEQ)   
     SELECT TENN_SEQ, COM_CODE, 'admin', getdate(), TENN_REC_NOW_CNT, 'TENN_PLAY_GUBUN_3', 'Y', 0 
     FROM [dbo].[TB_COMPAY_TENNANT] 
     WHERE convert(varchar(8),   dateadd(MONTH, 1, [REG_DATE]), 112) = convert(varchar(8) , getdate(), 112) 
              AND TENN_REC_NOW_CNT > 0
  
     UPDATE TB_COMPAY_TENNANT set TENN_REC_NOW_CNT = 0, TENN_REC_COUNT = TENN_REC_COUNT
     WHERE convert(varchar(8),   dateadd(MONTH, 1, [REG_DATE]), 112) = convert(varchar(8) , getdate(), 112) 
              AND TENN_REC_NOW_CNT > 0

     declare @tennCnt int
	 set @tennCnt = (select TENN_MONTHCNT from TB_SWCINFO)
     -- 이번달 테넌트 지급                  
     
	 INSERT INTO TB_COMPAY_TENNANT(COM_CODE, TENN_REC_DATE, TENN_REC_COUNT, TENN_REC_PLAY_CNT, 
									   TENN_REC_NOW_CNT, TENN_REC_END, TENN_REMARK,
									   REG_DATE, UPDATE_DATE)

	 SELECT COM_CODE, CONVERT(varchar(8), getdate(), 112), isnull(COM_TENNENT_CNT,@tennCnt), 0, isnull(COM_TENNENT_CNT,@tennCnt), 'Y', '크레딧 배포' , getdate(), getdate() 
	 FROM TB_COMPANYINFO
	 WHERE TENN_USEYN = 'Y'
    
                                    
     INSERT INTO   TB_COMPAY_TENNANT_HISTORY (COM_CODE, REG_DATE, TENN_CNT, TENN_PLAY_GUBUN, TENN_APPRIVAL,TENN_SEQ)
	 SELECT COM_CODE ,  getdate(), isnull(COM_TENNENT_CNT,@tennCnt), 'TENN_PLAY_GUBUN_1', 'Y', (SELECT ISNULL(MAX(TENN_SEQ),1) 
	                                                                    FROM tb_compay_tennant 
																		WHERE tb_compay_tennant.COM_CODE = TB_COMPANYINFO.COM_CODE)
	 FROM TB_COMPANYINFO
	 WHERE TENN_USEYN = 'Y'
	 
	 -- 인사 정보 업데이트 
	 UPDATE TB_EMPINFO set PRE_WORKINFO =  NOW_WORKINFO , NOW_WORKINFO = ''
     WHERE AUTHOR_CODE != 'ROLE_USER' and NOW_WORKINFO != ''
           AND PRE_WORKINFO != NOW_WORKINFO
     

end 
GO
/****** Object:  StoredProcedure [dbo].[SP_UNICHECK]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE proc [dbo].[SP_UNICHECK] (@isColumn varchar(25), @isTable VARCHAR(255), @isCondition varchar(1000) )
 as
 begin
     
	   
	   DECLARE @stmt nvarchar(4000);
	   SET @stmt = ' SELECT ISNULL(COUNT( '+ @isColumn + '  ),0) CNT   FROM '+ @isTable + '  where ' +    replace(    @isCondition  , '[','''') ;
       EXEC sp_executesql @stmt  

 end 
GO
/****** Object:  StoredProcedure [dbo].[SP_UNIDEL]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UNISELECT]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UNIUPDATE]    Script Date: 2021-07-01 오후 3:37:07 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UserPassChange]    Script Date: 2021-07-01 오후 3:37:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_UserPassChange] (@userNo varchar(30),
                               @nowPassword varchar(30),
                               @newPassword varchar(30),  
							   @Result int output
							   )
as
begin

   declare @ckCnt int 
   set @ckCnt = (select isnull(count(*), 0)
                 from TB_USERINFO 
				 WHERE USER_NO = @userNo
				       AND USER_PASSWORD = @nowPassword)
   if (@ckCnt > 0)
   begin
       update TB_USERINFO set USER_PASSWORD = @newPassword
	   where USER_NO = @userNo AND USER_PASSWORD = @nowPassword

	   set @Result = 1;
   end
   else 
   begin
       set @Result = -1;
   end 


end 

create function FN_RESSTATEINFO (@RES_SEQ int )
returns varchar(100)
begin
   
   declare @res_state varchar(100);
   set  @res_state = ( 
                       SELECT CONCAT( RES_TITLE, '|',
							  CASE WHEN RES_STARTDAY > convert(varchar(8), getdate(), 112) THEN 'after'
								   WHEN (RES_STARTDAY =  convert(varchar(8), getdate(), 112) AND  
										REPLACE(SUBSTRING(CONVERT(VARCHAR(12), GETDATE(), 114), 1,5), ':','') <  RES_STARTTIME) THEN 'after'
								   WHEN (RES_STARTDAY =  convert(varchar(8), getdate(), 112) AND  
										REPLACE(SUBSTRING(CONVERT(VARCHAR(12), GETDATE(), 114), 1,5), ':','')  BETWEEN RES_STARTTIME AND RES_ENDTIME) THEN 'now' 
								   ELSE 'before'
								   END )
					   FROM TB_SWCRESERVATION
					   WHERE RES_SEQ = @RES_SEQ
					   )
   return @res_state
end 

GO
USE [master]
GO
ALTER DATABASE [SMART_WORK] SET  READ_WRITE 
GO


create proc SP_PLAYTENNENT (@USER_ID varchar(20),
                            @TENN_SEQ int,
							@TENN_CNT int,
							@RES_SEQ int ,
							@result varchar(30) output
                            )
as
begin try
      
	   declare @COM_CODE varchar(10)
	   set @COM_CODE = (select COM_CODE from TB_USERINFO where USER_NO = @USER_ID)

	   UPDATE  TB_COMPAY_TENNANT SET TENN_REC_PLAY_CNT = TENN_REC_PLAY_CNT + @TENN_CNT
		                                 , TENN_REC_NOW_CNT = TENN_REC_NOW_CNT - @TENN_CNT
		                                 , UPDATE_DATE = getdate()
		                                 , UPDATE_ID = @USER_ID
	   WHERE TENN_SEQ = @TENN_SEQ   ;


	   INSERT INTO TB_COMPAY_TENNANT_HISTORY (TENN_SEQ, COM_CODE, USER_NO, REG_DATE, TENN_CNT, TENN_PLAY_GUBUN, TENN_APPRIVAL, RES_SEQ)   
	   VALUES (@TENN_SEQ, @COM_CODE , @USER_ID, getdate(), @TENN_CNT, 'TENN_PLAY_GUBUN_2', 'Y', @RES_SEQ);


	   set @result = 'OK'
	   return @result
end try
begin catch 
       set @result= ( select ERROR_MESSAGE() );
	   INSERT INTO TB_ERRRORINFO (ERR_PROC, ERR_PROC_REGDATE, ERR_PROC_ERRORMESSAGE)
	   VALUES ('SP_PLAYTENNENT', GETDATE(), @result)
       return @result
end catch 



create proc SP_TENN_CANCEL (@HIS_SEQ int, @result varchar(30) output )
as
begin try
     UPDATE TB_COMPAY_TENNANT SET TENN_REC_PLAY_CNT = TENN_REC_PLAY_CNT - b.TENN_CNT, 
			                      TENN_REC_NOW_CNT  = TENN_REC_NOW_CNT +  b.TENN_CNT
			
     FROM  TB_COMPAY_TENNANT a, TB_COMPAY_TENNANT_HISTORY b
	 WHERE a.TENN_SEQ = b.TENN_SEQ 
		   AND b.HIS_SEQ = @HIS_SEQ

     UPDATE TB_COMPAY_TENNANT_HISTORY SET TENN_PLAY_GUBUN = 'TENN_PLAY_GUBUN_4' where HIS_SEQ = @HIS_SEQ
	 set @result = 'OK'
	 return @result
end try
begin catch 
     set @result= ( select ERROR_MESSAGE() );
	 INSERT INTO TB_ERRRORINFO (ERR_PROC, ERR_PROC_REGDATE, ERR_PROC_ERRORMESSAGE)
	 VALUES ('SP_TENN_CANCEL', GETDATE(), @result)
       return @result

end catch 
