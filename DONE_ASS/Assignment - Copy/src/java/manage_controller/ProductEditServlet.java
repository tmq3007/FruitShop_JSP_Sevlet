package manage_controller;

import dao.DAO;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 *
 * @author admin
 */
@WebServlet(name="ProductEditServlet", urlPatterns={"/edit"})
public class ProductEditServlet extends HttpServlet {
   
   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName");
    String categoryId = request.getParameter("categoryId");
    String unitPrice = request.getParameter("unitPrice");
    String discount = request.getParameter("discount");
    String quantity = request.getParameter("quantity");
    String desciption = request.getParameter("desciption");
    
    // Kiểm tra ảnh
    String img = request.getParameter("img");
    if (img == null || img.isEmpty()) {
        img = request.getParameter("currentImg");
    } else {
        img = "image/" + img;
    }
    
    DAO dao = new DAO();
    dao.editProduct(productId, productName, categoryId, unitPrice, discount, quantity, desciption, img);
    response.sendRedirect("manageproduct");
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
        return "Short description";
    }
}
