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
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Cart;
import model.Categories;
import model.Item;
import model.Products;

/**
 *
 * @author admin
 */
@WebServlet(name="Cart2Servlet", urlPatterns={"/cart2"})
public class Cart2Servlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       HttpSession session = request.getSession();
        Cart cart = null;
        Object o = session.getAttribute("cart");
        if(o!=null){
            cart=(Cart)o;
        }else{
            cart = new Cart();
        }
        DAO dao = new DAO();
        String tnum= request.getParameter("num");
        String tid = request.getParameter("id");
        String link= request.getParameter("link");
        int num,id;
        try {
            num = Integer.parseInt(tnum);
            id = Integer.parseInt(tid);
            
            
            Products p = dao.getProductsByID(tid);
            Item t = new Item(p, num, p.getDiscountedUnitPrice());
            cart.addItem(t);
        } catch (Exception e) {
        }
        
        List<Products> list = dao.getAllProduct();
         List<Categories> listCategory = dao.getAllCategory();
         List<Products> listTopRating = dao.getTopRatingProducts();
         List<Products> list6LastRating = dao.get6LastProducts();
         List<Products> listReview = dao.getReviewProducts();
         
        //set data to jsp
        request.setAttribute("listProducts", list);
        request.setAttribute("listCategory", listCategory);
        request.setAttribute("listTopRate", listTopRating);
        request.setAttribute("list6Last", list6LastRating);
        request.setAttribute("listReview", listReview);
        
        List<Item> listItem = cart.getItems();
        session.setAttribute("cart", cart);
        session.setAttribute("totalMoney", cart.getTotalMoney());
        session.setAttribute("size", listItem.size());
        request.getRequestDispatcher(link).forward(request, response);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
