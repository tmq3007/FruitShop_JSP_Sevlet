/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Customer {
    private int customerId;
    private String customerName;
    private String contactName;
    private String address;
    private String city;
    private String phoneNumber;
    private String country;
    private int accountId;

    public Customer() {
    }

    public Customer(int customerId, String customerName, String contactName, String address, String city, String phoneNumber, String country, int accountId) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.contactName = contactName;
        this.address = address;
        this.city = city;
        this.phoneNumber = phoneNumber;
        this.country = country;
        this.accountId = accountId;
    }
public Customer(String customerName, String contactName, String address, String city, String phoneNumber, String country, int accountId) {
        
        this.customerName = customerName;
        this.contactName = contactName;
        this.address = address;
        this.city = city;
        this.phoneNumber = phoneNumber;
        this.country = country;
        this.accountId = accountId;
    }
    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @Override
    public String toString() {
        return "Customer{" + "customerId=" + customerId + ", customerName=" + customerName + ", contactName=" + contactName + ", address=" + address + ", city=" + city + ", phoneNumber=" + phoneNumber + ", country=" + country + ", accountId=" + accountId + '}';
    }

 
    
}
