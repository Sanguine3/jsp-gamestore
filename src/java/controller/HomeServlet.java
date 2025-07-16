/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Product;

/**
 *
 * @author huanv
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    // Default products per page
    private static final int DEFAULT_PRODUCTS_PER_PAGE = 8;

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
        request.setCharacterEncoding("utf-8");
        try (var out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        var dao = new DAO();
        var product = dao.getAllProduct();
        var categories = dao.getAllCategory();
        
        // Get products per page from configuration or use default
        int productsPerPage;
        var configPpp = getServletContext().getInitParameter("productsPerPage");
        if(configPpp != null) {
            try {
                productsPerPage = Integer.parseInt(configPpp);
            } catch (NumberFormatException e) {
                productsPerPage = DEFAULT_PRODUCTS_PER_PAGE;
            }
        } else {
            productsPerPage = DEFAULT_PRODUCTS_PER_PAGE;
        }
        
        int page;
        var size = product.size();
        var num = (size % productsPerPage == 0) ? (size / productsPerPage) : ((size / productsPerPage) + 1);
        var xpage = request.getParameter("page");
        if(xpage == null){
            page = 1;
        }else{
            page = Integer.parseInt(xpage);
        }
        
        int start = (page - 1) * productsPerPage;
        int end = Math.min(page * productsPerPage, size);
        
        var products = dao.getAllProductByPage(product, start, end);
        
        // Set CSS file for the page
        request.setAttribute("cssfile", "home.css");
        
        request.setAttribute("categories", categories);
        request.setAttribute("products", products);
        request.setAttribute("page", page);
        request.setAttribute("num", num);
        
        request.getRequestDispatcher("home.jsp").forward(request, response);
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
        return "Home Servlet for GameStore";
    }// </editor-fold>

}
