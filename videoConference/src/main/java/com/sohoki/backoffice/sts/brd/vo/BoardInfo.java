package com.sohoki.backoffice.sts.brd.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class BoardInfo implements Serializable {


	private String boardSeq;							//게시물시퀀스
	private String boardTitle;							//게시물 제목
	private String boardNoticeUseyn;				//공지사용여부
	private String boardNoticeStartday;			//공지시작일자
	private String boardNoticeEndday;				//공지종료일자
	private String boardGubun;						//게시판구분
	private String boardContent;						//게시물 내용
	private String boardReturnContent;			//
	private String boardRegdate;						//등록일자
	private String boardRegId;						//등록자 사번
	private String boardUpdateDate;				//업데이트일자
	private String boardUpdateId;					//업데이트한 사번
	private String boardFile01;						//파일01
	private String boardFile02;						//파일02
	private String boardViewYn;						//노출여부
	private String boardFaqGubun;					//
	private String boardVisited;						//조회수
	private String mode;								//
	private String boardGubunTitle;					//
	private String boardTopSeq;
	
	private String emphandphone = "";
	private String emptelphone = "";
	private String empemail = "";
	private String userId;
	private String userNm = "";
	private String deptname = "";
	
	
	
}
