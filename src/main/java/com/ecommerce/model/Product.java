package com.ecommerce.model;

public class Product {

	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", type=" + type + ", subType=" + subType + ", price=" + price
				+ ", quantity=" + quantity + ", description=" + description + ", cartQuantity=" + cartQuantity
				+ ", longDescription=" + longDescription + ", image=" + image + "]";
	}

	private int id;
	private String name;
	private String type;
	private String subType;
	private int price;
	private int quantity;
	private String description;
	private int cartQuantity;
	private String longDescription;
	private String image;
	private String typeIcon;
	private String subtypeIcon;

	public Product() {
	}

	public Product(int id, String name, String type, String subType, int price, int quantity, String description,String longDescription,String image) {
		this.id = id;
		this.name = name;
		this.type = type;
		this.subType = subType;
		this.price = price;
		this.quantity = quantity;
		this.description = description;
		this.longDescription=longDescription;
		this.image=image;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	public int getCartQuantity() {
		return cartQuantity;
	}
	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity=cartQuantity;
	}
	public String getLongDescription() {
	    return longDescription;
	}

	public void setLongDescription(String longDescription) {
	    this.longDescription = longDescription;
	}

	public String getImage() {
	    return image;
	}

	public void setImage(String image) {
	    this.image = image;
	}
	
	public String getTypeIcon() {
	    return typeIcon;
	}

	public void setTypeIcon(String typeIcon) {
	    this.typeIcon = typeIcon;
	}
	
	public void setSubtypeIcon(String subtypeIcon) {
		this.subtypeIcon=subtypeIcon;
	}
	public String getSubtypeIcon() {
		return subtypeIcon;
	}
	
}