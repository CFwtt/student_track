<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin & Dashboard Template</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <style>
        .text-muted{
            margin-bottom: 3px;
        }
        .card-body{
            padding-right: 10px!important;
        }
    </style>

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
                            for (var k = 0; k < data.length; k++) {

                                tableContent1 += '<div class="col-xl-2 col-lg-3">'
                                tableContent1 += '<div class="card card-animate">'
                                tableContent1 += '<img class="card-img-top img-fluid" src="data:image/jpeg;base64,'+data[k].face+'" alt="Card image cap">'
                                tableContent1 += '<div class="card-body">'
                                tableContent1 += '<h5 class="mb-1">'+data[k].name+'</h5>'
                                tableContent1 += '<p class="text-muted font-size-15">'+data[k].sex+'</p>'
                                tableContent1 += '<p class="text-muted font-size-15">'+data[k].sno+'</p>'
                                tableContent1 += '<p class="text-muted font-size-15">'+data[k].grade+'</p>'
                                tableContent1 += '<p class="text-muted font-size-15">'+data[k].major+'</p>'
                                tableContent1 += '<p class="text-muted font-size-15">'+data[k].s_college+'</p>'
                                tableContent1 += '<p class="text-muted font-size-15">'+data[k].phone+'</p>'
                                tableContent1 += '<p class="text-muted font-size-15">'+data[k].add_time+'</p>'

                                tableContent1 += '<div class="custom-control custom-checkbox custom-control-inline">'
                                tableContent1 += '<input type="checkbox" class="custom-control-input" class="customCheck">'
                                tableContent1 += '<label class="custom-control-label" for="customCheck"></label>'
                                tableContent1 += '</div>'
                                tableContent1 += '</div>'
                                tableContent1 += '</div>'
                                tableContent1 += '</div>'
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

<div class="container-fluid">

    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                <div style="float: right">当前位置：<a href="#">人像库</a></div>
            </div>
        </div>
    </div>
    <!-- end page title -->
    <div class="row">
        <div class="col-12">
            <div class="card card-animate">
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-8">
                            <form class="form-inline">
                                <div class="form-group">
                                    <label for="inputPassword2" class="mr-2">Search: </label>
                                    <input type="search" class="form-control" id="inputPassword2" placeholder="Search...">
                                </div>
                                <div class="form-group mx-sm-3">
                                    <label for="status-select" class="mr-2">Sort By: </label>
                                    <select class="custom-select" id="status-select">
                                        <option selected="">All</option>
                                        <option value="1">Name</option>
                                        <option value="2">Post</option>
                                        <option value="3">Followers</option>
                                        <option value="4">Followings</option>
                                    </select>
                                </div>
                                <div class="dropdown d-none d-sm-inline-block">
                                    <button id="addButton" class="btn"
                                            data-toggle="dropdown" >
                                        <i class="mdi mdi-plus"></i><a class="d-sm-inline-block" href="${pageContext.request.contextPath}/menu/toAddStudents">添加人像</a>
                                    </button>
                                </div>
                            </form>
                        </div>

                    </div> <!-- end row -->
                </div>
            </div> <!-- end card-box -->
        </div><!-- end col-->
    </div>
    <!-- end row -->

    <div id="content" class="row">

    </div>
    <!-- end row-->

    <div class="row">
        <div class="col-12">
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-end">
                    <li class="page-item">
                        <a class="page-link" href="javascript: void(0);" tabindex="-1">Previous</a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="javascript: void(0);">1</a></li>
                    <li class="page-item"><a class="page-link" href="javascript: void(0);">2</a></li>
                    <li class="page-item"><a class="page-link" href="javascript: void(0);">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="javascript: void(0);">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
    <!-- end row-->

</div> <!-- container-fluid -->

</body>

</html>