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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nguyennst.cart.Cart;
import nguyennst.tblTour.TblTourDAO;
import nguyennst.tblTour.TblTourDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Admin
 */
public class UserAddToCartServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(UserAddToCartServlet.class);
    
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
        String url = USER;
        try {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart == null) {
                cart = new Cart();
            }
            int tourID = Integer.parseInt(request.getParameter("txtTourID"));
            TblTourDAO dao = new TblTourDAO();
            TblTourDTO dto = dao.findTourbyTourID(tourID);
            dto.setAmount(1);
            
            cart.addtoCart(dto);
            
            session.setAttribute("CART", cart);
            url = USER;
            
        } catch (NamingException ex) {
            logger.error("UserAddToCartServlet_Naming: " + ex.getMessage());
        } catch (SQLException ex) {
            logger.error("UserAddToCartServlet_SQLE: " + ex.getMessage());
        } catch (NullPointerException ex) {
            logger.error("UserAddToCartServlet_Null: " + ex.getMessage());
        }catch (NumberFormatException ex) {
            logger.error("UserAddToCartServlet_Num: " + ex.getMessage());
        } finally {
            response.sendRedirect(url);
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
