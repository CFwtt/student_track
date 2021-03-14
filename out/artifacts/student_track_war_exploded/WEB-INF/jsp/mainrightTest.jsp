<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin & Dashboard Template</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <%--时间选择控件--%>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/daterangepicker.css" rel="stylesheet">



    <script>
        $(function () {
            /* 加载页面第一时间从数据库拉取数据展示到页面 */
            $(document).ready(function () {
                //do something
                $.ajax({
                    url: "${pageContext.request.contextPath }/list/allStudent",
                    method: "post",
                    contentType: "application/json;charset=UTF-8",
                    success: function (data) {
                        var startDate = $("startDate").val();
                        var endDate = $("endDate").val();
                        console.log(startDate + " " + endDate);
                        tableContent1 = "";
                        if (data.length > 0) {
                            for (var k = 0; k < data.length - 1; k++) {
                                var sno = data[k].sno;
                                tableContent1 += '<tr><td>' + data[k].name + '</td>';
                                tableContent1 += '<td>' + data[k].sex + '</td>';
                                tableContent1 += '<td>' + data[k].sno + '</td>';
                                tableContent1 += '<td>' + data[k].grade + '</td>';
                                tableContent1 += '<td>' + data[k].major + '</td>';
                                tableContent1 += '<td>' + data[k].s_college + '</td>';
                                tableContent1 += '<td>' + '<button  " value="' + sno + '" id="two" class="details">详情</button></tr>';
                            }
                            $("#content").append(tableContent1);
                        }
                    }
                })

            })

            $(document).on("click", ".details", function () {
                var sno = $(this).val();
                $(this).addClass('sno');
               tableContent = "";
               tableContent = '<input name="sno" class="hidden" value="' + sno + '"/>';
               $(".sno").append(tableContent);

                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();
                var startToUnix = Date.parse(startDate);
                var endToUnix = Date.parse(endDate);
                console.log("startToUnix:" + startToUnix)
                console.log("endToUnix:" + endToUnix)
                if (startDate.length == 0 || endDate.length == 0) {
                    alert("查询日期不能为空！");
                } else if (startToUnix > endToUnix) {
                    alert("起始时间不能小于最终时间!")
                }else {
                    document.SearchForm.action = "${pageContext.request.contextPath}/list/toDetails";
                    document.SearchForm.submit();
                }
            })




            // $("#CheckVal").keyup(function () {
            //     $("table>tbody>tr")
            //         .hide()
            //         .filter(":contains('" + ($(this).val()) + "')")
            //         .show();
            // });
        });
    </script>


</head>

<body>


    <!-- ============================================================== -->
    <!-- Start right Content here -->
    <!-- ============================================================== -->

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
                                            <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">张三</h6>
                                                <p class="text-muted font-size-11 mb-0">12.30 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">地点</p>
                                        </div>
                                    </a>

                                    <a href="#" class="d-flex align-items-center border-bottom py-3">
                                        <div class="mr-3">
                                            <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">李四</h6>
                                                <p class="text-muted font-size-11 mb-0">09.30 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">地点</p>
                                        </div>
                                    </a>

                                    <a href="#" class="d-flex align-items-center border-bottom py-3">
                                        <div class="mr-3">
                                            <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">王五</h6>
                                                <p class="text-muted font-size-11 mb-0">10.30 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">地点</p>
                                        </div>
                                    </a>

                                    <a href="#" class="d-flex align-items-center border-bottom py-3">
                                        <div class="mr-3">
                                            <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">李六</h6>
                                                <p class="text-muted font-size-11 mb-0">02.00 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">地点</p>
                                        </div>
                                    </a>

                                    <a href="#" class="d-flex align-items-center border-bottom py-3">
                                        <div class="mr-3">
                                            <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg" class="rounded-circle avatar-sm"
                                                 alt="user">
                                        </div>
                                        <div class="w-100">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="mb-1">赵七</h6>
                                                <p class="text-muted font-size-11 mb-0">05.30 PM</p>
                                            </div>
                                            <p class="text-muted font-size-13 mb-0">地点</p>
                                        </div>
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div> <!-- end col -->

                    <div class="col-lg-8">
                        <div class="card card-animate">
                            <div class="card-body">

                                <div class="table-responsive">
                                    <form method="post" id="SearchForm" name="SearchForm">
                                    <table class="table table-borderless table-hover mb-0">
                                        <thead id="content" class="thead-light">
                                        <div class="row">
                                            <div class="form-group mb-3 col-sm-4">
                                                <input type="text" class="form-control date " id="daterangetime" data-toggle="daterangepicker" data-time-picker="true" data-locale="{'format': 'DD/MM hh:mm A'}" placeholder="点击此处输入查询时间...">
                                            </div>
                                            <div class="col-sm-4 col-xs-12 inputSno">
                                                <div class="input-group date">
                                                    <input name="CheckVal" id="CheckVal" style="width: 297px" type="text" class="form-control"
                                                           placeholder="请输入姓名或学号查找">
                                                </div>
                                            </div>
                                        </div>
                                        <tr>
                                            <th>姓名</th>
                                            <th>性别</th>
                                            <th>学号</th>
                                            <th>年级</th>
                                            <th>专业</th>
                                            <th>二级学院</th>
                                            <th>详情</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </form>
                                </div>

                            </div>
                        </div>
                    </div> <!-- end col -->

                </div>
                <!-- end row-->

            </div> <!-- container-fluid -->
    <%--时间选择控件--%>

    <script src="https://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap-datepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/daterangepicker.js"></script>

</body>

</html>