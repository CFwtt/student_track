<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>测试JSON交互</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script src="${pageContext.request.contextPath}/statics/js/jquery-1.9.1.min.js"></script>

    <%--时间选择控件--%>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.zh-CN.js"></script>

    <link href="${pageContext.request.contextPath}/statics/css/modal_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/statics/css/comparison.css" rel="stylesheet">
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
                                tableContent1 += '<td>' + '<button " value="' + sno + '"  class="btn1">详情</button></tr>';
                            }
                            $("#content").append(tableContent1);
                        }
                    }
                })

            })

            $(document).on("click", ".btn1", function () {
                var sno = $(this).val();
                $(this).addClass('out');
                tableContent = "";
                tableContent = '<input name="sno" class="hidden" value="' + sno + '"/>';
                $(".out").append(tableContent);

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


            /*禁止页面横向拖动*/
            $('body').css("overflow-x", "hidden");
            $('body').css("height", "870px")
            /*日历控件设置*/
            $("#datetimeStart").datetimepicker({
                language: 'zh-CN',
                autoclose: true,
            });
            $("#datetimeEnd").datetimepicker({
                language: 'zh-CN',
                autoclose: true,
            });

            // $("#CheckVal").keyup(function () {
            //     $("table>tbody>tr")
            //         .hide()
            //         .filter(":contains('" + ($(this).val()) + "')")
            //         .show();
            // });
        });
    </script>

<body>

<div class="right-top">
    <div class="newDateFont">最新数据<p style="font-size: 10px;margin-bottom: 0">(数据收集截止时间每天23:00)</p></div>
    <div class="top-content">
        <ul>
            <li>今日抓拍人数<p><a href="#">123</a></p></li>
            <li>今日人员访问最多场所<p><a href="#">123</a></p></li>
            <li>今日无出行人员<p><a href="#">123</a></p></li>
        </ul>
    </div>
</div>
<div class="right-bottom">
    <form method="post" id="SearchForm" name="SearchForm">
        <table class="table table-condensed table-layout: fixed text-center right-bottom-table">
            <tbody>
            <thead id="content">
            <tr>
                <td colspan="6">
                    <div class="col-sm-4 col-xs-6 right-bottom-start">
                        <div class="input-group date" id="datetimeStart">
                            <input data-date="1979-09-16T05:25:07Z" data-date-format="dd MM yyyy - HH:ii p"
                                   name="startDate" id="startDate" value="" type="text" class="form-control"
                                   placeholder="起始时间"/>
                            <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                        </div>
                    </div>
                    <div class="col-sm-4 col-xs-6 right-bottom-end">
                        <div class="input-group date" id="datetimeEnd">
                            <input data-date="1979-09-16T05:25:07Z" data-date-format="dd MM yyyy - HH:ii p"
                                   name="endDate" id="endDate" type="text" value="" class="form-control"
                                   placeholder="最终时间"/>
                            <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>

                    <div class="col-sm-4 col-xs-12 inputSno">
                        <div class="input-group date">
                            <input name="CheckVal" id="CheckVal" style="width: 297px" type="text" class="form-control"
                                   placeholder="请输入姓名或学号查找">
                        </div>
                    </div>
                </td>
            </tr>

            <tr style="border-bottom: 1px solid rgb(240,242,245)">
                <th style="width: 14%">姓名</th>
                <th style="width: 8%">性别</th>
                <th style="width: 15%">学号</th>
                <th style="width: 10%">年级</th>
                <th style="width: 16%">专业</th>
                <th style="width: 16%">二级学院</th>
                <th style="width: 18%">详情</th>
            </tr>
            </thead>

            </tbody>
        </table>
    </form>

    <div class="Page" style="background-color: white">
        <nav style="float: right;padding-right: 43%;" aria-label="Page navigation">
            <ul style="vertical-align: center" class="pagination">
                <li>
                    <a href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li>
                    <a href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</div>
</body>
</html>
