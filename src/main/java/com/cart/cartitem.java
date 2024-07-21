package com.cart;

import java.util.Arrays;

public class cartitem {
	
	public String itemname;
	public int itemquantity;
	public int itemprice;
	public byte[]itemimage;
	
	public cartitem(String itemname, int itemquantity, int itemprice, byte[] itemimage) {
		
		this.itemname = itemname;
		this.itemquantity = itemquantity;
		this.itemprice = itemprice;
		this.itemimage = itemimage;
	}
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
	public String getItemname()
	{
		return itemname;
	}
	public int getItemquantity() {
		return itemquantity;
	}
	public void setItemquantity(int itemquantity) {
		this.itemquantity = itemquantity;
	}
	public int getItemprice() {
		return itemprice;
	}
	public void setItemprice(int itemprice) {
		this.itemprice = itemprice;
	}
	public byte[] getItemimage() {
		return itemimage;
	}
	public void setItemimage(byte[] itemimage) {
		this.itemimage = itemimage;
	}
	//@Override
	//public String toString() {
		//return "Cart [itemname=" + itemname + ", itemquantity=" + itemquantity + ", itemprice=" + itemprice
			///	+ ", itemimage=" + Arrays.toString(itemimage) + "]";
	}
	
