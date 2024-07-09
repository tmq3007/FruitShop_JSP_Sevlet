package controller;

import dao.DAO;
import model.Accounts;
import model.Feedback;
import model.Products;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "VotingServlet", urlPatterns = {"/voting"})
public class VotingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAO dao = new DAO();
        HttpSession session = request.getSession();
        String id = request.getParameter("pid");
        if(id == null){
            id = request.getParameter("new_pid");
        }
        Products p = dao.getProductsByID(id);
        request.setAttribute("product", p);
        request.getRequestDispatcher("voting.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO dao = new DAO();
        HttpSession session = request.getSession();
        String id = request.getParameter("pid");
        String star = request.getParameter("star");
        String review = request.getParameter("review");
        Products p = dao.getProductsByID(id);
        Accounts acc = (Accounts) session.getAttribute("acc");

        if (acc == null) {
            request.setAttribute("error", "You have to login to review");
        } else {
            try {
                Feedback feedback = new Feedback();
                feedback.setCustomerId(acc.getId());
                feedback.setProductId(Integer.parseInt(id));
                feedback.setRating(Integer.parseInt(star));
                feedback.setComment(review);

                dao.feedback(feedback); // Assuming dao.feedback() handles database insertion
                request.setAttribute("successMessage", "Feedback submitted successfully");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to submit feedback");
            }
        }
        request.setAttribute("product", p);
        request.getRequestDispatcher("voting.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
