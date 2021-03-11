<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>测试JSON交互</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="${pageContext.request.contextPath}/statics/js/jquery-1.9.1.min.js"></script>

    <%--时间选择控件--%>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.zh-CN.js"></script>

    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/statics/css/icons.min.css" rel="stylesheet" >
    <link href="${pageContext.request.contextPath}/statics/css/theme.min.css" rel="stylesheet" >



    <script>

        $(function () {

            $('body').css("overflow-x","hidden");
            $('body').css("height","870px")

            // $("#datetimeStart").datetimepicker({
            //     format: 'yyyy-mm-dd',
            //     minView: 'month',
            //     language: 'zh-CN',
            //     autoclose: true,
            // });
            // $("#datetimeEnd").datetimepicker({
            //     format: 'yyyy-mm-dd',
            //     minView: 'month',
            //     language: 'zh-CN',
            //     autoclose: true,
            // });



            $("#check").click(function () {

                $.ajax({
                    url: "${pageContext.request.contextPath }/testJson1",
                    type: "post",
                    data: JSON.stringify({
                        "Name": "personListRequest",
                        "Data":
                            {
                                "Action": "getPersonList",
                                "PersonType": 2,
                                "PageNo": 1,
                                "PageSize": 1000
                            }
                    }),
                    contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        var obj = eval("(" + data + ")");
                        $.each(obj.Data.PersonList, function (key, value) {
                            needID(value.PersonId);
                        })

                    }
                })

                function needID(sno) {
                    $.ajax({
                        url: "${pageContext.request.contextPath }/testJson1",
                        type: "post",
                        data: JSON.stringify({
                            "Name": "personListRequest",
                            "Data":
                                {
                                    "Action": "getPerson",
                                    "PersonType": 2,
                                    "PersonId": sno,
                                    "GetPhoto": 1
                                }
                        }),
                        contentType: "application/json;charset=UTF-8",
                        success: function (data) {
                            var obj = eval("(" + data + ")");
                            tableContent = "";
                            var img = "data:image/jpg;base64," + obj.Data.PersonInfo.PersonPhoto;
                            var name = obj.Data.PersonInfo.PersonName;
                            var sex = obj.Data.PersonInfo.Sex;
                            if (sex === 1) {
                                sex = "男"
                            } else {
                                sex = "女"
                            }
                            ;
                            var major = obj.Data.PersonInfo.PersonExtension.PersonData1;
                            var grade = obj.Data.PersonInfo.PersonExtension.PersonData3;
                            var stu_cell = obj.Data.PersonInfo.Phone;
                            var parent_cell = obj.Data.PersonInfo.PersonExtension.PersonData4;

                            tableContent += '<tr><td>' + name + '</td>';
                            tableContent += '<td>' + sex + '</td>';
                            tableContent += '<td>' + sno + '</td>';
                            tableContent += '<td>' + major + '</td>';
                            tableContent += '<td>' + grade + '</td></tr>';

                            $("tbody").append(tableContent);
                            // });

                        }
                    })
                }

            });

        });
    </script>

<body>

<!-- Begin page -->
<div id="layout-wrapper">

    <!-- ========== Left Sidebar Start ========== -->
    <div class="vertical-menu">

        <div data-simplebar class="h-100">

            <div class="navbar-brand-box">

            </div>

            <!--- Sidemenu -->
            <div id="sidebar-menu">
                <!-- Left Menu Start -->
                <ul class="metismenu list-unstyled" id="side-menu">
                    <li class="menu-title">Menu</li>

                    <li>
                        <a href="mainTest.jsp" class="waves-effect"><i class='bx bx-home-smile'></i><span>Dashboard</span></a>
                    </li>

                    <li>
                        <a href="javascript: void(0);" class="has-arrow waves-effect"><i class="bx bx-cookie"></i><span>UI Elements</span></a>
                        <ul class="sub-menu" aria-expanded="false">
                            <li><a href="ui-buttons.html">Buttons</a></li>
                            <li><a href="ui-cards.html">Cards</a></li>
                            <li><a href="ui-carousel.html">Carousel</a>
                            <li><a href="ui-embeds.html">Embeds</a>
                            <li><a href="ui-general.html">General</a></li>
                            <li><a href="ui-grid.html">Grid</a></li>
                            <li><a href="ui-media-objects.html">Media Objects</a></li>
                            <li><a href="ui-modals.html">Modals</a></li>
                            <li><a href="ui-progressbars.html">Progress Bars</a></li>
                            <li><a href="ui-tabs.html">Tabs</a></li>
                            <li><a href="ui-typography.html">Typography</a></li>
                            <li><a href="ui-toasts.html">Toasts</a></li>
                            <li><a href="ui-tooltips-popovers.html">Tooltips & Popovers</a></li>
                            <li><a href="ui-scrollspy.html">Scrollspy</a></li>
                            <li><a href="ui-spinners.html">Spinners</a></li>
                            <li><a href="ui-sweetalerts.html">Sweet Alerts</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="javascript: void(0);" class="has-arrow waves-effect"><i class="bx bx-table"></i><span>Tables</span></a>
                        <ul class="sub-menu" aria-expanded="false">
                            <li><a href="tables-basic.html">Basic Tables</a></li>
                            <li><a href="tables-datatables.html">Data Tables</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="javascript: void(0);" class="has-arrow waves-effect"><i
                                class="bx bx-doughnut-chart"></i><span>Charts</span></a>
                        <ul class="sub-menu" aria-expanded="false">
                            <li><a href="charts-morris.html">Morris</a></li>
                            <li><a href="charts-google.html">Google</a></li>
                            <li><a href="charts-chartjs.html">Chartjs</a></li>
                            <li><a href="charts-sparkline.html">Sparkline</a></li>
                            <li><a href="charts-knob.html">Jquery Knob</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="javascript: void(0);" class="waves-effect"><i class="bx bxs-eraser"></i><span
                                class="badge badge-pill badge-soft-danger float-right">6</span><span>Forms</span></a>
                        <ul class="sub-menu" aria-expanded="false">
                            <li><a href="forms-elements.html">Elements</a></li>
                            <li><a href="forms-plugins.html">Plugins</a></li>
                            <li><a href="forms-validation.html">Validation</a></li>
                            <li><a href="forms-mask.html">Masks</a></li>
                            <li><a href="forms-quilljs.html">Quilljs</a></li>
                            <li><a href="forms-uploads.html">File Uploads</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="javascript: void(0);" class="has-arrow waves-effect"><i
                                class="bx bx-aperture"></i><span>Icons</span></a>
                        <ul class="sub-menu" aria-expanded="false">
                            <li><a href="icons-boxicons.html">Boxicons</a></li>
                            <li><a href="icons-materialdesign.html">Material Design</a></li>
                            <li><a href="icons-fontawesome.html">Font awesome 5</a></li>
                        </ul>
                    </li>

                    <li><a href="dark-sidenav.html" class="waves-effect"><i
                            class="bx bx-layout"></i><span>Dark Sidenav</span></a></li>

                    <li><a href="team.html" class="waves-effect"><i
                            class="bx bx-user-circle"></i><span>Team Members</span></a></li>

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
                                    <img src="assets/images/users/avatar-5.jpg"
                                         class="mr-3 rounded-circle avatar-xs" alt="user-pic">
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
                                    <img src="assets/images/users/avatar-8.jpg"
                                         class="mr-3 rounded-circle avatar-xs" alt="user-pic">
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
                        <img class="rounded-circle header-profile-user" src="assets/images/users/avatar-1.jpg"
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

        <div class="page-content">
            <div class="container-fluid">

                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box d-flex align-items-center justify-content-between">
                            <div style="float: right">当前位置：<a href="#">首页</a></div>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <div class="row">
                    <div class="col-xl-4 col-md-6">
                        <div class="card card-animate">
                            <div class="card-body">
                                <div class="avatar-sm float-right">
                                        <span class="avatar-title bg-soft-primary rounded-circle">
                                            <i class="bx bx-dollar-circle m-0 h3 text-primary"></i>
                                        </span>
                                </div>
                                <h6 class="text-muted text-uppercase mt-0">今日抓拍人数</h6>
                                <h3 class="my-3">123</h3>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4 col-md-6">
                        <div class="card card-animate">
                            <div class="card-body">
                                <div class="avatar-sm float-right">
                                        <span class="avatar-title bg-soft-primary rounded-circle">
                                            <i class="bx bx-analyse m-0 h3 text-primary"></i>
                                        </span>
                                </div>
                                <h6 class="text-muted text-uppercase mt-0">今日人员最密集场所</h6>
                                <h3 class="my-3"><span data-plugin="counterup">123</span></h3>

                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4 col-md-6">
                        <div class="card card-animate">
                            <div class="card-body" style="height: 115px;">
                                <div class="avatar-sm float-right">
                                        <span class="avatar-title bg-soft-primary rounded-circle">
                                            <i class="bx bx-basket m-0 h3 text-primary"></i>
                                        </span>
                                </div>
                                <h6 class="text-muted text-uppercase mt-0">今日无出行人员</h6>
                                <h3 class="my-3" data-plugin="counterup">123</h3>
                                <span class="badge badge-soft-primary mr-1">数据收集截止时间为每日23:00</span></div>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-lg-4">
                        <div class="card card-animate">
                            <div class="card-body">
                                <h4 class="card-title d-inline-block mb-3">最新抓拍</h4>
                                <div data-simplebar style="max-height: 380px;">
                                    <a href="#" class="d-flex align-items-center border-bottom py-3">
                                        <div class="mr-3">
                                            <img src="assets/images/users/avatar-2.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">Leonardo Payne</h6>
                                                <p class="text-muted font-size-11 mb-0">12.30 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">Hey! there I'm available...</p>
                                        </div>
                                    </a>

                                    <a href="#" class="d-flex align-items-center border-bottom py-3">
                                        <div class="mr-3">
                                            <img src="assets/images/users/avatar-3.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">Soren Drouin</h6>
                                                <p class="text-muted font-size-11 mb-0">09.30 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">Completed "Design new idea"....</p>
                                        </div>
                                    </a>

                                    <a href="#" class="d-flex align-items-center border-bottom py-3">
                                        <div class="mr-3">
                                            <img src="assets/images/users/avatar-4.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">Anne Simard</h6>
                                                <p class="text-muted font-size-11 mb-0">10.30 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">Assigned task "Poster illustation
                                                design"...</p>
                                        </div>
                                    </a>

                                    <a href="#" class="d-flex align-items-center border-bottom py-3">
                                        <div class="mr-3">
                                            <img src="assets/images/users/avatar-5.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">Nicolas Chartier</h6>
                                                <p class="text-muted font-size-11 mb-0">02.00 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">Completed "Drinking bottle
                                                graphics"...</p>
                                        </div>
                                    </a>

                                    <a href="#" class="d-flex align-items-center border-bottom py-3">
                                        <div class="mr-3">
                                            <img src="assets/images/users/avatar-6.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">Gano Cloutier</h6>
                                                <p class="text-muted font-size-11 mb-0">05.30 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">Assigned task "Hyper app
                                                design"...</p>
                                        </div>
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div> <!-- end col -->

                    <div class="col-lg-8">
                        <div class="card card-animate">
                            <div class="card-body">
                                <h4>XX班级学生</h4>
                                <div class="table-responsive">
                                    <table class="table table-borderless table-hover mb-0">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>姓名</th>
                                            <th>性别</th>
                                            <th>学号</th>
                                            <th>年级</th>
                                            <th>专业</th>
                                            <th>二级学院</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <th>1</th>
                                            <td>App design and development</td>
                                            <td>Arthur Powell</td>
                                            <td>Sun, 08/10</td>
                                            <td>$8,532</td>
                                            <td class="text-warning">In Process</td>
                                        </tr>
                                        <tr>
                                            <th>2</th>
                                            <td>Coffee detail page - Main Page</td>
                                            <td>Joan Lennox</td>
                                            <td>Fri, 17/10</td>
                                            <td>$5,350</td>
                                            <td class="text-success">Done</td>
                                        </tr>
                                        <tr>
                                            <th>3</th>
                                            <td>Poster illustation design</td>
                                            <td>Ronald Roesler</td>
                                            <td>Tue, 13/08</td>
                                            <td>$2,250</td>
                                            <td class="text-danger">Hold</td>
                                        </tr>
                                        <tr>
                                            <th>4</th>
                                            <td>Drinking bottle graphics</td>
                                            <td>Mickey Cochran</td>
                                            <td>Mon, 10/08</td>
                                            <td>$4,532</td>
                                            <td class="text-success">Done</td>
                                        </tr>
                                        <tr>
                                            <th>5</th>
                                            <td>Landing page design - Home</td>
                                            <td>Barry Trahan</td>
                                            <td>Thus, 03/09</td>
                                            <td>$1,555</td>
                                            <td class="text-warning">In Process</td>
                                        </tr>
                                        <tr>
                                            <th>6</th>
                                            <td>Company logo design</td>
                                            <td>James Grimes</td>
                                            <td>Sat, 07/19</td>
                                            <td>$9,352</td>
                                            <td class="text-success">Done</td>
                                        </tr>
                                        <tr>
                                            <th>7</th>
                                            <td>Product page redesign</td>
                                            <td>Philip Jetton</td>
                                            <td>Wed, 09/08</td>
                                            <td>$6,895</td>
                                            <td class="text-danger">Hold</td>
                                        </tr>
                                        <tr>
                                            <th>8</th>
                                            <td>Hero page - Main Page</td>
                                            <td>Amanda Salinas</td>
                                            <td>Sun, 02/20</td>
                                            <td>$3,895</td>
                                            <td class="text-success">Done</td>
                                        </tr>

                                        </tbody>
                                    </table>

                                </div>

                            </div>
                        </div>
                    </div> <!-- end col -->

                </div>
                <!-- end row-->

            </div> <!-- container-fluid -->
        </div>
        <!-- End Page-content -->

        <footer class="footer">

        </footer>

    </div>
    <!-- end main content-->

</div>
<!-- END layout-wrapper -->

<!-- Overlay-->
<div class="menu-overlay"></div>

</body>
</html>
