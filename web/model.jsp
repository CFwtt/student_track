<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>测试JSON交互</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/statics/js/jquery-3.5.1.js">
    </script>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script>

        $(function () {
            $("button").click(function () {


                $.ajax({
                    url: "${pageContext.request.contextPath }/testJson1",
                    type: "post",
                    data: JSON.stringify({
                        "Name": "personListRequest",
                        "Data":
                            {
                                "Action": "getPerson",
                                "PersonType": 2,
                                "PersonId": "001",
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
                        tableContent += '<tr><td><img src="' + img + '"></td>';
                        tableContent += '<td>' + name + '</td></tr>';
                        $("tbody").append(tableContent);
                        // });

                    }
                })
            });

        });

    </script>
</head>
<body>
<button>测试JSON交互</button>
<%--<input type="button" value="测试JSON交互" onclick=" testJson()"/>--%>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-bordered table-condensed">
                <thead>
                <tr>
                    <th class="col-md-3">
                        库图片
                    </th>
                    <th class="col-md-2">
                        姓名
                    </th>
                    <th class="col-md-2">
                        编号
                    </th>
                    <th class="col-md-2">
                        交付时间
                    </th>
                    <th class="col-md-3">
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
