<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin & Dashboard Template</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- App css -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/icons.min.css" rel="stylesheet" >
    <link href="${pageContext.request.contextPath}/assets/css/theme.min.css" rel="stylesheet" >

    <!-- jQuery  -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/metismenu.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/waves.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>

</head>

<body>

<!-- Begin page -->
<div id="layout-wrapper">

    <!-- ========== Left Sidebar Start ========== -->
    <div class="vertical-menu">

        <div data-simplebar class="h-100">

            <div class="navbar-brand-box hidden-xs" style="background-color: rgb(6,120,244)">
                <img class="hidden-xs" style="width:100%;height: 100%" src="${pageContext.request.contextPath}/statics/img/logo.png">
            </div>

            <!--- Sidemenu -->
            <div id="sidebar-menu">
                <!-- Left Menu Start -->
                <ul class="metismenu list-unstyled" id="side-menu">
                    <li class="menu-title">Menu</li>

                    <li>
                        <a href="mainTest.jsp" class="waves-effect"><i class='bx bx-home-smile'></i><span>人脸抓拍</span></a>
                    </li>

                    <li><a href="team.html" class="waves-effect"><i
                            class="bx bx-user-circle"></i><span>人像管理</span></a>
                    </li>

                    <li>
                        <a href="javascript: void(0);" class="waves-effect"><i class="bx bxs-eraser"></i><span>基础设置</span></a>
                    </li>

                    <li><a href="dark-sidenav.html" class="waves-effect"><i
                            class="bx bx-layout"></i><span>权限管理</span></a>
                    </li>



                </ul>
            </div>
            <!-- Sidebar -->
        </div>
    </div>
    <!-- Left Sidebar End -->

    <header id="page-topbar">
        <div class="navbar-header">

            <div class="d-flex align-items-left">
                <button type="button" class="btn btn-sm mr-2 d-lg-none px-3 font-size-16 header-item waves-effect"
                        id="vertical-menu-btn">
                    <i class="fa fa-fw fa-bars"></i>
                </button>
            </div>

            <div class="d-flex align-items-center">

                <div class="dropdown d-inline-block">
                    <button type="button" class="btn header-item noti-icon waves-effect"
                            id="page-header-notifications-dropdown" data-toggle="dropdown" aria-haspopup="true"
                            aria-expanded="false" style="padding-right: 20px;">
                        <i class="mdi mdi-bell-outline"></i>
                        <span class="badge badge-danger badge-pill">3</span>
                    </button>
                    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right p-0"
                         aria-labelledby="page-header-notifications-dropdown">
                        <div class="p-3">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h6 class="m-0"> Notifications </h6>
                                </div>
                                <div class="col-auto">
                                    <a href="#!" class="small font-weight-bold"> View All</a>
                                </div>
                            </div>
                        </div>
                        <div data-simplebar style="max-height: 230px;">
                            <a href="" class="text-reset notification-item">
                                <div class="media">
                                    <div class="media-body">
                                        <h6 class="mt-0 mb-1">Samuel Coverdale</h6>
                                        <p class="font-size-12 mb-1">You have new follower on Instagram</p>
                                        <p class="font-size-11 font-weight-bold mb-0 text-muted"><i
                                                class="mdi mdi-clock-outline"></i> 2 min ago</p>
                                    </div>
                                </div>
                            </a>
                            <a href="" class="text-reset notification-item">
                                <div class="media">
                                    <div class="avatar-xs mr-3">
                                            <span class="avatar-title bg-primary rounded-circle">
                                                <i class="mdi mdi-cloud-download-outline"></i>
                                            </span>
                                    </div>
                                    <div class="media-body">
                                        <h6 class="mt-0 mb-1">Download Available !</h6>
                                        <p class="font-size-11 mb-1">Latest version of admin is now available.
                                            Please download here.</p>
                                        <p class="font-size-11 font-weight-bold mb-0 text-muted"><i
                                                class="mdi mdi-clock-outline"></i> 4 hours ago</p>
                                    </div>
                                </div>
                            </a>
                            <a href="" class="text-reset notification-item">
                                <div class="media">

                                    <div class="media-body">
                                        <h6 class="mt-0 mb-1">Victoria Mendis</h6>
                                        <p class="font-size-12 mb-1">Just upgraded to premium account.</p>
                                        <p class="font-size-11 font-weight-bold mb-0 text-muted"><i
                                                class="mdi mdi-clock-outline"></i> 1 day ago</p>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="p-2">
                            <a class="btn btn-sm btn-link btn-block text-center font-size-14" href="javascript:void(0)">
                                Load More.. <i class="mdi mdi-arrow-right ml-1"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="dropdown d-inline-block">
                    <button type="button" class="btn header-item waves-effect" id="page-header-user-dropdown"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img class="rounded-circle header-profile-user" src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg"
                             alt="Header Avatar">
                        <span class="d-none d-sm-inline-block ml-1">Jamie D.</span>
                        <i class="mdi mdi-chevron-down d-none d-sm-inline-block"></i>
                    </button>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item d-flex align-items-center justify-content-between"
                           href="javascript:void(0)">
                            个人资料
                        </a>
                        <a class="dropdown-item d-flex align-items-center justify-content-between"
                           href="javascript:void(0)">
                            <span>退出账号</span>
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </header>

    <!-- ============================================================== -->
    <!-- Start right Content here -->
    <!-- ============================================================== -->
    <div class="main-content">

        <jsp:include page="${mainright==null?'mainrightTest.jsp':mainright}"></jsp:include>

    </div>
    <!-- end main content-->

</div>
<!-- END layout-wrapper -->

<!-- Overlay-->
<div class="menu-overlay"></div>



<!-- Morris Custom Js-->
<script src="${pageContext.request.contextPath}/assets/pages/dashboard-demo.js"></script>

<!-- App js -->
<script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
<!-- Morris Js-->
<script src="${pageContext.request.contextPath}/assets/js/morris.min.js"></script>
<!-- Raphael Js-->
<script src="${pageContext.request.contextPath}/assets/js/raphael.min.js"></script>

</body>

</html>