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

            $("#getDate").click(function () {
                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();
                var Name = $("#Name").val();
                var Sno = $("#Sno").val();
            });

        });
    </script>

<body>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-bordered table-condensed  text-center">
                <thead>
                <tr>
                    <td colspan="4">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label>选择开始时间：</label>
                                <!--指定 date标记-->
                                <div class="input-group date" id="datetimeStart">
                                    <input id="startDate" type="text" class="form-control" />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label>选择结束时间：</label>
                                <!--指定 date标记-->
                                <div class="input-group date" id="datetimeEnd">
                                    <input id="endDate" type="text" class="form-control" />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td rowspan="3" colspan="">
                        <table border="1">
                            <tr>
                                <td id="stuFace" rowspan="3"></td>
                                <td><p id="stuName"></p></td>
                            </tr>
                            <tr><td id="stuSno"></td></tr>
                            <tr><td id="stu_cell"></td></tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <div class="form-group col-sm-3">
                        <label>姓名查找：</label>
                        <input id="Name" type="text" class="form-control"/>
                    </div>
                        <div class="form-group col-sm-3">
                            <label>学号查找：</label>
                            <input id="Sno" type="text" class="form-control"/>
                        </div>
                        <div style="float: right;margin-top: 30px">
                            <label style="float: left">人脸查找：</label>
                            <input id="Face" type="file"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"><button id="check">开始查找</button></td>
                </tr>
                <tr>
                    <td style="width:14%" >
                        抓拍场所
                    </td>
                    <td style="width:14%;">
                        抓拍图片
                    </td>
                    <td style="width:14%;">
                        名单
                    </td>
                    <td style="width:20%;">
                        时间
                    </td>
                    <td>
                        详细内容
                    </td>
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
