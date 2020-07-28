/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.tblDiscount;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class TblDiscountDTO implements Serializable {
    private String discountID, discount;

    public TblDiscountDTO() {
    }

    public TblDiscountDTO(String discountID, String discount) {
        this.discountID = discountID;
        this.discount = discount;
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
     * @return the discount
     */
    public String getDiscount() {
        return discount;
    }

    /**
     * @param discount the discount to set
     */
    public void setDiscount(String discount) {
        this.discount = discount;
    }
    
    
}
