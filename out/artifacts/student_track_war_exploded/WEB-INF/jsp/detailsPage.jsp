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

    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <link href="${pageContext.request.contextPath}/statics/css/detailsPage.css" rel="stylesheet">

    <script>

        $(function () {

            /*
            加载页面第一时间从数据库拉取数据展示到页面
             */

            $(document).ready(function () {
                var startDate = $(".startDate").val();
                var endDate = $(".endDate").val();
                var checkVal = $(".CheckVal").val();
                var startToUnix = Date.parse(startDate);
                var unixToStart = timestampToTime(startToUnix);
                var endToUnix = Date.parse(endDate);
                var unixToEnd = timestampToTime(endToUnix);
                var unloadDate = startToUnixToEndUnix(startDate, endDate, startToUnix, endToUnix);


                function queryRecord(year, month, day, startHour, startMin, endHour, endMin, ChannelNo, ListNameID) {
                    $.ajax({
                        url: "${pageContext.request.contextPath }/main/testJson1",
                        type: "post",
                        data: JSON.stringify({
                            "Name": "getFaceCompareRecord",
                            "Data":
                                {
                                    "ChannelNo":ChannelNo,
                                    "Year":year,
                                    "Month":month,
                                    "Day":day,
                                    "StartHour":startHour,
                                    "StartMin":startMin,
                                    "StartSecond":0,

                                    "EndHour":endHour,
                                    "EndMin":endMin,
                                    "EndSecond":59,
                                    "GetPhoto":1,
                                    "PageNo":4,
                                    "PageSize":5,
                                    "Similary":80,
                                    "CompareNameList":
                                        {
                                            "ListNameID": 128
                                        }
                                }
                        }),
                        contentType: "application/json;charset=UTF-8",
                        success: function (data) {
                            var obj = eval("(" + data + ")");
                            console.log(obj.Data.TotalFaceCompareRecordNum);
                            var totalPage = obj.Data.TotalFaceCompareRecordNum%5;
                            // console.log("to:"+totalPage)
                            function C(totalPage) {
                                var t = totalPage;
                                return t;
                            }
                            return { //返回值对象实质上是一个 我们模块的公有API
                                C:C
                            }
                            //console.log(obj);
                            /* var startDate = $("startDate").val();
                             var endDate = $("endDate").val();
                             tableContent1 = "";
                             if (data.length > 0) {
                                 for (var k = 0; k < data.length - 1; k++) {
                                     tableContent1 += '<tr><td>' + data[k].name + '</td>';
                                     tableContent1 += '<td>' + data[k].sex + '</td>';
                                     tableContent1 += '<td>' + data[k].sno + '</td>';
                                     tableContent1 += '<td>' + data[k].grade + '</td>';
                                     tableContent1 += '<td>' + data[k].major + '</td>';
                                     tableContent1 += '<td>' + data[k].s_college + '</td>';
                                     tableContent1 += '<td><button  type="button">详情</button></td></tr>';

                                 }
                                 $("#content").append(tableContent1);
                             }*/
                        }
                    })


                }


                function startToUnixToEndUnix(startDate, endDate, startUnix, endUnix) {
                    if (startDate.substr(0, 10) === endDate.substr(0, 10)) {
                        var year = parseInt(startDate.substr(0, 4));
                        var month = parseInt(startDate.substr(5, 2));
                        var day = parseInt(startDate.substr(8, 2));
                        var startHour = parseInt(startDate.substr(10, 3));
                        var startMin = parseInt(startDate.substr(14, 2));
                        var endHour = parseInt(endDate.substr(10, 3));
                        var endMin = parseInt(endDate.substr(14, 2));
                        var ChannelNo = 0;
                        var PageNo = 1;
                        var totalPage = 2;


                        while (ChannelNo < 8) {
                            while (PageNo<totalPage){
                                console.log("totalPage:"+totalPage);
                                $.ajax({
                                    url: "${pageContext.request.contextPath }/main/testJson1",
                                    type: "post",
                                    data: JSON.stringify({
                                        "Name": "getFaceCompareRecord",
                                        "Data":
                                            {
                                                "ChannelNo":ChannelNo,
                                                "Year":year,
                                                "Month":month,
                                                "Day":day,
                                                "StartHour":startHour,
                                                "StartMin":startMin,
                                                "StartSecond":0,

                                                "EndHour":endHour,
                                                "EndMin":endMin,
                                                "EndSecond":59,
                                                "GetPhoto":1,
                                                "PageNo":4,
                                                "PageSize":5,
                                                "Similary":80,
                                                "CompareNameList":
                                                    {
                                                        "ListNameID": 128
                                                    }
                                            }
                                    }),
                                    contentType: "application/json;charset=UTF-8",
                                    success: function (data) {
                                        var obj = eval("(" + data + ")");
                                        console.log(obj.Data.TotalFaceCompareRecordNum);
                                        totalPage = obj.Data.TotalFaceCompareRecordNum;
                                        //console.log(obj);
                                        /* var startDate = $("startDate").val();
                                         var endDate = $("endDate").val();
                                         tableContent1 = "";
                                         if (data.length > 0) {
                                             for (var k = 0; k < data.length - 1; k++) {
                                                 tableContent1 += '<tr><td>' + data[k].name + '</td>';
                                                 tableContent1 += '<td>' + data[k].sex + '</td>';
                                                 tableContent1 += '<td>' + data[k].sno + '</td>';
                                                 tableContent1 += '<td>' + data[k].grade + '</td>';
                                                 tableContent1 += '<td>' + data[k].major + '</td>';
                                                 tableContent1 += '<td>' + data[k].s_college + '</td>';
                                                 tableContent1 += '<td><button  type="button">详情</button></td></tr>';

                                             }
                                             $("#content").append(tableContent1);
                                         }*/
                                    }
                                })
                                PageNo++;
                            }
                            ChannelNo++;
                        }
                        //console.log(year,month,day,shour,smin,ehour,emin);
                        //一天内的接口
                    } else if (startDate.substr(0, 10) !== endDate.substr(0, 10)) {
                        //调用一天内的接口、中间时间段接口、最后一天内的接口
                        for (; startUnix <= endUnix; startUnix += 60 * 60 * 24 * 1000) {
                            //console.log("unloadDate:" + timestampToTime(startUnix));
                            var start_year = startDate.substr(0, 4);
                            var start_month = startDate.substr(5, 2);
                            var start_day = startDate.substr(8, 2);

                        }
                    }

                }

                function timestampToTime(timestamp) {
                    var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
                    Y = date.getFullYear() + '-';
                    M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
                    D = (date.getDate() < 10 ? '0' + (date.getDate()) : date.getDate()) + ' ';
                    h = (date.getHours() < 10 ? '0' + (date.getHours()) : date.getHours()) + ':';
                    m = (date.getMinutes() < 10 ? '0' + (date.getMinutes()) : date.getMinutes()) + ':';
                    s = (date.getSeconds() < 10 ? '0' + (date.getSeconds()) : date.getSeconds());
                    return Y + M + D + h + m + s;
                }


                function queryRecord(year, month, day, startHour, startMin, endHour, endMin, ChannelNo, ListNameID) {
                    $.ajax({
                        url: "${pageContext.request.contextPath }/main/testJson1",
                        type: "post",
                        data: JSON.stringify({
                            "Name": "getFaceCompareRecord",
                            "Data":
                                {
                                    "ChannelNo":ChannelNo,
                                    "Year":year,
                                    "Month":month,
                                    "Day":day,
                                    "StartHour":startHour,
                                    "StartMin":startMin,
                                    "StartSecond":0,

                                    "EndHour":endHour,
                                    "EndMin":endMin,
                                    "EndSecond":59,
                                    "GetPhoto":1,
                                    "PageNo":4,
                                    "PageSize":5,
                                    "Similary":80,
                                    "CompareNameList":
                                        {
                                            "ListNameID": 128
                                        }
                                }
                        }),
                        contentType: "application/json;charset=UTF-8",
                        success: function (data) {
                            var obj = eval("(" + data + ")");
                            console.log(obj.Data.TotalFaceCompareRecordNum);
                            var totalPage = obj.Data.TotalFaceCompareRecordNum%5;
                           // console.log("to:"+totalPage)
                            function C(totalPage) {
                                var t = totalPage;
                                return t;
                            }
                            return { //返回值对象实质上是一个 我们模块的公有API
                                C:C
                        }
                            //console.log(obj);
                            /* var startDate = $("startDate").val();
                             var endDate = $("endDate").val();
                             tableContent1 = "";
                             if (data.length > 0) {
                                 for (var k = 0; k < data.length - 1; k++) {
                                     tableContent1 += '<tr><td>' + data[k].name + '</td>';
                                     tableContent1 += '<td>' + data[k].sex + '</td>';
                                     tableContent1 += '<td>' + data[k].sno + '</td>';
                                     tableContent1 += '<td>' + data[k].grade + '</td>';
                                     tableContent1 += '<td>' + data[k].major + '</td>';
                                     tableContent1 += '<td>' + data[k].s_college + '</td>';
                                     tableContent1 += '<td><button  type="button">详情</button></td></tr>';

                                 }
                                 $("#content").append(tableContent1);
                             }*/
                        }
                    })


                }

            });




            $.ajax({
                url: "${pageContext.request.contextPath }/main/allStudent",
                type: "post",
                contentType: "application/json;charset=UTF-8",
                success: function (data) {
                    var startDate = $("startDate").val();
                    var endDate = $("endDate").val();
                    tableContent1 = "";
                    if (data.length > 0) {
                        for (var k = 0; k < data.length - 1; k++) {
                            tableContent1 += '<tr><td>' + data[k].name + '</td>';
                            tableContent1 += '<td>' + data[k].sex + '</td>';
                            tableContent1 += '<td>' + data[k].sno + '</td>';
                            tableContent1 += '<td>' + data[k].grade + '</td>';
                            tableContent1 += '<td>' + data[k].major + '</td>';
                            tableContent1 += '<td>' + data[k].s_college + '</td>';
                            tableContent1 += '<td><button  type="button">详情</button></td></tr>';

                        }
                        $("#content").append(tableContent1);
                    }
                }
            })
            /*禁止页面横向拖动*/
            $('body').css("overflow-x", "hidden");
            $('body').css("height", "870px")

            /*
            日历控件设置
            */
            var startDate = $(".startDate").val();
            var endDate = $(".endDate").val();
            $("#datetimeStart").datetimepicker({
                language: 'zh-CN',
                autoclose: true,
            });
            $('#datetimeStart').datetimepicker('update', '' + startDate + '');
            $("#datetimeEnd").datetimepicker({
                language: 'zh-CN',
                autoclose: true,
            });
            $('#datetimeEnd').datetimepicker('update', '' + endDate + '');

            /*
            为ajax动态生成的Dom元素，添加点击事件
             */
            $(document).on("click", ".btn", function () {
                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();
                var CheckVal = $("#CheckVal").val();
                console.log(startDate, endDate, CheckVal)

                $.ajax({
                    url: "${pageContext.request.contextPath }/toUpdate/'" + sno + "'",
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

            })

            $("#btn").click(function () {
                console.log("666");

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

<div class="container">
    <table class="table table-condensed table-layout: fixed text-center right-bottom-table">
        <tbody class="tbody">
        <thead id="content">
        <tr>
            <td colspan="6">
                <div class="col-sm-4 col-xs-6 right-bottom-start">
                    <div class="input-group date" id="datetimeStart">
                        <input class="hidden startDate" value="${startDate}"/>
                        <input data-date="1979-09-16T05:25:07Z" data-date-format="dd MM yyyy - HH:ii p" id="startDate"
                               type="text" class="form-control" value="" placeholder="起始时间"/>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
                <div class="col-sm-4 col-xs-6 right-bottom-end">
                    <div class="input-group date" id="datetimeEnd">
                        <input data-date="1979-09-16T05:25:07Z" data-date-format="dd MM yyyy - HH:ii p"
                               class="hidden endDate" value="${endDate}"/>
                        <input id="endDate" type="text" class="form-control" value="" placeholder="最终时间"/>
                        <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
                <div class="col-sm-4 col-xs-12 inputSno">
                    <div class="input-group date">
                        <input class="hidden CheckVal" value="${CheckVal}"/>
                        <input id="CheckVal" style="width: 297px" type="text" class="form-control"
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
