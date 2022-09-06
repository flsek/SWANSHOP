package com.swan.model;

import java.sql.Date;

public class MemberVO {
	private String id; // 회원 아이디
	private String pwd; // 회원 비밀번호
	private String name; // 회원 이름
	private String phone; // 회원 전화번호
	private String email; // 회원 이메일
	private String gender; // 회원 성별
	private String address; // 회원 주소
	private String address2; // 회원 상세주소
	private Date joindate; // 등록일자
	private String member_status; // 회원 상태
	private int admin_ck; // 관리자 구분(0: 일반 사용자, 1: 관리자)

	public MemberVO() {}

	public MemberVO(String id, String pwd, String name, String phone, String email, String gender, String address,
			String address2, Date joindate, String member_status, int admin_ck) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.gender = gender;
		this.address = address;
		this.address2 = address2;
		this.joindate = joindate;
		this.member_status = member_status;
		this.admin_ck = admin_ck;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public Date getJoindate() {
		return joindate;
	}

	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}

	public String getMember_status() {
		return member_status;
	}

	public void setMember_status(String member_status) {
		this.member_status = member_status;
	}

	public int getAdmin_ck() {
		return admin_ck;
	}

	public void setAdmin_ck(int admin_ck) {
		this.admin_ck = admin_ck;
	}

	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", pwd=" + pwd + ", name=" + name + ", phone=" + phone + ", email=" + email
				+ ", gender=" + gender + ", address=" + address + ", address2=" + address2 + ", joindate=" + joindate
				+ ", member_status=" + member_status + ", admin_ck=" + admin_ck + "]";
	}
	
	
	
	
}
