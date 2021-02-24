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
<%--    <!--[if lt IE 9]>--%>
<%--    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>--%>
<%--    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>--%>
<%--    <![endif]-->--%>

<%--    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.js"></script>--%>

<%--    &lt;%&ndash;时间选择控件&ndash;%&gt;--%>
<%--    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet">--%>
<%--    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>--%>
<%--    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>--%>

<%--    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>--%>
<%--    <link href="${pageContext.request.contextPath}/css/comparison.css" rel="stylesheet">--%>



    <script>

        $(function () {

            $('body').css("overflow-x","hidden");
            $('body').css("height","870px")

            $("#datetimeStart").datetimepicker({
                format: 'yyyy-mm-dd',
                minView: 'month',
                language: 'zh-CN',
                autoclose: true,
            });
            $("#datetimeEnd").datetimepicker({
                format: 'yyyy-mm-dd',
                minView: 'month',
                language: 'zh-CN',
                autoclose: true,
            });

            $("#CheckVal").keyup(function () {
                $("table>tbody>tr")
                    .hide()
                    .filter(":contains('" + ($(this).val()) + "')")
                    .show();
            });

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
                    <table class="table table-condensed table-layout: fixed text-center right-bottom-table">
                        <tbody>

                        <thead>
                        <tr>
                            <td colspan="6">
                                <div class="col-sm-4 col-xs-6 right-bottom-start">
                                    <div class="input-group date" id="datetimeStart">
                                        <input id="startDate" type="text" class="form-control" placeholder="起始时间"/>
                                        <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                    </div>
                                </div>
                                <div class="col-sm-4 col-xs-6 right-bottom-end">
                                    <div class="input-group date" id="datetimeEnd">
                                        <input id="endDate" type="text" class="form-control" placeholder="最终时间"/>
                                        <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                                <div class="col-sm-4 col-xs-12 inputSno">

                                    <div class="input-group date" >
                                        <input id="CheckVal" style="width: 297px" type="text" class="form-control" placeholder="请输入姓名或学号查找">
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
                            <th style="width: 18%">抓拍时间</th>
                            <th>详情</th>
                        </tr>
                        </thead>
                        <tr>
                            <c:forEach items="" var="">

                            </c:forEach>
                        </tr>
                        </tbody>
                    </table>
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
