/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nguyennst.controller;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.ExceededSizeException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nguyennst.tblTour.TblTourDAO;
import org.apache.log4j.Logger;

/**
 *
 * @author Admin
 */
public class AdminCreateTourServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(AdminCreateTourServlet.class);

    private static final String SUCCESS = "admin";
    private static final String ERROR = "error";
    private static final String FAIL = "createtour.jsp";

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
            String path = request.getServletContext().getRealPath("");
            String pathReplace = path.replace("\\", "/");
            int indexBuild = path.indexOf("build");
            String pathRI = pathReplace.substring(0, indexBuild) + pathReplace.substring(indexBuild + 6);

            String pathFull = null;
            if (pathRI.endsWith("/")) {
                pathFull = pathRI + "image";
            } else {
                pathFull = pathRI + "/" + "image";
            }
            MultipartRequest multi = new MultipartRequest(request, pathFull, 1024 * 1024 * 10);

            String tourName = multi.getParameter("txtTourNameInsert");
            String place = multi.getParameter("txtPlaceInsert");
            String fromDate = multi.getParameter("txtFromDateInsert");
            String toDate = multi.getParameter("txtToDateInsert");
            int price = Integer.parseInt(multi.getParameter("txtPriceInsert"));
            int quota = Integer.parseInt(multi.getParameter("txtQuotaInsert"));
            String image = null;

            Enumeration files = multi.getFileNames();

            while (files.hasMoreElements()) {
                String load = (String) files.nextElement();
                image = multi.getOriginalFileName(load);
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateFrom = (Date) sdf.parse(fromDate);
            Date dateTo = (Date) sdf.parse(toDate);
            Date dateNow = new Date(System.currentTimeMillis());

            if (dateFrom.after(dateTo) || dateNow.after(dateFrom) || dateNow.after(dateTo)) {
                request.setAttribute("DATE", "please input the valid date");
                url = FAIL;
            } else {

                TblTourDAO dao = new TblTourDAO();
                boolean result = dao.insertTour(tourName, image, place, price, fromDate, toDate, quota);
                if (result) {
                    url = SUCCESS;
                }
            }
        } catch (NumberFormatException ex) {
            logger.error("AdminCreateTourServlet_Number: " + ex.getMessage());
        } catch (NamingException ex) {
            logger.error("AdminCreateTourServlet_Naming: " + ex.getMessage());
        } catch (SQLException ex) {
            logger.error("AdminCreateTourServlet_SQLE: " + ex.getMessage());
        } catch (ExceededSizeException ex) {
            request.setAttribute("MAXSIZE", "Maximum size: 10MB");
            url = FAIL;
        } catch (ParseException ex) {
            logger.error("AdminCreateTourServlet_Parse: " + ex.getMessage());
        } catch(IOException ex) {
            logger.error("AdminCreateTourServlet_IO: " + ex.getMessage());
        } finally {
            if (url.equals(FAIL)) {
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            } else {
                response.sendRedirect(url);
                out.close();
            }
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
