/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nguyennst.tblTour.TblTourDAO;
import nguyennst.tblTour.TblTourDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Admin
 */
public class AdminShowTourServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminShowTourServlet.class);
    
    private static final String ADMIN = "admin.jsp";
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
        String url = ADMIN;
        try {
            int page = Integer.parseInt(request.getParameter("txtPage"));
            
            TblTourDAO dao = new TblTourDAO();
            List<TblTourDTO> listExpiry = dao.getListTourExpiryDate();
            for (TblTourDTO dto : listExpiry) {
                dao.updateStatusOfTourExpiry(dto.getTourID(), 2);
            }
            
            
            int totalTour = dao.adminGetNumberofTour();
            int numberPage = totalTour / 5;
            if (totalTour > numberPage * 5) {
                numberPage += 1;
            }
            int offset = (page - 1) * 5;
            List<TblTourDTO> listTour = dao.adminGetListTour(offset, 5);
            request.setAttribute("LISTTOURADMIN", listTour);
            request.setAttribute("PAGENUMADMIN", numberPage);
            
            url = ADMIN;
            
        } catch (NamingException ex) {
            logger.error("AdminShowTourServlet_Naming: " + ex.getMessage());
        } catch (SQLException ex) {
            logger.error("AdminShowTourServlet_SQLE: " + ex.getMessage());
        } catch (NullPointerException ex) {
            logger.error("AdminShowTourServlet_Null: " + ex.getMessage());
        } catch (NumberFormatException ex) {
            logger.error("AdminShowTourServlet_Num: " + ex.getMessage());
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
