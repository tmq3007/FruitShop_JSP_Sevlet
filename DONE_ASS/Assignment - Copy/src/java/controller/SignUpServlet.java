/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.sendgrid.Content;
import com.sendgrid.Email;
import com.sendgrid.Mail;
import com.sendgrid.Request;
import com.sendgrid.Method;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;
import dao.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Accounts;

/**
 *
 * @author admin
 */
@WebServlet(name = "SignUpServlet", urlPatterns = {"/signup"})
public class SignUpServlet extends HttpServlet {

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String re_password = request.getParameter("repassword");

        String errorMessage = null;
        
        switch (validateInput(email, password, re_password)) {
            case 1:
                errorMessage = "Invalid email format";
                break;
            case 2:
                errorMessage = "Password do not match";
                break;
            default:
                DAO dao = new DAO();
                Accounts acc = dao.checkAccountExist(username); // Check if account already exists
                if (acc == null) {
                    dao.signUp(username, password, email);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                } else {
                    errorMessage = "User already exists";
                    break;
                }
        }

        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }

    private boolean isValidEmail(String email) {
        return email != null && email.matches(EMAIL_REGEX);
    }


    private int validateInput(String email, String password, String re_password) {
        if (!isValidEmail(email)) {
            return 1; // Invalid email format
        }

        if (!password.equals(re_password)) {
            return 2; // Passwords do not match
        }

        return 0; // No validation error
    }

    @Override
    public String getServletInfo() {
        return "SignUp Servlet";
    }
}
