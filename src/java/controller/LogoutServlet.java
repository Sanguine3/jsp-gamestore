/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Handles user logout functionality
 *
 * @author huanv
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(LogoutServlet.class.getName());
    private static final String HOME_SERVLET = "home";
    private static final String SESSION_ACCOUNT_KEY = "account";

    /**
     * Handles the HTTP <code>GET</code> method.
     * Processes user logout request
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
        
        try {
            // Get the session but don't create a new one if it doesn't exist
            HttpSession session = request.getSession(false);
            
            if (session != null) {
                // Log the logout event
                Object accountObj = session.getAttribute(SESSION_ACCOUNT_KEY);
                if (accountObj != null) {
                    LOGGER.log(Level.INFO, "User logged out");
                }
                
                // Invalidate the session
                session.invalidate();
                LOGGER.log(Level.INFO, "Session invalidated");
            }
            
            // Clear authentication cookies
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username") || 
                        cookie.getName().equals("remember")) {
                        
                        cookie.setMaxAge(0);
                        cookie.setPath("/");
                        response.addCookie(cookie);
                        LOGGER.log(Level.FINE, "Cleared cookie: {0}", cookie.getName());
                    }
                }
            }
            
            // Redirect to home page
            response.sendRedirect(HOME_SERVLET);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during logout process", e);
            response.sendRedirect(HOME_SERVLET);
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
        return "Logout Servlet for GameStore";
    }
}
