<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>测试JSON交互</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <%--时间控件--%>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.zh-CN.js"></script>

    <link href="${pageContext.request.contextPath}/statics/css/comparison.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <script>
        $(function () {
            $("#datetimeStart").datetimepicker({
                format: 'yyyy-mm-dd',
                minView:'month',
                language: 'zh-CN',
                autoclose:true,
            });
            $("#datetimeEnd").datetimepicker({
                format: 'yyyy-mm-dd',
                minView:'month',
                language: 'zh-CN',
                autoclose:true,
                startDate:new Date()
            });

            $("#CheckVal").keyup(function () {
                $("table>tbody>tr")
                .hide()
                .filter(":contains('"+($(this).val())+"')")
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
                            if (sex===1){sex="男"}else{sex="女"};
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
<div class="container">
    <div class="row clearfix">
<%--            <table class="table table-bordered table-condensed  text-center">--%>
<%--                <thead>--%>
<%--                <tr>--%>
<%--                    <td colspan="5">--%>
<%--                        <div class="col-sm-4">--%>
<%--                            <div class="form-group">--%>
<%--                                <label>选择开始时间：</label>--%>
<%--                                <!--指定 date标记-->--%>
<%--                                <div class="input-group date" id="datetimeStart">--%>
<%--                                    <input id="startDate" type="text" class="form-control" />--%>
<%--                                    <span class="input-group-addon">--%>
<%--                                        <span class="glyphicon glyphicon-calendar"></span>--%>
<%--                                    </span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="col-sm-4">--%>
<%--                            <div class="form-group">--%>
<%--                                <label>选择结束时间：</label>--%>
<%--                                <!--指定 date标记-->--%>
<%--                                <div class="input-group date" id="datetimeEnd">--%>
<%--                                    <input id="endDate" type="text" class="form-control" />--%>
<%--                                    <span class="input-group-addon">--%>
<%--                                        <span class="glyphicon glyphicon-calendar"></span></span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td colspan="5">--%>
<%--                        <div class="form-group col-sm-6">--%>
<%--                        <label>姓名或学号查找：</label>--%>
<%--                        <input id="CheckVal" type="text" class="form-control"/>--%>
<%--                        </div>--%>
<%--                        <div style="float: right;margin-top: 30px">--%>
<%--                            <label style="float: left">人脸查找：</label>--%>
<%--                            <input id="Face" type="file"/>--%>
<%--                        </div>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td style="width:14%" >--%>
<%--                        抓拍场所--%>
<%--                    </td>--%>
<%--                    <td style="width:14%;">--%>
<%--                        抓拍图片--%>
<%--                    </td>--%>
<%--                    <td style="width:14%;">--%>
<%--                        名单--%>
<%--                    </td>--%>
<%--                    <td style="width:20%;">--%>
<%--                        时间--%>
<%--                    </td>--%>
<%--                    <td>--%>
<%--                        详细内容--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                </thead>--%>
<%--                <tbody id="content">--%>

<%--                </tbody>--%>
<%--            </table>--%>
        </div>
    </div>
</div>
</body>
</html>
