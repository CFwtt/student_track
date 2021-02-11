<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>测试JSON交互</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css" rel="stylesheet">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>

    <script>
        $(function () {
            $("#list").click(function () {

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
                    //定义回调响应的数据格式为JSON字符串,该属性可以省略
                    //dataType : "json",
                    success: function (data) {
                        var obj = eval("(" + data + ")");
                        $.each(obj.Data.PersonList, function (key, value) {
                            console.log(value.PersonId)
                            needID(value.PersonId);
                        })

                    }
                })

                function needID(ID) {
                    $.ajax({
                        url: "${pageContext.request.contextPath }/testJson1",
                        type: "post",
                        data: JSON.stringify({
                            "Name": "personListRequest",
                            "Data":
                                {
                                    "Action": "getPerson",
                                    "PersonType": 2,
                                    "PersonId": ID,
                                    "GetPhoto": 1
                                }
                        }),
                        contentType: "application/json;charset=UTF-8",
                        //定义回调响应的数据格式为JSON字符串,该属性可以省略
                        //dataType : "json",
                        success: function (data) {
                            var obj = eval("(" + data + ")");
                            console.log(obj.Name);
                            // $.each(obj.Data,function (i) {
                            tableContent = "";
                            var img = "data:image/jpg;base64," + obj.Data.PersonInfo.PersonPhoto;
                            var name = obj.Data.PersonInfo.PersonName;
                            tableContent += '<tr><td ><img  style="width: 120px;height: 120px;padding: 1px"src="' + img + '"></td>';
                            tableContent += '<td>' + ID + '</td>';
                            tableContent += '<td>' + name + '</td></tr>';
                            $("tbody").append(tableContent);
                            // });

                        }
                    })
                }


            });
        });

    </script>
</head>
<body>

<%--<input type="button" value="测试JSON交互" onclick=" testJson()"/>--%>
<div class="container">
    <div class="row clearfix">
        <div>
            <button id="list">查询所有学生</button>
            <button id="update">查询所有学生</button>
            <button id="add"
                    onclick="javascript:window.location.href='${pageContext.request.contextPath }/toAddStudeent'">添加学生</button>
            <button id="select">查询所有学生</button>
        </div>
        <div class="col-md-12 column">
            <table class="table table-bordered table-condensed table-layout: fixed">
                <thead>
                <tr>
                    <th style="width: 132px;">
                        库图片
                    </th>
                    <th>
                        学号
                    </th>
                    <th>
                        姓名
                    </th>
                    <th>
                        专业
                    </th>
                    <th>
                        状态
                    </th>
                </tr>
                </thead>
                <tbody id="content">

                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
