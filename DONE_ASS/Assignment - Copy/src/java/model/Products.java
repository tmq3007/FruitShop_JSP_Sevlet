/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Products {

    private int id;
    private String name;
    private int categoryId;
    private double unitPrice;
    private String imgURL;
    private String desciption;
    private int quantity;
    private double discount;

    public Products() {
    }

    public Products(int id, String name, int categoryId, double unitPrice, String imgURL, String desciption, int quantity, double discount) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId;
        this.unitPrice = unitPrice;
        this.imgURL = imgURL;
        this.desciption = desciption;
        this.quantity = quantity;
        this.discount = discount;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public String getDesciption() {
        return desciption;
    }

    public void setDesciption(String desciption) {
        this.desciption = desciption;
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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public String getFormattedUnitPrice() {
        double formattedPrice = getUnitPrice() - getUnitPrice()*getDiscount();
        // Convert to String with two decimal places
        return String.format("%.2f", formattedPrice);
    }
      public double getDiscountedUnitPrice() {
        return getUnitPrice() - getUnitPrice() * getDiscount();
    }
    public int getDiscountInt() {
    return (int) (discount * 100);
}


    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

    @Override
    public String toString() {
        return "Products{" + "id=" + id + ", name=" + name + ", categoryId=" + categoryId + ", unitPrice=" + unitPrice + ", imgURL=" + imgURL + ", desciption=" + desciption + ", quantity=" + quantity + '}';
    }

}
