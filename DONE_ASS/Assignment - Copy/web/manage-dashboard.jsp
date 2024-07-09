<%-- 
    Document   : index
    Created on : Oct 19, 2021, 11:22:48 PM
    Author     : Khuong Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Admin Dashboard</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://www.gstatic.com/charts/loader.js"></script>
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <style>
            .app-header,
            .app-sidebar {
                background-color: #7FAD39;
                color: #fff; /* text color for header and sidebar */
            }
            .btn-save:hover,
            .app-menu__item:hover,
            .table .btn:hover {
                background-color: #6e9932;
            }
            .breadcrumb-item a,
            #clock {
                color: #7FAD39;
            }





            .table .btn {
                background-color: #7FAD39;
                color: #fff;
            }

            .charts {
                display: flex;
                flex-wrap: wrap;
            }
            .charts .chart {
                width: 50%;
            }
        </style>
    </head>

    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- User Menu-->
                <li><a class="app-nav__item" href="home"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="admin/images/user.png" width="50px"
                                                alt="User Image">
                <div>
                    <p class="app-sidebar__user-name">
                        <b>
                            <c:if test="${sessionScope.acc != null}">
                                <c:forEach var="c" items="${sessionScope.listCus}">
                                    <c:if test="${c.accountId == sessionScope.acc.id}">
                                        ${c.contactName}
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </b>
                    </p>
                    <p class="app-sidebar__user-designation">Welcome Back</p>
                </div>
            </div>
            <hr>
             <ul class="app-menu">
                <li><a class="app-menu__item" href="dashboard"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Dash Board</span></a></li>
                <li><a class="app-menu__item" href="managecustomer"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Manage Account</span></a></li>
                <li><a class="app-menu__item" href="manageproduct"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Manage Product</span></a>
                </li>
                <li><a class="app-menu__item" href="manageorder"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Manage Order</span></a></li>
                <li><a class="app-menu__item" href="managefeedback" ><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Feedback check</span></a></li>
            </ul>
        </aside>
        <main class="app-content">
            <div class="row">
                <div class="col-md-12">
                    <div class="app-title">
                        <ul class="app-breadcrumb breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><b>Dashboard</b></a></li>
                        </ul>
                        <div id="clock"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="row">
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                <div class="info">
                                    <h4>Total customer</h4>
                                    <p><b>${requestScope.totalCustomer} customer</b></p>
                                    <p class="info-tong">Total number of managed customers.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small info coloured-icon">
                                <i class='icon bx bxs-data fa-3x'></i>
                                <div class="info">
                                    <h4>Total Products</h4>
                                    <p><b>${requestScope.totalProduct} products</b></p>
                                    <p class="info-tong">Total number of managed products.</p>
                                </div>
                            </div>
                        </div>

                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small warning coloured-icon"><i class='icon bx bxs-shopping-bags fa-3x'></i>
                                <div class="info">
                                    <h4>Total order</h4>
                                    <p><b>${requestScope.totalOrder} order</b></p>
                                    <p class="info-tong">Total order.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small danger coloured-icon"><i class='icon bx bxs-error-alt fa-3x'></i>
                                <div class="info">
                                    <h4>Almost out of stock</h4>
                                    <p><b>${requestScope.low} product</b></p>
                                    <p class="info-tong">The warning number of products is out of stock and needs to be added.</p>
                                </div>
                            </div>
                        </div>
                        <%--chart--%>
                        <div class="col-md-6" id="myChartBar"  style="width: 600px ; height: 500px; margin-bottom: 20px;" >

                        </div>
                        <div class="col-md-6" id="myChartLine"  style="width: 600px ; height: 500px; margin-bottom: 20px;" >

                        </div>

                        <!-- col-12 -->
                        <div class="col-md-12">
                            <div class="tile">
                                <h3 class="tile-title">Order Today</h3>
                                <div>
                                    <table class="table table-hover  table-bordered">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Customer</th>
                                                <th>Phone</th>
                                                <th>Address</th>
                                                <th>City</th>
                                                <th>Country</th> <!-- Changed from <td> to <th> -->
                                                <th>Order Date</th>
                                                <th>Total</th>

                                                <th>Feature</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listOrder}" var="b">
                                                <tr>
                                                    <td>${b.orderId}</td>
                                                    <c:forEach items="${listCustomer}" var="c">
                                                        <c:if test="${c.accountId == b.customerId}">
                                                            <td>${c.customerName}</td>
                                                            <td>${c.phoneNumber}</td>
                                                            <td>${c.address}</td>
                                                            <td>${c.city}</td>
                                                            <td>${c.country}</td>
                                                        </c:if>
                                                    </c:forEach>
                                                    <td>${b.orderDate}</td>
                                                    <td>${b.totalMoney}</td>

                                                    <td>
                                                        <a style="color: rgb(245, 157, 57); background-color: rgb(251, 226, 197); padding: 5px; border-radius: 5px;" href="manageorderdetail?id=${b.orderId}">
                                                            <i class="fa"></i>Show detail
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- / div trống-->
                            </div>
                        </div>
                        <!-- / col-12 -->
                    </div>
                </div>
            </div>


            <!--            <div class="text-center" style="font-size: 13px">
                            <p><b>Copyright
                                    <script type="text/javascript">
                                        document.write(new Date().getFullYear());
                                    </script> Phần mềm quản lý Website
                                </b></p>
                        </div>-->
        </main>
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="admin/js/popper.min.js"></script>
        <script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
        <!--===============================================================================================-->
        <script src="admin/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="admin/js/main.js"></script>
        <!--===============================================================================================-->
        <script src="admin/js/plugins/pace.min.js"></script>
        <!--===============================================================================================-->
        <!--===============================================================================================-->
       <script>
    google.charts.load("current", {packages: ["corechart"]});
    google.charts.setOnLoadCallback(drawCharts);

    function drawCharts() {
        // Set Data
        const data = google.visualization.arrayToDataTable([
            ["Month", "Revenue"],
            <c:forEach var="revenue" items="${totalByMonth}" varStatus="status">
                <c:choose>
                    <c:when test="${status.index == 0}">
                        ["January", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 1}">
                        ["February", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 2}">
                        ["March", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 3}">
                        ["April", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 4}">
                        ["May", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 5}">
                        ["June", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 6}">
                        ["July", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 7}">
                        ["August", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 8}">
                        ["September", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 9}">
                        ["October", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 10}">
                        ["November", ${revenue}],
                    </c:when>
                    <c:when test="${status.index == 11}">
                        ["December", ${revenue}]
                    </c:when>
                </c:choose>
            </c:forEach>
        ]);

        // Set Options for Line Chart
        const lineChartOptions = {
            title: "Revenue By Month",
            hAxis: {title: "Month"},
            vAxis: {title: "Revenue"},
            legend: "none",
            colors: ["#7FAD39"] // Change the line color to #7FAD39
        };

        // Draw Line Chart
        const lineChart = new google.visualization.LineChart(document.getElementById("myChartLine"));
        lineChart.draw(data, lineChartOptions);

        // Set Options for Bar Chart
        const barChartOptions = {
            title: "Revenue By Month",
            colors: ["#7FAD39"] // Change the bar color to #7FAD39
        };

        // Draw Bar Chart
        const barChart = new google.visualization.BarChart(document.getElementById("myChartBar"));
        barChart.draw(data, barChartOptions);
    }
</script>

        <script type="text/javascript">
            //Thời Gian
            function time() {
                var today = new Date();
                var weekday = new Array(7);
                weekday[0] = "Sunday";
                weekday[1] = "Monday";
                weekday[2] = "Tuesday";
                weekday[3] = "Wednesday";
                weekday[4] = "Thursday";
                weekday[5] = "Friday";
                weekday[6] = "Saturday";
                var day = weekday[today.getDay()];
                var dd = today.getDate();
                var mm = today.getMonth() + 1;
                var yyyy = today.getFullYear();
                var h = today.getHours();
                var m = today.getMinutes();
                var s = today.getSeconds();
                m = checkTime(m);
                s = checkTime(s);
                nowTime = h + "h" + m + "m" + s + "s";
                if (dd < 10) {
                    dd = '0' + dd
                }
                if (mm < 10) {
                    mm = '0' + mm
                }
                today = day + ', ' + dd + '/' + mm + '/' + yyyy;
                tmp = '<span class="date"> ' + today + ' - ' + nowTime +
                        '</span>';
                document.getElementById("clock").innerHTML = tmp;
                clocktime = setTimeout("time()", "1000", "Javascript");

                function checkTime(i) {
                    if (i < 10) {
                        i = "0" + i;
                    }
                    return i;
                }
            }
        </script>
    </body>

</html>