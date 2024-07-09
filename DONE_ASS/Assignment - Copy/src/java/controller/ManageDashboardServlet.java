package controller;

import dao.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Accounts;
import model.Customer;
import model.Order;

@WebServlet(name = "ManageDashboardServlet", urlPatterns = {"/dashboard"})
public class ManageDashboardServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        LocalDate curDate = LocalDate.now();
        String date = curDate.toString();

        DAO dao = new DAO();
        String year = String.valueOf(curDate.getYear());

        List<List<Order>> ordersByMonth = new ArrayList<>();
        for (int month = 1; month <= curDate.getMonthValue(); month++) {
            String monthStr = String.format("%02d", month);
            List<Order> orders = dao.getOrderInMonth(year, monthStr);
            ordersByMonth.add(orders);
        }

        List<Double> totalRevenue = new ArrayList<>();
        for (List<Order> monthOrders : ordersByMonth) {
            double monthTotal = 0.0;
            for (Order order : monthOrders) {
                monthTotal += order.getTotalMoney();
            }
            totalRevenue.add(monthTotal);
        }

        List<Order> listOrder = dao.getOrderInDay(date);
        List<Accounts> listAcc = dao.getAllAcc();
        List<Customer> listCus = dao.getAllCustomer();
        int total = dao.getTotalProduct();
        int low = dao.getOutOfStock();
        int totalCustomer = dao.getTotalCustomer();
        int totalOrder = dao.totalOrder();

        request.setAttribute("totalProduct", total);
        request.setAttribute("listOrder", listOrder);
        request.setAttribute("listAcc", listAcc);
        request.setAttribute("listCustomer", listCus);
        request.setAttribute("low", low);
        request.setAttribute("totalCustomer", totalCustomer);
        request.setAttribute("totalOrder", totalOrder);
        request.setAttribute("totalByMonth", totalRevenue);

        request.getRequestDispatcher("manage-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Manage Dashboard Servlet";
    }
}
