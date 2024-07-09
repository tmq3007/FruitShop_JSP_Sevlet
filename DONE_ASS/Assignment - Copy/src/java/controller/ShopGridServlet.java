package controller;

import dao.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Categories;
import model.Products;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@WebServlet(name = "ShopGridServlet", urlPatterns = {"/shopgrid"})
public class ShopGridServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO dao = new DAO();
        int from = 0;
        int to = (int) dao.getMaxprice() + 1;
        int index = 1;
        String sortOption = "default";

        try {
            if (request.getParameter("index") != null) {
                index = Integer.parseInt(request.getParameter("index"));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<Integer> cateIds = new ArrayList<>();
        String priceFrom = request.getParameter("minamount");
        String priceTo = request.getParameter("maxamount");

        try {
            if (priceFrom != null && !priceFrom.isEmpty()) {
                from = Integer.parseInt(priceFrom);
            }
            if (priceTo != null && !priceTo.isEmpty()) {
                to = Integer.parseInt(priceTo);
                if (to > (int) dao.getMaxprice()) {
                    to = (int) dao.getMaxprice();
                }
            }
            String[] cateIdsParam = request.getParameterValues("department");
            // Xử lý chọn "All" và không thêm các danh mục khác nếu chọn "All"
            if (cateIdsParam != null && cateIdsParam.length > 0) {
                for (String cateId : cateIdsParam) {
                    int id = Integer.parseInt(cateId);
                    if (id == -1) {
                        cateIds.clear(); // Xóa danh sách cateIds hiện tại
                        cateIds.add(-1); // Thêm chỉ -1 nếu chọn "All"
                        break;
                    } else {
                        cateIds.add(id); // Thêm các danh mục khác
                    }
                }
            } else {
                cateIds.clear();
                // Nếu không có lựa chọn nào, hiển thị tất cả các danh mục (All)
                cateIds.add(-1);
            }

            if (request.getParameter("sortOption") != null) {
                sortOption = request.getParameter("sortOption");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        List<Products> listDiscountProduct = dao.getDiscountProduct();
        List<Categories> listCategory = dao.getAllCategory();
        List<Products> listProducts = dao.getProductsByPriceRangeAndCategories(from, to, cateIds, index, sortOption);
        List<Products> listTopRating = dao.getTopRatingProducts();
        List<Products> list6LastRating = dao.get6LastProducts();
        List<Products> listReview = dao.getReviewProducts();

        if ("asc".equals(sortOption)) {
            Collections.sort(listProducts, Comparator.comparingDouble(Products::getDiscountedUnitPrice));
        } else if ("desc".equals(sortOption)) {
            Collections.sort(listProducts, (o1, o2) -> Double.compare(o2.getDiscountedUnitPrice(), o1.getDiscountedUnitPrice()));
        }

        int count = dao.getTotalProductByCategory(from, to, cateIds);
        int endPage = count / 9;
        if (count % 9 != 0) {
            endPage++;
        }

        HttpSession session = request.getSession();
        session.setAttribute("listProductDiscount", listDiscountProduct);
        session.setAttribute("from", from);
        session.setAttribute("to", to);
        request.setAttribute("selectedCategories", cateIds);
        session.setAttribute("sortOption", sortOption);

        request.setAttribute("listCategory", listCategory);
        request.setAttribute("listProducts", listProducts);
        request.setAttribute("endP", endPage);
        request.setAttribute("founded", listProducts.size());
        request.setAttribute("listTopRate", listTopRating);
        request.setAttribute("list6Last", list6LastRating);
        request.setAttribute("listReview", listReview);
        request.setAttribute("currentPage", index); // Set currentPage attribute
        request.getRequestDispatcher("shop-grid.jsp").forward(request, response);
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
