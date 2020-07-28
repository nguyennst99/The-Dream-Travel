/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.tblBooking;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import nguyennst.utils.DBHelper;

/**
 *
 * @author Admin
 */
public class TblBookingDAO implements Serializable{
    
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
    
    public boolean checkDiscount(String userID, String discountID) throws NamingException, SQLException{
        try{
            con = DBHelper.makeConnection();
            String url = "Select bookingID From tbl_Booking Where userID = ? and discountID = ?";
            stm = con.prepareStatement(url);
            stm.setString(1, userID);
            stm.setString(2, discountID);
            rs = stm.executeQuery();
            if(rs.next()){
                return true;
            }
        } finally {
            closeConnection();
        }
        return false;
    }
    
    
    public boolean insertBooking(float totalPrice, String userID, String discountID) throws NamingException, SQLException{
        Date currentDate = new Date();
        Calendar exrixyDate = Calendar.getInstance();
        exrixyDate.setTime(currentDate);
        exrixyDate.roll(Calendar.DATE, 1);
        SimpleDateFormat spf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentDatetime = spf.format(currentDate);
        String expiryDateTIme = spf.format(exrixyDate.getTime());
        try{
            con = DBHelper.makeConnection();
            String url = "Insert Into tbl_Booking(totalPrice, userID, discountID, orderDateTime, expiryDateTime, statusID) values(?,?,?,?,?,?)";
            stm = con.prepareStatement(url);
            stm.setFloat(1, totalPrice);
            stm.setString(2, userID);
            stm.setString(3, discountID);
            stm.setString(4, currentDatetime);
            stm.setString(5, expiryDateTIme);
            stm.setInt(6, 3);
            int row = stm.executeUpdate();
            if(row > 0){
                return true;
            }
        } finally{
            closeConnection();
        } 
        return false;
    }
    
    public int getLastBookingID() throws NamingException, SQLException{
        int lastBookingID = 0;
        try{
            con = DBHelper.makeConnection();
            String url = "Select MAX(bookingID) as bookingID from tbl_Booking";
            stm = con.prepareStatement(url);
            rs = stm.executeQuery();
            if(rs.next()){
                lastBookingID =  rs.getInt("bookingID");
            }
        } finally{
            closeConnection();
        }
        return lastBookingID;
    }
    
    public TblBookingDTO getBooking(int bookingID) throws NamingException, SQLException{
        TblBookingDTO dto =  null;
        try{
            con = DBHelper.makeConnection();
            String url = "Select totalPrice, userID, discountID, orderDateTime, expiryDateTime from tbl_Booking Where bookingID = ?";
            stm = con.prepareStatement(url);
            stm.setInt(1, bookingID);
            rs = stm.executeQuery();
            if(rs.next()){
                float totalPrice = rs.getFloat("totalPrice");
                String userID = rs.getString("userID");
                String discountID = rs.getString("discountID");
                String orderDateTime = rs.getString("orderDateTime");
                String expiryDateTime = rs.getString("expiryDateTime");
                dto  = new TblBookingDTO(bookingID, totalPrice, userID, discountID, orderDateTime, expiryDateTime);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    
    public List<TblBookingDTO> getListPending() throws NamingException, SQLException{
        List<TblBookingDTO> listBooking = new ArrayList<>();
        Timestamp currentDateTime = new Timestamp(System.currentTimeMillis());
        try {
            con =  DBHelper.makeConnection();
            String url = "Select bookingID from tbl_Booking Where expiryDateTime < ? and statusID = 3";
            stm = con.prepareStatement(url);
            stm.setTimestamp(1, currentDateTime);
            rs = stm.executeQuery();
            while(rs.next()){
                int bookingID = rs.getInt("bookingID");
                TblBookingDTO dto = new TblBookingDTO(bookingID);
                listBooking.add(dto);
            }
        } finally {
            closeConnection();
        }
        return listBooking;
    }
    
    
    public boolean updateStatus(int bookingID, int statusID) throws NamingException, SQLException{
        try{
            con = DBHelper.makeConnection();
            String url = "Update tbl_Booking Set statusID = ? Where bookingID = ?";
            stm = con.prepareStatement(url);
            stm.setInt(1, statusID);
            stm.setInt(2, bookingID);
            int row = stm.executeUpdate();
            if(row > 0){
                return true;
            }
        } finally {
            closeConnection();
        }
        return false;
    }
    
        
    public List<TblBookingDTO> getListBooking() throws NamingException, SQLException{
        List<TblBookingDTO> listBooking = new ArrayList<>();
        try {
            con =  DBHelper.makeConnection();
            String url = "Select bookingID, totalPrice, userID, discountID, orderDateTime, expiryDateTime, statusID from tbl_Booking";
            stm = con.prepareStatement(url);
            rs = stm.executeQuery();
            while(rs.next()){
                int bookingID = rs.getInt("bookingID");
                float totalPrice = rs.getFloat("totalPrice");
                String userID = rs.getString("userID");
                String discountID = rs.getString("discountID");
                String orderDate = rs.getString("orderDateTime");
                String expiryDate = rs.getString("expiryDateTime");
                int statusID = rs.getInt("statusID");
                TblBookingDTO dto = new TblBookingDTO(bookingID, totalPrice, userID, discountID, orderDate, expiryDate, statusID);
                listBooking.add(dto);
            }
        } finally {
            closeConnection();
        }
        return listBooking;
    }
      
    
    public List<TblBookingDTO> userGetListBooked(String userID) throws NamingException, SQLException{
        List<TblBookingDTO> listBooking = new ArrayList<>();
        try {
            con =  DBHelper.makeConnection();
            String url = "Select bookingID, totalPrice, userID, discountID, orderDateTime, expiryDateTime, statusID from tbl_Booking Where userID = ?";
            stm = con.prepareStatement(url);
            stm.setString(1, userID);
            rs = stm.executeQuery();
            while(rs.next()){
                int bookingID = rs.getInt("bookingID");
                float totalPrice = rs.getFloat("totalPrice");
                String user = rs.getString("userID");
                String discountID = rs.getString("discountID");
                String orderDate = rs.getString("orderDateTime");
                String expiryDate = rs.getString("expiryDateTime");
                int statusID = rs.getInt("statusID");
                TblBookingDTO dto = new TblBookingDTO(bookingID, totalPrice, user, discountID, orderDate, expiryDate, statusID);
                listBooking.add(dto);
            }
        } finally {
            closeConnection();
        }
        return listBooking;
    }
    
    public List<TblBookingDTO> userGetListPending(String userID) throws NamingException, SQLException{
        List<TblBookingDTO> listBooking = new ArrayList<>();
        Timestamp currentDateTime = new Timestamp(System.currentTimeMillis());
        try {
            con =  DBHelper.makeConnection();
            String url = "Select bookingID from tbl_Booking Where expiryDateTime < ? and statusID = 3 and userID = ?";
            stm = con.prepareStatement(url);
            stm.setTimestamp(1, currentDateTime);
            stm.setString(2, userID);
            rs = stm.executeQuery();
            while(rs.next()){
                int bookingID = rs.getInt("bookingID");
                TblBookingDTO dto = new TblBookingDTO(bookingID);
                listBooking.add(dto);
            }
        } finally {
            closeConnection();
        }
        return listBooking;
    }
    
    
}

