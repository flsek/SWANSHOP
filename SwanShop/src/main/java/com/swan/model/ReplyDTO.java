package com.swan.model;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReplyDTO {
	private int reply_id;
	private int product_id;
	private String member_id;
	
	/*
	 * Gson, Jackson 라이브러리를 사용해서 Date, LocalDateTime 타입의 데이터를 json으로 변환할 경우 "yyyy-MM-dd" 형식 변환되지 않는다고 함. 
	 * 따라서 json으로 변환 대상인 Date, LocalDateTime 타입의 데이터에 어떠한 형식(포맷)으로 변환할지를 지정 해주면 된다고 함.
	 * 
	 * 
	 * */
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date regdate;
	private String content;
	private double rating;
	
	public ReplyDTO() {}
	
	public ReplyDTO(int reply_id, int product_id, String member_id, Date regdate, String content, double rating) {
		super();
		this.reply_id = reply_id;
		this.product_id = product_id;
		this.member_id = member_id;
		this.regdate = regdate;
		this.content = content;
		this.rating = rating;
	}

	public int getReply_id() {
		return reply_id;
	}

	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	@Override
	public String toString() {
		return "ReplyDTO [reply_id=" + reply_id + ", product_id=" + product_id + ", member_id=" + member_id
				+ ", regdate=" + regdate + ", content=" + content + ", rating=" + rating + "]";
	}
	
	
}
