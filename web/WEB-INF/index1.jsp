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
                            if (sex===1){sex="男"}else{sex="女"};
                            var major = obj.Data.PersonInfo.PersonExtension.PersonData1;
                            var grade = obj.Data.PersonInfo.PersonExtension.PersonData3;
                            var stu_cell = obj.Data.PersonInfo.Phone;
                            var parent_cell = obj.Data.PersonInfo.PersonExtension.PersonData4;
                            tableContent += '<tr><td><input name="selectFlag" type="checkbox" value="'+sno+'"></td>';
                            tableContent += '<td ><img  style="width: 120px;height: 125px;" src="' + img + '"></td>';
                            tableContent += '<td>' + name + '</td>';
                            tableContent += '<td>' + sex + '</td>';
                            tableContent += '<td>' + sno + '</td>';
                            tableContent += '<td>' + major + '</td>';
                            tableContent += '<td>' + grade + '</td>';
                            tableContent += '<td>' + stu_cell + '</td>';
                            tableContent += '<td>' + parent_cell + '</td>';
                            tableContent += '<td>';
                            tableContent += '<a href="${pageContext.request.contextPath }/toUpdate/'+sno+'">编辑</a>';
                            tableContent +=  '</td></tr>';
                            $("tbody").append(tableContent);
                            // });

                        }
                    })
                }

            });

            $("#delete").click(function () {
                $("input[name=selectFlag][type=checkbox]").each(function () {
                    var arr = $(this).val();
                    if ($(this).prop("checked")){
                        $.ajax({
                            url: "${pageContext.request.contextPath }/testJson1",
                            type: "post",
                            data: JSON.stringify({
                                    "Name" : "personListRequest",
                                    "Data" :
                                        {
                                            "Action" : "deletePerson",
                                            "PersonType" : 2,
                                            "PersonId": ""+arr+""
                                        }
                                }
                            ),

                            contentType: "application/json;charset=UTF-8",
                            //定义回调响应的数据格式为JSON字符串,该属性可以省略
                            //dataType : "json",
                            success: function (data) {
                                var obj = eval("(" + data + ")")
                                if(obj.Code===1){alert("删除成功！")
                                    window.location.reload();
                                }else{alert("添加失败！Code:"+obj.Code)}
                            }
                        })
                    }
                })
            });

        });

    </script>
</head>
<body>

<%--<input type="button" value="测试JSON交互" onclick=" testJson()"/>--%>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-bordered table-condensed table-layout: fixed text-center">
                <thead>
                <tr><button id="list">查询所有学生</button>
                    <button id="delete">删除选中学生</button>
                    <button id="add" onclick="javascript:window.location.href='${pageContext.request.contextPath }/toAddStudeent'">添加学生</button>
                    <button onclick="javascript:window.location.href='${pageContext.request.contextPath }/toComparison'">对比记录</button>
                </tr>
                <tr>
                    <th>选择</th>
                    <th style="width: 132px;">
                        库图片
                    </th>
                    <th>
                        姓名
                    </th>
                    <th>
                        性别
                    </th>
                    <th>
                        学号
                    </th>
                    <th>
                        专业
                    </th>
                    <th>
                        年级
                    </th>
                    <th>
                        学生手机号
                    </th>
                    <th>
                        家长手机号
                    </th>
                    <th>
                        操作
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
