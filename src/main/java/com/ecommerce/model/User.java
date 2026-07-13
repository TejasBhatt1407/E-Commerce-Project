package com.ecommerce.model;

public class User {
	private int id;
	private String name;
	private String email;
	private String mobile;
	private String password;

	public User() {

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

}