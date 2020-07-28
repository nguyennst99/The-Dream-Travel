/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nguyennst.tblUser.TblUserDAO;
import org.apache.log4j.Logger;

/**
 *
 * @author Admin
 */
public class LoginFaceBookServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(LoginFaceBookServlet.class);

    private static final String FAIL = "login.jsp";
    private static final String USER = "user";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = FAIL;
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String facebookID = request.getParameter("id");
        try {
            TblUserDAO dao = new TblUserDAO();
            if (facebookID.isEmpty()) {
                request.setAttribute("ERRORFB", "Login with Facebook failed.");
            } else {
                if (dao.checkLoginFacebook(facebookID) == false) {
                    dao.insertUserFacebook(email, name, facebookID);
                }
                HttpSession session = request.getSession();
                session.setAttribute("USERID", email);
                session.setAttribute("NAME", name);
                session.setAttribute("ROLE", 2);
                url = USER;
            }
        } catch (NamingException ex) {
            logger.error("LoginFaceBookServlet_Naming: " + ex.getMessage());
        } catch (SQLException ex) {
            logger.error("LoginFaceBookServlet_SQLE: " + ex.getMessage());
        } catch (NullPointerException ex) {
            logger.error("LoginFaceBookServlet_Null " + ex.getMessage());
        } finally {
            if (url.equals(FAIL)) {
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            } else {
                response.sendRedirect(url);
            }
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
