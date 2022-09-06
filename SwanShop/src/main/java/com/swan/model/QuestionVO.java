package com.swan.model;

import java.sql.Date;

public class QuestionVO {
	private int q_id;
	private String q_title;
	private String q_writer;
	private String q_content;
	private String q_count;
	private Date q_create_date;
	private Date q_modify_date;
	
	public QuestionVO() {}

	public QuestionVO(int q_id, String q_title, String q_writer, String q_content, String q_count, Date q_create_date,
			Date q_modify_date) {
		super();
		this.q_id = q_id;
		this.q_title = q_title;
		this.q_writer = q_writer;
		this.q_content = q_content;
		this.q_count = q_count;
		this.q_create_date = q_create_date;
		this.q_modify_date = q_modify_date;
	}

	public int getQ_id() {
		return q_id;
	}

	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}

	public String getQ_title() {
		return q_title;
	}

	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}

	public String getQ_writer() {
		return q_writer;
	}

	public void setQ_writer(String q_writer) {
		this.q_writer = q_writer;
	}

	public String getQ_content() {
		return q_content;
	}

	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}

	public String getQ_count() {
		return q_count;
	}

	public void setQ_count(String q_count) {
		this.q_count = q_count;
	}

	public Date getQ_create_date() {
		return q_create_date;
	}

	public void setQ_create_date(Date q_create_date) {
		this.q_create_date = q_create_date;
	}

	public Date getQ_modify_date() {
		return q_modify_date;
	}

	public void setQ_modify_date(Date q_modify_date) {
		this.q_modify_date = q_modify_date;
	}

	@Override
	public String toString() {
		return "QuestionVO [q_id=" + q_id + ", q_title=" + q_title + ", q_writer=" + q_writer + ", q_content="
				+ q_content + ", q_count=" + q_count + ", q_create_date=" + q_create_date + ", q_modify_date="
				+ q_modify_date + "]";
	}

}
