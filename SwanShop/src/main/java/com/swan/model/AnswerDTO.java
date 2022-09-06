package com.swan.model;


import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class AnswerDTO {

	private int a_id;
	private int q_id;
	private String member_id;
	
	/*
	 * Gson, Jackson 라이브러리를 사용해서 Date, LocalDateTime 타입의 데이터를 json으로 변환할 경우 "yyyy-MM-dd" 형식 변환되지 않는다고 함. 
	 * 따라서 json으로 변환 대상인 Date, LocalDateTime 타입의 데이터에 어떠한 형식(포맷)으로 변환할지를 지정 해주면 된다고 함.
	 * 
	 * 
	 * */
	
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date a_create_date;
	private String content;
	
	public AnswerDTO() {}

	public AnswerDTO(int a_id, int q_id, String member_id, Date a_create_date, String content) {
		super();
		this.a_id = a_id;
		this.q_id = q_id;
		this.member_id = member_id;
		this.a_create_date = a_create_date;
		this.content = content;
	}

	public int getA_id() {
		return a_id;
	}

	public void setA_id(int a_id) {
		this.a_id = a_id;
	}

	public int getQ_id() {
		return q_id;
	}

	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Date getA_create_date() {
		return a_create_date;
	}

	public void setA_create_date(Date a_create_date) {
		this.a_create_date = a_create_date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "AnswerDTO [a_id=" + a_id + ", q_id=" + q_id + ", member_id=" + member_id + ", a_create_date="
				+ a_create_date + ", content=" + content + "]";
	}
}
