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

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.js"></script>

    <%--时间选择控件--%>
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-datetimepicker.zh-CN.js"></script>

    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/statics/css/comparison.css" rel="stylesheet">

    <script>
        $(function () {
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
                startDate: new Date()
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
<div class="header">
    <div class="logo">学生轨迹分析</div>
    <div class="loin">登录</div>
</div>
<div class="background">
    <div class="container">
        <div class="row">
            <div class="col-md-1 left">
                <div class="nav">
                    <ul>
                        <li><a href="#" class="glyphicon glyphicon-camera">抓拍查询</a></li>
                        <li><a href="#" class="glyphicon glyphicon-road">轨迹分析</a></li>
                        <li><a href="#" class="glyphicon glyphicon-folder-open">人像库</a></li>
                        <li><a href="#" class="glyphicon glyphicon-facetime-video">摄像头</a></li>
                        <li><a href="#" class="glyphicon glyphicon-wrench">用户管理</a></li>
                        <li><a href="#" class="glyphicon glyphicon-lock">权限管理</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md-11 right">
                <div class="right-top">
                    <table class="col-md-12">
                        <tr><td colspan="3" class="newDateFont">最新数据<p style="font-size: 10px">(数据收集截止时间每天23:00)</p></td></tr>
                        <tr class="top-content">
                                   <td>今日抓拍人数<p><a href="#">123</a></p></td>
                            <td>今日人员访问最多场所<p><a href="#" >123</a></p></td>
                                  <td>今日无出行人员<p><a href="#">123</a></p></td>
                        </tr>
                    </table>
                </div>
                <div class="right-bottom"></div>
            </div>
        </div>
    </div>
</div>

</div>
</body>
</html>
