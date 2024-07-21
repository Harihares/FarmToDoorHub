package com.show;

public class Feedback {
    private int customerId;
    private String customerName;
    private String feedback;

    // Constructor
    public Feedback(int customerId, String customerName, String feedback) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.feedback = feedback;
    }

    // Getter methods
    public int getCustomerId() {
        return customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public String getFeedback() {
        return feedback;
    }
}
