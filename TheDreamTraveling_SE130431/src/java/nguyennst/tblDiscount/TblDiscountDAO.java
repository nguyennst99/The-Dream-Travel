/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.tblDiscount;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import nguyennst.utils.DBHelper;

/**
 *
 * @author Admin
 */
public class TblDiscountDAO implements Serializable{
    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;
    
    public void closeConnection() throws SQLException{
        if(rs!=null){
            rs.close();
        }
        if(stm!=null){
            stm.close();
        }
        if(con!=null){
            con.close();
        }
    }
    
  
    public List<TblDiscountDTO> getListDiscount() throws NamingException, SQLException{
        Date currentDate = new Date(System.currentTimeMillis());
        List<TblDiscountDTO> list = new ArrayList<>();
        try{
            con = DBHelper.makeConnection();
            String url = "Select discountID, discount from tbl_Discount Where expiryDate > = ?";
            stm = con.prepareStatement(url);
            stm.setDate(1, currentDate);
            rs = stm.executeQuery();
            while(rs.next()){
                String discountID = rs.getString("discountID");
                String discount = rs.getString("discount");
                TblDiscountDTO dto = new TblDiscountDTO(discountID, discount);
                list.add(dto);
            }
        } finally{
            closeConnection();
        }
        return list;
    }
}
