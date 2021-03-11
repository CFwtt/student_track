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
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/statics/css/comparison.css" rel="stylesheet">



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
<div class="header">
    <div class="top-content">
        <div class="logoInfo">
            <img class="hidden-xs" src="${pageContext.request.contextPath}/statics/img/logo.png">
            <span class="visible-xs">学生轨迹查询</span>
        </div>
    </div>
</div>

<div class="background">
    <div class="container">
        <div class="row">
            <div class="col-sm-1 left">
                <div class="nav" style="padding-left: 5px">
                    <ul>
                        <li><a id="a1" href="${pageContext.request.contextPath}/allStudent" class="glyphicon glyphicon-camera">人员搜索</a></li>
                        <li><a href="#" class="glyphicon glyphicon-user">人员验证</a></li>
                        <li><a href="#" class="glyphicon glyphicon-folder-open">人库管理</a></li>
                        <li><a href="#" class="glyphicon glyphicon-facetime-video">基础设置</a></li>
                        <li><a href="#" class="glyphicon glyphicon-wrench hidden-xs">账号权限</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-sm-11 right">
                <jsp:include page="${mainright==null?'comparisonRecord1.jsp':mainright}"></jsp:include>
            </div>
        </div>
    </div>
</div>

</div>
</body>
</html>
