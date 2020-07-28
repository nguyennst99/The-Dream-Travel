/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.tblUser;

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
public class TblUserDAO implements Serializable {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if(stm!=null){
            stm.close();
        }
        if(con!=null){
            con.close();
        }
    }
    
    private String name;

    public String getName() {
        return name;
    }
    
    public int checkLogin(String userID, String password) throws NamingException, SQLException{
        int role = 0;
        try{
            con = DBHelper.makeConnection();
            String url = "Select roleID, name from tbl_User Where userID = ? and password = ?";
            stm = con.prepareStatement(url);
            stm.setString(1, userID);
            stm.setString(2, password);
            rs = stm.executeQuery();
            if(rs.next()){
                this.name = rs.getString("name");
                role = rs.getInt("roleID");
            }
        } finally {
            closeConnection();
        }
        return role;
    }
    
    public boolean insertUserFacebook(String userID, String name, String facebookID) throws NamingException, SQLException{
        try {
            con = DBHelper.makeConnection();
            String url = "Insert Into tbl_User(userID, name, roleID, facebookID) values(?,?,?,?)";
            stm = con.prepareStatement(url);
            stm.setString(1, userID);
            stm.setString(2, name);
            stm.setInt(3, 2);
            stm.setString(4, facebookID);
            int row = stm.executeUpdate();
            if(row > 0){
                return true;
            }
        } finally {
            closeConnection();
        }
        return false;
    }
    
    public boolean checkLoginFacebook(String facebookID) throws NamingException, SQLException{
        try {
            con = DBHelper.makeConnection();
            String url = "Select facebookID From tbl_User Where facebookID = ?";
            stm = con.prepareStatement(url);
            stm.setString(1, facebookID);
            rs = stm.executeQuery();
            if(rs.next()){
                return true;
            }
        } finally {
            closeConnection();
        }
        return false;
    }
}
