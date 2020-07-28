/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.tblBooking;

import java.io.Serializable;


/**
 *
 * @author Admin
 */
public class TblBookingDTO implements Serializable{
    private int bookingID;
    private float totalPrice;
    private String userID, discountID, orderDateTime, expiryDateTime;
    private int statusID;
    
    
    public TblBookingDTO() {
    }

    public TblBookingDTO(int bookingID, float totalPrice, String userID, String discountID, String orderDateTime, String expiryDateTime) {
        this.bookingID = bookingID;
        this.totalPrice = totalPrice;
        this.userID = userID;
        this.discountID = discountID;
        this.orderDateTime = orderDateTime;
        this.expiryDateTime = expiryDateTime;
    }

    public TblBookingDTO(int bookingID, float totalPrice, String userID, String discountID, String orderDateTime, String expiryDateTime, int statusID) {
        this.bookingID = bookingID;
        this.totalPrice = totalPrice;
        this.userID = userID;
        this.discountID = discountID;
        this.orderDateTime = orderDateTime;
        this.expiryDateTime = expiryDateTime;
        this.statusID = statusID;
    }

    public TblBookingDTO(int bookingID) {
        this.bookingID = bookingID;
    }
    
    
   
    /**
     * @return the bookingID
     */
    public int getBookingID() {
        return bookingID;
    }

    /**
     * @param bookingID the bookingID to set
     */
    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    /**
     * @return the totalPrice
     */
    public float getTotalPrice() {
        return totalPrice;
    }

    /**
     * @param totalPrice the totalPrice to set
     */
    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    /**
     * @return the userID
     */
    public String getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(String userID) {
        this.userID = userID;
    }

    /**
     * @return the discountID
     */
    public String getDiscountID() {
        return discountID;
    }

    /**
     * @param discountID the discountID to set
     */
    public void setDiscountID(String discountID) {
        this.discountID = discountID;
    }

    /**
     * @return the orderDateTime
     */
    public String getOrderDateTime() {
        return orderDateTime;
    }

    /**
     * @param orderDateTime the orderDateTime to set
     */
    public void setOrderDateTime(String orderDateTime) {
        this.orderDateTime = orderDateTime;
    }

    /**
     * @return the expiryDateTime
     */
    public String getexpiryDateTime() {
        return getExpiryDateTime();
    }

    /**
     * @param expiryDateTime the expiryDateTime to set
     */
    public void setexpiryDateTime(String expiryDateTime) {
        this.setExpiryDateTime(expiryDateTime);
    }

    /**
     * @return the expiryDateTime
     */
    public String getExpiryDateTime() {
        return expiryDateTime;
    }

    /**
     * @param expiryDateTime the expiryDateTime to set
     */
    public void setExpiryDateTime(String expiryDateTime) {
        this.expiryDateTime = expiryDateTime;
    }

    /**
     * @return the statusID
     */
    public int getStatusID() {
        return statusID;
    }

    /**
     * @param statusID the statusID to set
     */
    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

  

   
    
}
