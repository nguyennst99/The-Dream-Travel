/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.tblBookingDetail;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import nguyennst.utils.DBHelper;

/**
 *
 * @author Admin
 */
public class TblBookingDetailDAO implements Serializable{
    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;
    
    private void closeConnection() throws SQLException{
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
    
    public boolean insertDetail(int tourID, int bookingID, int priceOfTour, int amount) throws NamingException, SQLException{
        try { 
            con = DBHelper.makeConnection();
            String url = "Insert Into tbl_BookingDetail(tourID, bookingID, priceOfTour, amount) values (?,?,?,?)";
            stm = con.prepareStatement(url);
            stm.setInt(1, tourID);
            stm.setInt(2, bookingID);
            stm.setInt(3, priceOfTour);
            stm.setInt(4, amount);
            int row = stm.executeUpdate();
            if(row > 0){
                return true;
            }
        } finally {
            closeConnection();
        }
        return false;
    }
}
