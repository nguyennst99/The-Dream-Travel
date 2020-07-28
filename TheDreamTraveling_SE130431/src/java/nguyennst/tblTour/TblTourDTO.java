/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.tblTour;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author Admin
 */
public class TblTourDTO implements Serializable{
    private String tourName, image, place, fromDate, toDate;
    private int price;
    private int tourID;
    private int amount;
    private Date dateImport;
    private int status;
    

    public TblTourDTO() {
    }

    public TblTourDTO(int tourID) {
        this.tourID = tourID;
    }
    
    
    
    public TblTourDTO(String tourName, String image, String fromDate, String toDate, int price, int tourID, String place) {
        this.tourName = tourName;
        this.image = image;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.price = price;
        this.tourID = tourID;
        this.place = place;
    }

    public TblTourDTO(String tourName, String fromDate, String toDate, int price, int tourID, int amount, String place) {
        this.tourName = tourName;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.price = price;
        this.tourID = tourID;
        this.amount = amount;
        this.place = place;
    }

    public TblTourDTO(String tourName, String image, String place, String fromDate, String toDate, int price, int tourID, int amount, Date dateImport, int status) {
        this.tourName = tourName;
        this.image = image;
        this.place = place;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.price = price;
        this.tourID = tourID;
        this.amount = amount;
        this.dateImport = dateImport;
        this.status = status;
    }

    

    /**
     * @return the tourName
     */
    public String getTourName() {
        return tourName;
    }

    /**
     * @param tourName the tourName to set
     */
    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    /**
     * @return the image
     */
    public String getImage() {
        return image;
    }

    /**
     * @param image the image to set
     */
    public void setImage(String image) {
        this.image = image;
    }

    /**
     * @return the price
     */
    public int getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(int price) {
        this.price = price;
    }

    /**
     * @return the tourID
     */
    public int getTourID() {
        return tourID;
    }

    /**
     * @param tourID the tourID to set
     */
    public void setTourID(int tourID) {
        this.tourID = tourID;
    }

    /**
     * @return the amount
     */
    public int getAmount() {
        return amount;
    }

    /**
     * @param amount the amount to set
     */
    public void setAmount(int amount) {
        this.amount = amount;
    }

    /**
     * @return the place
     */
    public String getPlace() {
        return place;
    }

    /**
     * @param place the place to set
     */
    public void setPlace(String place) {
        this.place = place;
    }

    /**
     * @return the fromDate
     */
    

    /**
     * @return the dateImport
     */
    public Date getDateImport() {
        return dateImport;
    }

    /**
     * @param dateImport the dateImport to set
     */
    public void setDateImport(Date dateImport) {
        this.dateImport = dateImport;
    }

    /**
     * @return the status
     */
    public int getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(int status) {
        this.status = status;
    }

    /**
     * @return the fromDate
     */
    public String getFromDate() {
        return fromDate;
    }

    /**
     * @param fromDate the fromDate to set
     */
    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    /**
     * @return the toDate
     */
    public String getToDate() {
        return toDate;
    }

    /**
     * @param toDate the toDate to set
     */
    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    
    
    
}
