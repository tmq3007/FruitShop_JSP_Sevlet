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
import model.Accounts;
import model.Customer;

/**
 *
 * @author admin
 */
@WebServlet(name="CustomerCheckoutServlet", urlPatterns={"/customer"})
public class CustomerCheckoutServlet extends HttpServlet {
   
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
         DAO dao = new DAO();
       String customerName= request.getParameter("customername");
       String contactname = request.getParameter("contactname");
       String country = request.getParameter("country");
       String address = request.getParameter("address");
       String city = request.getParameter("city");
       String phone = request.getParameter("phone");
       String email = request.getParameter("email");
       String password = request.getParameter("password");
       Accounts acc_new = dao.getAccount2(email, password);
        Accounts acc =(Accounts)session.getAttribute("acc");
       if(acc.getEmail().equals(acc_new.getEmail()) && acc.getPassword().equals(acc_new.getPassword())){
          int accountId = acc.getId();
            boolean customerExists = dao.customerExists(accountId);

            if (customerExists) {
                dao.updateCustomer(customerName, contactname, address, city, phone, country, accountId);
            } else {
                dao.addCustomer(customerName, contactname, address, city, phone, country, accountId);
            }

            Customer cus = new Customer(customerName, contactname, address, city, phone, country, accountId);
            session.setAttribute("cus", cus);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
       }else{
           request.setAttribute("error","Wrong email or password");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
       }
       
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
