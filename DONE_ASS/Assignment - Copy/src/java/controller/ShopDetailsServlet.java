/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Categories;
import model.Feedback;
import model.Products;

/**
 *
 * @author admin
 */
@WebServlet(name = "ShopDetailsControll", urlPatterns = {"/shopdetail"})
public class ShopDetailsServlet extends HttpServlet {

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
        DAO dao = new DAO();
        String id = request.getParameter("pid");
        Products p = dao.getProductsByID(id);
        List<Products> list = dao.getAllProduct();
        List<Feedback> listFeedback = dao.getFeedbackByProductID(p.getId());

        double rate = 0;
        for (Feedback feedback : listFeedback) {
            rate += feedback.getRating();
        }
        if (listFeedback.size() >0) {
            rate = rate / (double) listFeedback.size();
        }

        int fullStars = (int) rate; // Phần nguyên của rate là số sao
        double fractionalPart = rate - fullStars;

        boolean hasHalfStar = false;
        if (fractionalPart > 0.5) {
            hasHalfStar = true;
        }

// Đặt các thuộc tính vào request để chuyển đến JSP
        request.setAttribute("detail", p);
        request.setAttribute("listProducts", list);
        request.setAttribute("listFeedback", listFeedback);
        request.setAttribute("fullStars", fullStars);
        request.setAttribute("hasHalfStar", hasHalfStar);
        request.setAttribute("reviewsCount", listFeedback.size());
        request.getRequestDispatcher("shop-details.jsp").forward(request, response);

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
