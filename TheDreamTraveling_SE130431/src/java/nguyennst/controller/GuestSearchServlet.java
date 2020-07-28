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
public class GuestSearchServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(GuestSearchServlet.class);

    private static final String HOME = "home.jsp";
    private static final String FAIL = "homePage";

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
        String url = HOME;
        try {
            String place = request.getParameter("txtPlace");
            int minPrice = 0;
            int maxPrice = 0;
            String priceMin = request.getParameter("txtPriceMin");
            if (!priceMin.equals("")) {
                minPrice = Integer.parseInt(priceMin);
            }
            String priceMax = request.getParameter("txtPriceMax");
            if (!priceMax.equals("")) {
                maxPrice = Integer.parseInt(priceMax);
            }
            String dateFrom = request.getParameter("txtDateFrom");
            String dateTo = request.getParameter("txtDateTo");
            int page = Integer.parseInt(request.getParameter("txtPage"));

            TblTourDAO dao = new TblTourDAO();
            int totalTour = dao.getNumberofTour(place, minPrice, maxPrice, dateFrom, dateTo);
            int numberPage = totalTour / 5;
            if (totalTour > numberPage * 5) {
                numberPage += 1;
            }
            int offset = (page - 1) * 5;
            List<TblTourDTO> listExpiry = dao.getListTourExpiryDate();
            for (TblTourDTO dto : listExpiry) {
                dao.updateStatusOfTourExpiry(dto.getTourID(), 2);
            }
            List<TblTourDTO> listTour = dao.getListTour(place, minPrice, maxPrice, dateFrom, dateTo, offset, 5);
            request.setAttribute("LISTTOUR", listTour);
            request.setAttribute("PAGENUM", numberPage);
            url = HOME;
        } catch (NamingException ex) {
            logger.error("GuestSearchServlet_Naming: " + ex.getMessage());
        } catch (SQLException ex) {
            logger.error("GuestSearchServlet_SQLE: " + ex.getMessage());
        } catch (NullPointerException ex) {
            logger.error("GuestSearchServlet_Null: " + ex.getMessage());
            url = FAIL;
        } finally {
            if (url.equals(HOME)) {
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
