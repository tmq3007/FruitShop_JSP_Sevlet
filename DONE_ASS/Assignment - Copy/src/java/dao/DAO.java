/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author admin
 */
import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.text.ParseException;
import java.time.LocalDate;
import java.util.List;
import model.Accounts;
import model.Cart;

import model.Products;
import model.Categories;
import model.Customer;
import model.Feedback;
import model.Item;
import model.Order;
import model.OrderDetail;

public class DAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    //Order
    public List<Order> getOrderInMonth(String year, String month) {
        List<Order> list = new ArrayList<>();

        // Adjust query to match year and month
        String query = "SELECT * FROM Orders WHERE YEAR(orderdate) = ? AND MONTH(orderdate) = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, year);
            ps.setString(2, month);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDouble(4)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Order> getOrderInDay(String date) {
        List<Order> list = new ArrayList<>();
        String query = " select * from Orders where orderdate = ? ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, date);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDouble(4)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void addOrder(Accounts u, Cart cart) {
        LocalDate curDate = java.time.LocalDate.now();
        String date = curDate.toString();

        try {
            String query = "insert into Orders values(?,?,?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, u.getId());
            ps.setString(2, date);
            ps.setDouble(3, cart.getTotalMoney());

            ps.executeUpdate();

            String query2 = "SELECT TOP (1) [OrderID]\n"
                    + "  FROM [FruitShop].[dbo].[Orders]\n"
                    + "  order by [OrderID] desc ";
            PreparedStatement ps2 = conn.prepareStatement(query2);
            rs = ps2.executeQuery();

            while (rs.next()) {
                int oid = rs.getInt(1);
                for (Item i : cart.getItems()) {
                    String query3 = "insert into OrderDetails values(?,?,?,?)";
                    PreparedStatement ps3 = conn.prepareStatement(query3);
                    ps3.setInt(1, oid);
                    ps3.setInt(2, i.getProduct().getId());
                    ps3.setInt(3, i.getQuantity());
                    ps3.setDouble(4, i.getPrice());
                    ps3.executeUpdate();

                    String query4 = "update Products set Quantity = Quantity - ? where ProductID = ?";
                    PreparedStatement ps4 = conn.prepareStatement(query4);
                    ps4.setInt(1, i.getQuantity());
                    ps4.setInt(2, i.getProduct().getId());
                    ps4.executeUpdate();
                }

            }
        } catch (Exception e) {
        }
    }

    public void deleteOrder(String id) {
        try {
            String query = "delete from OrderDetails where OrderID = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();

            String query3 = "delete from Orders where OrderID = ? ";
            PreparedStatement ps3 = conn.prepareStatement(query3);
            ps3.setString(1, id);

            ps3.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<OrderDetail> getAllOrderDetail() {
        List<OrderDetail> list = new ArrayList<>();
        String query = " select * from OrderDetails ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getDouble(5)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<OrderDetail> getOrderDetailById(String id) {
        List<OrderDetail> list = new ArrayList<>();
        String query = " select * from OrderDetails where orderid =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getDouble(5)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Order> getAllOrder() {
        List<Order> list = new ArrayList<>();
        String query = " select * from Orders ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDouble(4)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public int totalOrder() {
        String query = "select count(*) from Orders";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    //PRODUCT DAO
    public void deleteProduct(String productId) {
        String query = "delete from products where ProductID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, productId);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void editProduct(String id, String name, String cateId, String price, String discount, String quantity, String description, String img) {

        String query = "update Products\n"
                + "set ProductName =?,\n"
                + "CategoryID = ?,\n"
                + "UnitPrice =?,\n"
                + "ImageURL =?,\n"
                + "[Description] =?,\n"
                + "Quantity =?,\n"
                + "Discount=?\n"
                + "where ProductID =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, cateId);
            ps.setString(3, price);
            ps.setString(4, img);
            ps.setString(5, description);
            ps.setString(6, quantity);
            ps.setString(7, discount);
            ps.setString(8, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void addProduct(String name, String cateId, String price, String discount, String quantity, String description, String img) {
        String query = "INSERT INTO Products (ProductName, CategoryID, UnitPrice, ImageURL, Description, Quantity, Discount) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, cateId);
            ps.setString(3, price);
            ps.setString(4, img);
            ps.setString(5, description);
            ps.setString(6, quantity);
            ps.setString(7, discount);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public double getMaxprice() {
        String query = " select max(unitprice) from Products ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;

    }

    public List<Products> getProductsByPage(int page, int itemsPerPage) {
        List<Products> list = new ArrayList<>();
        try {

            conn = new DBContext().getConnection();
            String sql = "SELECT * \n"
                    + "FROM products \n"
                    + "ORDER BY ProductID \n"
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
            ps = conn.prepareStatement(sql);

            ps.setInt(2, itemsPerPage);
            ps.setInt(1, (page - 1) * itemsPerPage);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalProduct() {
        String query = " SELECT COUNT(*) FROM Products ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getOutOfStock() {
        String query = " SELECT COUNT(*) FROM Products where quantity <=3";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getTotalProductByCategory(int from, int to, List<Integer> categoryIds) {
        if (categoryIds == null || categoryIds.isEmpty()) {
            return 0;
        }

        // Check if categoryIds contains -1 to select all categories
        boolean selectAll = categoryIds.contains(-1);

        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM Products WHERE UnitPrice >= ? AND UnitPrice <= ?");

        // If not selecting all categories, add WHERE clause for specific categories
        if (!selectAll) {
            query.append(" AND CategoryID IN (");
            for (int i = 0; i < categoryIds.size(); i++) {
                query.append("?");
                if (i < categoryIds.size() - 1) {
                    query.append(",");
                }
            }
            query.append(")");
        }

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(query.toString())) {
            ps.setInt(1, from);
            ps.setInt(2, to);

            // Set parameters for specific categories if not selecting all
            if (!selectAll) {
                for (int i = 0; i < categoryIds.size(); i++) {
                    ps.setInt(i + 3, categoryIds.get(i));
                }
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Products> pagingAccount(int index) {
        List<Products> list = new ArrayList<>();
        String query = "  select * from Products\n"
                + " order by ProductID\n"
                + " offset ? rows fetch next 9 row only ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, (index - 1) * 9);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Products> getDiscountProduct() {
        List<Products> list = new ArrayList<>();
        String query = " select * from Products where not discount =0 ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Products> getTop12Product() {
        List<Products> list = new ArrayList<>();
        String query = " SELECT TOP (12) [ProductID]\n"
                + "      ,[ProductName]\n"
                + "      ,[CategoryID]\n"
                + "      ,[UnitPrice]\n"
                + "      ,[ImageURL]\n"
                + "      ,[Description]\n"
                + "      ,[Quantity]\n"
                + "      ,[Discount]\n"
                + "  FROM [FruitShop].[dbo].[Products] ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Products> getAllProduct() {
        List<Products> list = new ArrayList<>();
        String query = " select * from Products ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Products> getProductByName(String name) {
        List<Products> list = new ArrayList<>();
        String query = " select * from Products where [ProductName] like ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Products> getTopRatingProducts() {
        List<Products> list = new ArrayList<>();
        String query = "  select *\n"
                + "  from Products\n"
                + "  join Feedback on Products.ProductID= Feedback.ProductID\n"
                + "  where Feedback.Rating=5  ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Products> getReviewProducts() {
        List<Products> list = new ArrayList<>();
        String query = "SELECT Products.*\n "
                + "FROM Products\n"
                + "JOIN Feedback ON Products.ProductID = Feedback.ProductID\n"
                + "WHERE Feedback.Comment LIKE '%Good%'\n"
                + "   OR Feedback.Comment LIKE '%Excellent%'\n"
                + "   OR Feedback.Comment LIKE '%Delicious%';";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Products> get6LastProducts() {
        List<Products> list = new ArrayList<>();
        String query = "  SELECT TOP (6) * "
                + "  FROM [FruitShop].[dbo].[Products]  ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Products> getProductsByCategoryID(String cid) {
        List<Products> list = new ArrayList<>();
        String query = "    SELECT * from products where CategoryID = ?  ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, cid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Products getProductsByID(String id) {
        String query = "    SELECT * from products where ProductID = ?  ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return (new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List<Products> getProductsByPriceRangeAndCategories(int from, int to, List<Integer> categoryIds, int index, String sortOption) {
        List<Products> list = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM products WHERE UnitPrice >= ? AND UnitPrice <= ?");

        if (categoryIds != null && !categoryIds.isEmpty() && !categoryIds.contains(-1)) { // Check if categoryIds is not null, not empty, and not containing -1 (which represents "All")
            query.append(" AND CategoryID IN (");
            for (int i = 0; i < categoryIds.size(); i++) {
                query.append("?");
                if (i < categoryIds.size() - 1) {
                    query.append(",");
                }
            }
            query.append(")");
        }

        // Handle sorting based on the selected sort option
        switch (sortOption) {
            case "asc":
                query.append(" ORDER BY UnitPrice ASC");
                break;
            case "desc":
                query.append(" ORDER BY UnitPrice DESC");
                break;
            case "default":
                query.append(" ORDER BY ProductID");
                break;
        }

        query.append(" OFFSET ? ROWS FETCH NEXT 9 ROWS ONLY");

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(query.toString())) {
            ps.setInt(1, from);
            ps.setInt(2, to);
            int paramIndex = 3;
            if (categoryIds != null && !categoryIds.isEmpty() && !categoryIds.contains(-1)) {
                for (int id : categoryIds) {
                    ps.setInt(paramIndex++, id);
                }
            }
            ps.setInt(paramIndex, (index - 1) * 9);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getDouble(8)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //CATEGORY DAO
    public List<Categories> getAllCategory() {
        List<Categories> list = new ArrayList<>();
        String query = " select * from Categories ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Categories(
                        rs.getInt(1),
                        rs.getString(2)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    //ACCOUNT DAO
    public Accounts getAccount(String username, String password) {
        String query = "select * from Accounts \n"
                + "where USERNAME = ? and \n"
                + "PasswordHash = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            while (rs.next()) {
                return (new Accounts(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5)
                ));
            }
        } catch (Exception e) {
        }
        return null;

    }

    public Accounts getAccount2(String email, String password) {
        String query = "select * from Accounts\n"
                + "where gmail = ? and PasswordHash = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            while (rs.next()) {
                return (new Accounts(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5)
                ));
            }
        } catch (Exception e) {
        }
        return null;

    }

    public List<Accounts> getAllAcc() {
        List<Accounts> list = new ArrayList<>();
        String query = "select * from Accounts  ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Accounts(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Accounts checkAccountExist(String username) {
        String query = "select * from Accounts\n"
                + "where Username = ? ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);

            rs = ps.executeQuery();
            while (rs.next()) {
                return (new Accounts(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5)
                ));
            }
        } catch (Exception e) {
        }
        return null;

    }

    public void setRole(String role, String id) {
        String query = "update Accounts set Role = ? where AccountID =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, role);
            ps.setString(2, id);

            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void signUp(String username, String password, String email) {
        String query = "insert into Accounts\n"
                + "values (?,?,?,2)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void forgotPass(String email, String username, String pass) {
        String query = "  update Accounts\n"
                + "  set PasswordHash ? \n"
                + "  where Gmail like ? and username like ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, pass);
            ps.setString(2, email);
            ps.setString(3, username);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteAcc(String id) {
        String query = " delete from Accounts where AccountID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    //CUSTOMER DAO
    public List<Customer> getAllCustomer() {
        List<Customer> list = new ArrayList<>();
        String query = " select * from Customers ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Customer(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public int getTotalCustomer() {
        String query = " SELECT COUNT(*) FROM Customers ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    //FEEDBACK
    public void feedback(Feedback feedback) {
        String query = " insert into Feedback\n"
                + "  values (?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, feedback.getCustomerId());
            ps.setInt(2, feedback.getProductId());
            ps.setInt(3, feedback.getRating());
            ps.setString(4, feedback.getComment());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Feedback> getFeedbackByProductID(int pid) {
        List<Feedback> list = new ArrayList<>();
        String query = "    SELECT [CustomerID]\n"
                + "      ,[ProductID]\n"
                + "      ,[Rating]\n"
                + "      ,[Comment] from [Feedback] where [ProductID] = ?  ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, pid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Feedback(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Feedback> getFeedback() {
        List<Feedback> list = new ArrayList<>();
        String query = "    SELECT [CustomerID]\n"
                + "      ,[ProductID]\n"
                + "      ,[Rating]\n"
                + "      ,[Comment] from [Feedback] ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
    
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Feedback(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4)
                ));
            }
        } catch (Exception e) {
        }
        return list;
    }
    //CATEGORY
    public void addCategory(String name) {
        String query = " insert into Categories\n"
                + "  values (?) ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCategory(String id) {
        String query = "delete from categories where CategoryID = ? ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
public boolean customerExists(int accountId) {
       
        boolean exists = false;
        
            String sql = "SELECT COUNT(*) FROM customers WHERE [AccountID]=?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, accountId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 
        
        return exists;
    }

public void updateCustomer(String customerName, String contactName, String address,
            String city, String phoneNumber, String country, int accountId) {
        String query = "UPDATE customers SET CustomerName=?, contactname=?, address=?, city=?, phonenumber=?, country=? WHERE AccountID=? ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, customerName);
            ps.setString(2, contactName);
            ps.setString(3, address);
            ps.setString(4, city);
            ps.setString(5, phoneNumber);
            ps.setString(6, country);
            ps.setInt(7, accountId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void addCustomer(String customerName, String contactName, String address,
            String city, String phoneNumber, String country, int accountId) {
        String query = "insert into Customers\n"
                + "  values (?,?,?,?,?,?,?) ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, customerName);
            ps.setString(2, contactName);
            ps.setString(3, address);
            ps.setString(4, city);
            ps.setString(5, phoneNumber);
            ps.setString(6, country);
            ps.setInt(7, accountId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    
    public Customer getCustomerByAccId(String id) {
        String query = "SELECT *\n"
                + "  FROM  [Customers]\n"
                + "  where [AccountID] =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);

            rs = ps.executeQuery();
            while (rs.next()) {
                return (new Customer(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8)
                ));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Customer getCustomerByAccIdInt(int id) {
        String query = "SELECT *\n"
                + "  FROM  [Customers]\n"
                + "  where [AccountID] =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);

            rs = ps.executeQuery();
            while (rs.next()) {
                return (new Customer(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8)
                ));
            }
        } catch (Exception e) {
        }
        return null;
    }

    /* 
    INSERT INTO Products (ProductName, CategoryID, UnitPrice, ImageURL,
[Description],Quantity, Discount) 
VALUES 
(N'cucumber', 3, 2.00, '', 'Cucumber is an annual climbing or spreading vine and common vegetable grown for its crisp, green fruit. It is a member of the Cucurbitaceae (gourd) family, and its native growing region is Himalaya to northern Thailand. Cucumber plants can grow 
8 to 18 inches high and 3 to 8 feet wide.',10,0)
     */
    public static void main(String[] args) throws ParseException {
        DAO dao = new DAO();
        double rate = 0;
        List<Feedback> listFeedback = dao.getFeedbackByProductID(2);
        for (Feedback feedback : listFeedback) {
            rate += feedback.getRating();
        }
        if (listFeedback.size() > 0) {
            //rate = rate / (double) listFeedback.size();
        }

        int fullStars = (int) rate; // Phần nguyên của rate là số sao
        double fractionalPart = rate - fullStars;

        boolean hasHalfStar = false;
        if (fractionalPart > 0) {
            hasHalfStar = true;
        }
        System.out.println(dao.getAllCustomer());
        //dao.deleteAcc("4");
        //addProduct(String name, String cateId, String price, String discount, String quantity, String description, String img) ;
        //dao.addCustomer("Trinh Tran Phuong Tuan", "Mr. Tuan", "123 AAA", "HCM", "12345678", "Viet Nam", 3);
    }
}
