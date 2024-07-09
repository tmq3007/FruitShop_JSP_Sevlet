<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>List Product</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <style>
            .app-header,
            .app-sidebar {
                background-color: #7FAD39;
                color: #fff; /* text color for header and sidebar */
            }
            .search-container {
                display: flex;
                align-items: center;
            }
            .app-menu__item:hover,
            .table .btn:hover {
                background-color: #6e9932;
            }

            .search-container input {
                width: 250px;
                height: 30px;
                padding: 5px 10px;
                margin-right: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .search-container button {

                padding: 5px 10px;
                border: none;
                background-color: #007bff;
                color: white;
                border-radius: 4px;
                cursor: pointer;
            }

            .search-container button:hover {
                background-color: #0056b3;
            }

            .dropdown-container {
                display: flex;
                align-items: center;
                margin-left: 10px;
            }

            .dropdown-container select {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid #ddd;
            }

            .pagination a.active {
                background-color: #007bff;
                color: white;
                border: 1px solid #007bff;
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }
        </style>
    </head>
    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">
                <!-- User Menu-->
                <li><a class="app-nav__item" href="home"><i class='bx bx-log-out bx-rotate-180'></i> </a></li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="admin/images/user.png" width="50px" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.acc.userName}</b></p>
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
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>List Product</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" href="productinsert" title="add"><i class="fas fa-plus"></i> Add Product</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()"><i
                                            class="fas fa-print"></i>Print Data</a>
                                </div>
                                <!-- Show Dropdown Button -->
                                <div class="dropdown-container">
                                    <form id="itemsPerPageForm" method="post" action="manageproduct">
                                        <label for="itemsPerPage">Show</label>
                                        <select name="itemsPerPage" onchange="document.getElementById('itemsPerPageForm').submit()">
                                            <option value="10" ${param.itemsPerPage == '10' ? 'selected' : ''}>10</option>
                                            <option value="25" ${param.itemsPerPage == '25' ? 'selected' : ''}>25</option>
                                            <option value="50" ${param.itemsPerPage == '50' ? 'selected' : ''}>50</option>
                                            <option value="100" ${param.itemsPerPage == '100' ? 'selected' : ''}>100</option>
                                        </select>
                                        <label for="itemsPerPage">Items</label>
                                    </form>
                                </div>
                                <!-- Search Button and Input -->
                                <div class="col-sm-4">
                                    <div class="search-container">
                                        <input type="text" id="searchInput" class="form-control" placeholder="Search for products...">
                                        <button class="btn btn-search btn-sm" type="button" onclick="searchTable()"><i class="fas fa-search"></i> Search</button>
                                    </div>
                                </div>
                            </div>
                            
                                <table class="table table-hover table-bordered" id="sampleTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Category</th>
                                            <th>Product Name</th>
                                            <th>Price</th>
                                            <th>Discount</th>
                                            <th>Quantity</th>
                                            <th>Feature</th>
                                            <th>Image</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listProducts}" var="p">
                                            <tr>
                                                <td>${p.id}</td>
                                                <c:forEach items="${listCategory}" var="c">
                                                    <c:if test="${p.categoryId == c.categoryId}">
                                                        <td>${c.categoryName}</td>
                                                    </c:if>
                                                </c:forEach>
                                                <td>${p.name}</td>
                                                <td>${p.unitPrice}</td>
                                                <td>${p.discount}</td>
                                                <td>${p.quantity}</td>
                                                <td>${p.desciption}</td>
                                                <td><img src="${p.imgURL}" alt="" width="100px;"></td>
                                                <td>
                                                    <button class="btn btn-primary btn-sm trash" type="button" title="Delete" onclick="confirmDelete(${p.id})">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                    <button class="btn btn-primary btn-sm edit" type="button" title="Edit" id="show-emp" data-toggle="modal" data-target="#ModalUP${p.id}">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <!-- MODAL -->
                                        <div class="modal fade" id="ModalUP${p.id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <form action="edit" method="POST">
                                            <div class="modal-dialog" role="document">
                                                <div class="row modal-content">
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div class="form-group col-md-12">
                                                                <span class="thong-tin-thanh-toan">
                                                                    <h5>Update product information</h5>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">ID</label>
                                                                <input class="form-control" type="text" readonly name="productId" value="${p.id}">
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Category</label>
                                                                <select class="form-control" name="categoryId">
                                                                    <c:forEach items="${listCategory}" var="c">
                                                                        <c:if test="${p.categoryId == c.categoryId}">
                                                                            <option selected value="${c.categoryId}">${c.categoryName}</option>
                                                                        </c:if>
                                                                        <c:if test="${p.categoryId != c.categoryId}">
                                                                            <option value="${c.categoryId}">${c.categoryName}</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Product Name</label>
                                                                <input class="form-control" type="text" required name="productName" value="${p.name}">
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Price</label>
                                                                <input class="form-control" type="text" required name="unitPrice" value="${p.unitPrice}">
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Discount</label>
                                                                <input class="form-control" type="text" required name="discount" value="${p.discount}">
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Quantity</label>
                                                                <input class="form-control" type="number" required name="quantity" value="${p.quantity}">
                                                            </div>
                                                            <div class="form-group col-md-12">
                                                                <label class="control-label">Feature</label>
                                                                <textarea class="form-control" required name="desciption">${p.desciption}</textarea>
                                                            </div>
                                                            <!-- Inside each modal -->
                                                            <div class="form-group col-md-12">
                                                                <label class="control-label">Image</label>
                                                                <div id="myfileupload">
                                                                    <input type="file" id="uploadfile" name="img" onchange="readURL(this, 'thumbimage${p.id}');" />
                                                                    <!-- Trường ẩn để lưu ảnh hiện tại -->
                                                                    <input type="hidden" name="currentImg" value="${p.imgURL}" />
                                                                </div>
                                                                <div id="thumbbox">
                                                                    <img height="450" width="400" alt="Thumb image" id="thumbimage${p.id}" src="${p.imgURL}" />
                                                                    <a class="removeimg" href="javascript:"></a>
                                                                </div>
                                                            </div>


                                                        </div>
                                                    </div>
                                                    <br>
                                                    <button class="btn btn-save" type="submit">Save</button>
                                                    <a class="btn btn-cancel" data-dismiss="modal" href="#">Cancel</a>
                                                </div>
                                            </div>
                                                                    </form>
                                        </div>
                                        <!-- END MODAL -->
                                    </c:forEach>

                                    </tbody>
                                </table>
                            
                        </div>
                        <!-- Pagination Controls -->
                        <div class="pagination">
                            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                <a href="?page=${pageNum}&itemsPerPage=${itemsPerPage}" class="${page == pageNum ? 'active' : ''}">${pageNum}</a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- Essential javascripts for application to work-->
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="admin/js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="admin/js/plugins/pace.min.js"></script>
        <script type="text/javascript" src="admin/js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="admin/js/plugins/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">$('#sampleTable').DataTable();</script>
        <script type="text/javascript">


            function searchTable() {
                var input = document.getElementById("searchInput");
                var filter = input.value.toLowerCase();
                var table = document.getElementById("sampleTable");
                var tr = table.getElementsByTagName("tr");

                for (var i = 1; i < tr.length; i++) {
                    var td = tr[i].getElementsByTagName("td");
                    var match = false;

                    for (var j = 0; j < td.length; j++) {
                        if (td[j]) {
                            if (td[j].innerHTML.toLowerCase().indexOf(filter) > -1) {
                                match = true;
                                break;
                            }
                        }
                    }

                    if (match) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        </script>
        <script>
            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('sampleTable');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                }
            }
        </script>
        <script>
            function confirmDelete(productId) {
                swal({
                    title: "Are you sure?",
                    text: "Once deleted, you will not be able to recover this product!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                // Redirect to delete action or perform AJAX delete request
                                window.location.href = "deleteproduct?pid=" + productId;
                            }
                        });
            }
            function  readURL(input, thumbimage) {
                if (input.files && input.files[0]) { // For Firefox and Chrome
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $("#" + thumbimage).attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                } else { // For IE
                    $("#" + thumbimage).attr('src', input.value);
                }
                $("#" + thumbimage).show();
                $('.filename').text($("#uploadfile").val());
                $('.Choicefile').css('background', '#14142B');
                $('.Choicefile').css('cursor', 'default');
                $(".removeimg").show();
                $(".Choicefile").unbind('click');
            }

        </script>

    </body>
</html>
