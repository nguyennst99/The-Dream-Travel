/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nguyennst.cart.Cart;
import nguyennst.tblBooking.TblBookingDAO;
import nguyennst.tblBooking.TblBookingDTO;
import nguyennst.tblBookingDetail.TblBookingDetailDAO;
import nguyennst.tblTour.TblTourDAO;
import nguyennst.tblTour.TblTourDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Admin
 */
public class UserConfirmServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(UserConfirmServlet.class);

    private static final String ERROR = "errorcart.html";
    private static final String CONFIRM = "confirm.jsp";
    private static final String FAIL = "viewcart.jsp";
    private static final String ERRORPAGE = "login.jsp";

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
        String url = ERROR;

        try {
            String userID = request.getParameter("UserIDConfirm");
            String discountID = request.getParameter("discountIDConfirm");
            if (discountID.equals("")) {
                discountID = "0";
            }
            float totalPrice = Float.parseFloat(request.getParameter("totalPriceConfirm"));
            HttpSession session = request.getSession();
            if (session != null) {

                Cart cart = (Cart) session.getAttribute("CART");
                if (cart != null) {

                    TblTourDAO tourDAO = new TblTourDAO();
                    TblBookingDAO bookingDAO = new TblBookingDAO();
                    TblBookingDetailDAO detailDAO = new TblBookingDetailDAO();

                    boolean check = true;

                    List<TblTourDTO> listInvalid = new ArrayList<>();

                    if (!cart.getItems().values().isEmpty()) {
                        for (TblTourDTO tourDTO : cart.getItems().values()) {
                            TblTourDTO dto = tourDAO.findTourbyTourID(tourDTO.getTourID());
                            int amount = dto.getAmount() - tourDTO.getAmount();
                            if (amount < 0) {
                                check = false;
                                listInvalid.add(dto);
                            }
                        }

                        if (check) {
                            boolean resultBooking = bookingDAO.insertBooking(totalPrice, userID, discountID);
                            if (resultBooking) {
                                int bookingID = bookingDAO.getLastBookingID();
                                for (TblTourDTO dto : cart.getItems().values()) {
                                    detailDAO.insertDetail(dto.getTourID(), bookingID, dto.getPrice() * dto.getAmount(), dto.getAmount());
                                }
                                for (TblTourDTO dto : cart.getItems().values()) {
                                    TblTourDTO tourDTO = tourDAO.findTourbyTourID(dto.getTourID());
                                    int amount = tourDTO.getAmount() - dto.getAmount();
                                    tourDAO.updateAmountOfTour(dto.getTourID(), amount);
                                }
                                TblBookingDTO dto = bookingDAO.getBooking(bookingID);
                                request.setAttribute("INVOICE", dto);
                                session.removeAttribute("CART");
                                session.removeAttribute("DISCOUNTID");
                                url = CONFIRM;
                            } else {
                                url = ERROR;
                            }
                        } else {
                            request.setAttribute("LISTINVALID", listInvalid);
                            url = FAIL;
                        }
                    }

                }
            }
        } catch (NamingException ex) {
            logger.error("UserConfirmServlet_Naming: " + ex.getMessage());
        } catch (SQLException ex) {
            logger.error("UserConfirmServlet_SQL: " + ex.getMessage());
        } catch (NullPointerException ex) {
            logger.error("UserConfirmServlet_Null: " + ex.getMessage());
            url = ERRORPAGE;
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
