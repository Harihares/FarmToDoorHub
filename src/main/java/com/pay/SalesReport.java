package com.pay;

import java.util.Date;

public class SalesReport {
    private Date transactionDate;
    private String itemName;
    private int totalQuantitySold;
    private int totalRevenue;

    public SalesReport(Date transactionDate, String itemName, int totalQuantitySold, int totalRevenue) {
        this.transactionDate = transactionDate;
        this.itemName = itemName;
        this.totalQuantitySold = totalQuantitySold;
        this.totalRevenue = totalRevenue;
    }

    // Getters and Setters
    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getTotalQuantitySold() {
        return totalQuantitySold;
    }

    public void setTotalQuantitySold(int totalQuantitySold) {
        this.totalQuantitySold = totalQuantitySold;
    }

    public int getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(int totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}
