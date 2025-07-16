/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 * Handles product deletion functionality
 *
 * @author huanv
 */
@WebServlet(name = "DeleteServlet", urlPatterns = {"/delete"})
public class DeleteServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(DeleteServlet.class.getName());
    private static final String LIST_SERVLET = "list";
    private static final String HOME_SERVLET = "home";
    private static final String SESSION_ACCOUNT_KEY = "account";
    private static final int ADMIN_LEVEL = 1;

    /**
     * Handles the HTTP <code>GET</code> method.
     * Processes product deletion request
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        
        // Check if user is admin
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(SESSION_ACCOUNT_KEY);
        
        if (account == null || account.getAdminLevel() != ADMIN_LEVEL) {
            LOGGER.log(Level.WARNING, "Unauthorized access attempt to delete product");
            response.sendRedirect(HOME_SERVLET);
            return;
        }
        
        String productId = request.getParameter("pid");
        
        // Validate product ID
        if (productId == null || productId.trim().isEmpty()) {
            LOGGER.log(Level.WARNING, "Product ID not provided for deletion");
            response.sendRedirect(LIST_SERVLET);
            return;
        }
        
        try (DAO dao = new DAO()) {
            // Delete the product
            dao.delete(productId);
            LOGGER.log(Level.INFO, "Product deleted successfully: {0}", productId);
            
            // Redirect back to product list
            response.sendRedirect(LIST_SERVLET);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error deleting product with ID: " + productId, e);
            request.setAttribute("errorMessage", "An error occurred while deleting the product");
            response.sendRedirect(LIST_SERVLET);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * Redirects to GET method
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Product Deletion Servlet for GameStore";
    }
}
