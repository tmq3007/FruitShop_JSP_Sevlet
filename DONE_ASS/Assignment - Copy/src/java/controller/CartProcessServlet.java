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
import model.Item;
import model.Products;

/**
 *
 * @author admin
 */@WebServlet(name = "CartProcessServlet", urlPatterns = {"/process"})
public class CartProcessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = null;
        Object o = session.getAttribute("cart");
        if (o != null) {
            cart = (Cart) o;
        } else {
            cart = new Cart();
        }
        DAO dao = new DAO();
        String tnum = request.getParameter("num");
        String tid = request.getParameter("id");
        int num, id;
        try {
            num = Integer.parseInt(tnum);
            id = Integer.parseInt(tid);

            Products p = dao.getProductsByID(tid);
            int currentQuantity = cart.getQuantityById(id);
            int totalQuantity = currentQuantity + num;

            if (totalQuantity > p.getQuantity()) {
                // Nếu tổng số lượng vượt quá số lượng trong kho, không thêm sản phẩm vào giỏ hàng
                request.setAttribute("error", "Cannot add more items than available in stock.");
            } else {
                if (num == -1 && currentQuantity <= 1) {
                    cart.removeItem(id);
                } else {
                    Item t = new Item(p, num, p.getDiscountedUnitPrice());
                    cart.addItem(t);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        List<Item> listItem = cart.getItems();
        session.setAttribute("cart", cart);
        session.setAttribute("totalMoney", cart.getTotalMoney());
        session.setAttribute("size", listItem.size());
        request.getRequestDispatcher("shoping-cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = null;
        Object o = session.getAttribute("cart");
        if (o != null) {
            cart = (Cart) o;
        } else {
            cart = new Cart();
        }
        DAO dao = new DAO();

        String tid = request.getParameter("id");
        int id = Integer.parseInt(tid);
        cart.removeItem(id);
        List<Item> listItem = cart.getItems();
        session.setAttribute("cart", cart);
        session.setAttribute("totalMoney", cart.getTotalMoney());
        session.setAttribute("size", listItem.size());
        request.getRequestDispatcher("shoping-cart.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
