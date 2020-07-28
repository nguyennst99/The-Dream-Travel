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
import nguyennst.tblBooking.TblBookingDAO;
import org.apache.log4j.Logger;

/**
 *
 * @author Admin
 */
public class UserUseDiscountServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(UserUseDiscountServlet.class);

    private static final String VIEWCART = "viewcart.jsp";
    private static final String DISCOUNTPAGE = "discount.jsp";

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
        String url = DISCOUNTPAGE;
        try {
            HttpSession session = request.getSession();
            String userID = request.getParameter("UserID");
            String discountID = request.getParameter("txtDiscountID");
            if (!discountID.equals("0")) {
                TblBookingDAO dao = new TblBookingDAO();
                boolean result = dao.checkDiscount(userID, discountID);
                if (result) {
                    request.setAttribute("DISCOUNTEXISTED", "This discount has been used");
                    url = DISCOUNTPAGE;
                } else {
                    session.setAttribute("DISCOUNTID", discountID);
                    url = VIEWCART;
                }
            } else {
                session.setAttribute("DISCOUNTID", discountID);
                url = VIEWCART;
            }

        } catch (NamingException ex) {
            logger.error("UserUseDiscountServlet_Naming: " + ex.getMessage());
        } catch (SQLException ex) {
            logger.error("UserUseDiscountServlet_SQLE: " + ex.getMessage());
        } catch (NullPointerException ex) {
            logger.error("UserUseDiscountServlet_Null: " + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
