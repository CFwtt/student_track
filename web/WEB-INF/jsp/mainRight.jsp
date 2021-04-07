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
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.zh-CN.js"></script>

    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">



    <script>

        $(function () {
            var pagetype;//判断分页类型
            var inputValue;//判断分页类型
            /* 加载页面第一时间从数据库拉取数据展示到页面 */
            $(document).ready(function () {
                //do something
               getAllPageData(1);
            })

            function getAllPageData(pageNum){
                console.log("getPageData:"+pagetype);
                console.log("pageNum:"+pageNum);
                $("#content").html("");
                pagetype=1;
                $.ajax({
                    url: "${pageContext.request.contextPath }/list/allStudent",
                    data:  {"page": pageNum },
                    method: "post",
                    success: function (data) {
                        var obj = data.list;
                        console.log(data);
                        tableContent1 = "";
                        if (obj.length > 0) {
                            for (var k = 0; k < obj.length - 1; k++) {
                                tableContent1 += '<tr><td>' + obj[k].name + '</td>';
                                tableContent1 += '<td>' + obj[k].sex + '</td>';
                                tableContent1 += '<td>' + obj[k].sno + '</td>';
                                tableContent1 += '<td>' + obj[k].grade + '</td>';
                                tableContent1 += '<td>' + obj[k].major + '</td>';
                                tableContent1 += '<td>' + obj[k].s_college + '</td>';
                                tableContent1 += '<td>' + '<button  " value="' + obj[k].sno + '" id="two" class="btn btn-info details">详情</button></tr>';
                            }
                            $("#content").append(tableContent1);
                        }
                        $("#page").text(pageNum);
                        $("#totalPage").text(data.pages);
                        $("#totalData").text(data.total);
                    }
                })
            }

            function getSearchPageData(pageNum,value){
                console.log("getSearchPageType:"+pagetype);
                console.log("getSearchPageNum:"+pageNum);
                console.log("getSearchPageValue:"+value);
                $("#content").html("");
                $.ajax({
                    url: "${pageContext.request.contextPath }/list/SearchStudent",
                    data:  {"page":pageNum,
                            "value":value},
                    method: "post",
                    success: function (data) {
                        console.log(data)
                        var obj = data.list;
                        tableContent = "";
                        if (obj.length > 0) {
                            for (var k = 0; k < obj.length; k++) {
                                tableContent += '<tr><td>' + obj[k].name + '</td>';
                                tableContent += '<td>' + obj[k].sex + '</td>';
                                tableContent += '<td>' + obj[k].sno + '</td>';
                                tableContent += '<td>' + obj[k].grade + '</td>';
                                tableContent += '<td>' + obj[k].major + '</td>';
                                tableContent += '<td>' + obj[k].s_college + '</td>';
                                tableContent += '<td>' + '<button  " value="' + obj[k].sno + '" id="two" class="btn btn-info details">详情</button></tr>';
                            }
                            $("#content").append(tableContent);
                        }
                        $("#page").text(data.pageNum);
                        $("#totalPage").text(data.pages);
                        $("#totalData").text(data.total);
                    }
                })
            }

            $(document).on("click", ".details", function () {
                var sno = $(this).val();
                $("#nameOrSno").attr("value",sno);
                alert(sno);

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
                } else {
                    document.SearchForm.action = "${pageContext.request.contextPath}/list/toDetails";
                    document.SearchForm.submit();
                }
            })

            $("#datetimeStart").datetimepicker({
                language: 'zh-CN',
                autoclose: true,
            });
            $("#datetimeEnd").datetimepicker({
                language: 'zh-CN',
                autoclose: true,
            });

            $('.card-body').css("overflow-x","hidden");

            //分配页码
            page=function(){
                var text = $("#page").text();
                if (pagetype===1){
                    getPageData(page);
                }else {
                    getSearchPageData(page,inputValue);
                }
            }
            //上一页
            prePage=function(){
                var text = $("#page").text();
                var page = parseInt(text)-1;
                if(page<1){
                    page=text;
                }
                $("#page").text(page);
                if (pagetype===1){
                    getAllPageData(page);
                }else {
                    getSearchPageData(page,inputValue);
                }
            }
            //下一页
            nextPage=function(){
                var text = $("#page").text();
                var page = parseInt(text)+1;
                console.log("nextPage:"+page);
                console.log("nextPage:"+parseInt($("#totalPage").text()));
                if(page>parseInt($("#totalPage").text())){
                    page=text;
                }
                $("#page").text(page);
                if (pagetype===1){
                    getAllPageData(page);
                }else {
                    getSearchPageData(page,inputValue);
                }
            }

            $("#nameOrSno").bind('input propertychange', function() {
                pagetype=0;
                $("#content").html("");
                var value = $("#nameOrSno").val();
                inputValue=value;
                var page=1;
                console.log("bindValue:"+value);
                $.ajax({
                    url: "${pageContext.request.contextPath }/list/SearchStudent",
                    data:  {"value": value,
                            "page":page},
                    method: "post",
                    success: function (data) {
                        console.log(data)
                        var obj = data.list;
                        tableContent = "";
                        if (obj.length > 0) {
                            for (var k = 0; k < obj.length; k++) {
                                tableContent += '<tr><td>' + obj[k].name + '</td>';
                                tableContent += '<td>' + obj[k].sex + '</td>';
                                tableContent += '<td>' + obj[k].sno + '</td>';
                                tableContent += '<td>' + obj[k].grade + '</td>';
                                tableContent += '<td>' + obj[k].major + '</td>';
                                tableContent += '<td>' + obj[k].s_college + '</td>';
                                tableContent += '<td>' + '<button  " value="' + obj[k].sno + '" id="two" class="btn btn-info details">详情</button></tr>';
                            }
                            $("#content").append(tableContent);
                        }
                        $("#page").text(data.pageNum);
                        $("#totalPage").text(data.pages);
                        $("#totalData").text(data.total);
                    }
                })
            })

        });
    </script>

    <style>
         th,td{
             text-align: center;
            vertical-align: middle!important;
             padding: 6px!important;
        }
        .details{
            height: 29px;width: 45px;
            padding-right: 0px;
            padding-left: 0px;
            padding-bottom: 9px;
        }
    </style>
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
                                <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg"
                                     class="rounded-circle avatar-sm"
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
                                <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg"
                                     class="rounded-circle avatar-sm"
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
                                <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg"
                                     class="rounded-circle avatar-sm"
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
                                <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg"
                                     class="rounded-circle avatar-sm"
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
                                <img src="${pageContext.request.contextPath}/statics/img/登陆头像.jpg"
                                     class="rounded-circle avatar-sm"
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

        <div  class="col-lg-8 ">
            <div class="card card-animate">
                <div  class="card-body ">

                    <div class="table-responsive overflow-hidden">
                        <form method="post" id="SearchForm" name="SearchForm">
                            <table class="table table-borderless table-hover mb-0">
                                <thead  class="thead-light firstContent">
                                <div class="row">
                                    <div class="col-sm-3 col-xs-2 right-bottom-start">
                                        <div class="input-group date" id="datetimeStart">
                                            <input data-date="1979-09-16T05:25:07Z"
                                                   data-date-format="dd MM yyyy - HH:ii p"
                                                   name="startDate" id="startDate" value="" type="text"
                                                   class="form-control"
                                                   placeholder="起始时间"/>
                                            <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                        </div>
                                    </div>
                                    <div class="col-sm-3 col-xs-5 right-bottom-end">
                                        <div class="input-group date" id="datetimeEnd">
                                            <input data-date="1979-09-16T05:25:07Z"
                                                   data-date-format="dd MM yyyy - HH:ii p"
                                                   name="endDate" id="endDate" type="text" value="" class="form-control"
                                                   placeholder="最终时间"/>
                                            <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-3 col-xs-11 inputSno">
                                        <div class="input-group date">
                                            <input name="sno" id="nameOrSno" style="width: 297px" type="text"
                                                   class="form-control"
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
                                <tbody id="content">

                                </tbody>

                            </table>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center" style="padding-right: 10%">
                                    <li class="page-item active">
                                        当前共<a class=" waves-effect" id="totalData"></a>条记录;共<a class=" waves-effect" id="totalPage"></a>页
                                    </li>
                                    <li class="page-item active">
                                        <a class=" waves-effect" onclick="prePage()" style="padding-top: 8px;padding-right: 8px;">上一页</a>
                                    </li>
                                    <li class="page-item active">
                                        <a class="page-link waves-effect" onclick="page()"  id="page"></a>
                                    </li>
                                    <li class="page-item active">
                                        <a class="waves-effect" onclick="nextPage()" style="padding-top: 8px;padding-left:  8px;">下一页</a>
                                    </li>
                                </ul>
                            </nav>
                        </form>
                    </div>

                </div>
            </div>
        </div> <!-- end col -->

    </div>
    <!-- end row-->

</div> <!-- container-fluid -->


</body>

</html>