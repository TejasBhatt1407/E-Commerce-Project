package com.ecommerce.model;

public class Seller {
	private int id;
	private String name;
	private String email;
	private String mobile;
	private String password;
	private String companyName;
	private String GSTnum;
	private String bankName;
	private String address;

	public Seller() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String mail) {
		this.email = mail;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mob) {
		this.mobile = mob;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String pass) {
		this.password = pass;
	}
	
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String compName) {
		this.companyName = compName;
	}
	public String getGSTNum() {
		return GSTnum;
	}

	public void setGSTNum(String GST) {
		this.GSTnum = GST;
	}
	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}