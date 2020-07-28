/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.cart;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import nguyennst.tblTour.TblTourDTO;


/**
 *
 * @author Admin
 */
public class Cart implements Serializable{
    
    private Map<Integer, TblTourDTO> items;

    public Map<Integer, TblTourDTO> getItems() {
        return items;
    }
    
    public void addtoCart(TblTourDTO dto){
        if(this.items == null){
            this.items = new HashMap<>();
        }
        this.items.put(dto.getTourID(), dto);
    }
    
    public int getTotal() {
        int amount = 0;
        for (TblTourDTO dto : this.items.values()) {
            amount += dto.getPrice() * dto.getAmount();
            
        }
        return amount;
    }
    
    public void removeItemFromCart(int tourID) throws Exception{
        if(this.items == null){
            return;
        }
        if(this.items.containsKey(tourID)){
            this.items.remove(tourID);
        }
    }
    
    public void updateItemCart(int tourID, int amount) throws Exception{
        if(this.items == null){
            return;
        }
        if(this.items.containsKey(tourID)){
            this.items.get(tourID).setAmount(amount);
        }
    }
}
