/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.tblTour;

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
public class TblTourDAO implements Serializable {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public int getNumberofTour(String place, int minPrice, int maxPrice, String DateFrom, String DateTo) throws NamingException, SQLException {
        int number = 0;
        try {
            con = DBHelper.makeConnection();
            if (DateFrom.equals("") && DateTo.equals("") && (minPrice == 0) && (maxPrice == 0)) {
                String url = "Select Count(*) as Total From tbl_Tour "
                        + "Where place LIKE ? "
                        + "and statusID = 1 and amount > 0 ";
                stm = con.prepareStatement(url);
                stm.setString(1, "%" + place + "%");
            } else {
                String url = "Select Count(*) as Total From tbl_Tour "
                        + "Where place LIKE ? and price >= ? and price <= ? and fromDate >= ? and toDate <= ? "
                        + "and statusID = 1 and amount > 0";
                stm = con.prepareStatement(url);
                stm.setString(1, "%" + place + "%");
                stm.setInt(2, minPrice);
                stm.setInt(3, maxPrice);
                stm.setString(4, DateFrom);
                stm.setString(5, DateTo);
            }
            rs = stm.executeQuery();
            if (rs.next()) {
                number = rs.getInt("Total");
            }
        } finally {
            closeConnection();
        }
        return number;
    }

    public List<TblTourDTO> getListTour(String place, int minPrice, int maxPrice, String DateFrom, String DateTo, int offset, int next)
            throws NamingException, SQLException {
        List<TblTourDTO> listTour = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (DateFrom.equals("") && DateTo.equals("") && (minPrice == 0) && (maxPrice == 0)) {
                String url = "Select tourID, tourName, image, price, fromDate, toDate, place From tbl_Tour "
                        + "Where place LIKE ? "
                        + "and statusID = 1 and amount > 0 "
                        + "ORDER BY fromDate "
                        + "OFFSET ? ROWS "
                        + "FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(url);
                stm.setString(1, "%" + place + "%");
                stm.setInt(2, offset);
                stm.setInt(3, next);
            } else {
                String url = "Select tourID, tourName, image, price, fromDate, toDate, place From tbl_Tour "
                        + "Where place LIKE ? and price >= ? and price <= ? and fromDate >= ? and toDate <= ? "
                        + "and statusID = 1 and amount > 0 "
                        + "ORDER BY fromDate "
                        + "OFFSET ? ROWS "
                        + "FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(url);
                stm.setString(1, "%" + place + "%");
                stm.setInt(2, minPrice);
                stm.setInt(3, maxPrice);
                stm.setString(4, DateFrom);
                stm.setString(5, DateTo);
                stm.setInt(6, offset);
                stm.setInt(7, next);
            }
            rs = stm.executeQuery();
            while (rs.next()) {
                String tourName = rs.getString("tourName");
                String image = rs.getString("image");
                int price = rs.getInt("price");
                String fromDate = rs.getString("fromDate");
                String toDate = rs.getString("toDate");
                int tourID = rs.getInt("tourID");
                String places = rs.getString("place");
                TblTourDTO dto = new TblTourDTO(tourName, image, fromDate, toDate, price, tourID, places);
                listTour.add(dto);
            }
        } finally {
            closeConnection();
        }
        return listTour;
    }

    public TblTourDTO findTourbyTourID(int tourID) throws NamingException, SQLException {
        TblTourDTO dto = null;
        try {
            con = DBHelper.makeConnection();
            String url = "Select tourName, fromDate, toDate, price, amount, place from tbl_Tour Where tourID = ?";
            stm = con.prepareStatement(url);
            stm.setInt(1, tourID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String tourName = rs.getString("tourName");
                String fromDate = rs.getString("fromDate");
                String toDate = rs.getString("toDate");
                int price = rs.getInt("price");
                int amount = rs.getInt("amount");
                String place = rs.getString("place");
                dto = new TblTourDTO(tourName, fromDate, toDate, price, tourID, amount, place);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public boolean updateAmountOfTour(int tourID, int amount) throws NamingException, SQLException {
        try {
            con = DBHelper.makeConnection();
            String url = "Update tbl_Tour Set amount = ? Where tourID = ?";
            stm = con.prepareStatement(url);
            stm.setInt(1, amount);
            stm.setInt(2, tourID);
            int row = stm.executeUpdate();
            if (row > 0) {
                return true;
            }
        } finally {
            closeConnection();
        }
        return false;
    }

    public int adminGetNumberofTour() throws NamingException, SQLException {
        int number = 0;
        try {
            con = DBHelper.makeConnection();
            String url = "Select Count(*) as Total From tbl_Tour";
            stm = con.prepareStatement(url);
            rs = stm.executeQuery();
            if (rs.next()) {
                number = rs.getInt("Total");
            }
        } finally {
            closeConnection();
        }
        return number;
    }

    public List<TblTourDTO> adminGetListTour(int offset, int next)
            throws NamingException, SQLException {
        List<TblTourDTO> listTour = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            String url = "Select tourID, tourName, image, price, fromDate, toDate, place, statusID, amount, dateImport From tbl_Tour "
                    + "ORDER BY fromDate "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY";
            stm = con.prepareStatement(url);
            stm.setInt(1, offset);
            stm.setInt(2, next);
            rs = stm.executeQuery();
            while (rs.next()) {
                String tourName = rs.getString("tourName");
                String image = rs.getString("image");
                int price = rs.getInt("price");
                String fromDate = rs.getString("fromDate");
                String toDate = rs.getString("toDate");
                int tourID = rs.getInt("tourID");
                String places = rs.getString("place");
                int amount = rs.getInt("amount");
                Date dateImport = rs.getDate("dateImport");
                int status = rs.getInt("statusID");
                TblTourDTO dto = new TblTourDTO(tourName, image, places, fromDate, toDate, price, tourID, amount, dateImport, status);
                listTour.add(dto);
            }
        } finally {
            closeConnection();
        }
        return listTour;
    }
    
    public boolean insertTour(String tourName, String image, String place, int price, String fromDate, String toDate, int quota) throws NamingException, SQLException{
        Date currentDate = new Date(System.currentTimeMillis());
        try{
            con = DBHelper.makeConnection();
            String url = "Insert Into tbl_Tour(tourName, image, price, fromDate, toDate, place, statusID, amount, dateImport) values (?,?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(url);
            stm.setString(1, tourName);
            stm.setString(2, image);
            stm.setInt(3, price);
            stm.setString(4, fromDate);
            stm.setString(5, toDate);
            stm.setString(6, place);
            stm.setInt(7, 1);
            stm.setInt(8, quota);
            stm.setDate(9, currentDate);
            int row = stm.executeUpdate();
            if(row>0){
                return true;
            }
        } finally{
            closeConnection();
        }
        return false;
    }
    
    public List<TblTourDTO> getListTourExpiryDate() throws NamingException, SQLException{
        List<TblTourDTO> list = new ArrayList<>();
        Date currentDate = new Date(System.currentTimeMillis());
        try{
            con = DBHelper.makeConnection();
            String url = "Select tourID from tbl_Tour Where fromDate < ?";
            stm = con.prepareStatement(url);
            stm.setDate(1, currentDate);
            rs = stm.executeQuery();
            while(rs.next()){
                int tourID = rs.getInt("tourID");
                TblTourDTO dto = new TblTourDTO(tourID);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        return list;
    }
    
    
    public boolean updateStatusOfTourExpiry(int tourID, int statusID) throws NamingException, SQLException{
        try{
            con = DBHelper.makeConnection();
            String url = "Update tbl_Tour Set statusID = ? Where tourID = ?";
            stm = con.prepareStatement(url);
            stm.setInt(1, statusID);
            stm.setInt(2, tourID);
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
