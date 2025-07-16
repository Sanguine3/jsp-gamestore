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
 * Handles account removal functionality
 *
 * @author huanv
 */
@WebServlet(name = "RemoveAccount", urlPatterns = {"/remove"})
public class RemoveAccount extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(RemoveAccount.class.getName());
    private static final String ACCOUNT_SERVLET = "account";
    private static final String HOME_SERVLET = "home";
    private static final String SESSION_ACCOUNT_KEY = "account";
    private static final int ADMIN_LEVEL = 1;

    /**
     * Handles the HTTP <code>GET</code> method.
     * Processes account removal request
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
            LOGGER.log(Level.WARNING, "Unauthorized access attempt to remove account");
            response.sendRedirect(HOME_SERVLET);
            return;
        }
        
        String accountId = request.getParameter("uid");
        
        // Validate account ID
        if (accountId == null || accountId.trim().isEmpty()) {
            LOGGER.log(Level.WARNING, "Account ID not provided for removal");
            response.sendRedirect(ACCOUNT_SERVLET);
            return;
        }
        
        // Prevent admin from removing their own account
        if (String.valueOf(account.getId()).equals(accountId)) {
            LOGGER.log(Level.WARNING, "Admin attempted to remove their own account");
            request.setAttribute("errorMessage", "You cannot remove your own admin account");
            response.sendRedirect(ACCOUNT_SERVLET);
            return;
        }
        
        try (DAO dao = new DAO()) {
            // Remove the account
            dao.remove(accountId);
            LOGGER.log(Level.INFO, "Account removed successfully: {0}", accountId);
            
            // Redirect back to account list
            response.sendRedirect(ACCOUNT_SERVLET);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error removing account with ID: " + accountId, e);
            request.setAttribute("errorMessage", "An error occurred while removing the account");
            response.sendRedirect(ACCOUNT_SERVLET);
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
        return "Account Removal Servlet for GameStore";
    }
}
