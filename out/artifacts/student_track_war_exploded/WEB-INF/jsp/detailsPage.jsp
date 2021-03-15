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
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">


    <script>

        $(function () {

            /*
            加载页面第一时间从数据库拉取数据展示到页面
             */
            $(document).ready(function () {

                var startDate = "${startDate}";
                var endDate = "${endDate}";
                var sno = "${sno}";
                var startToUnix = Date.parse(startDate);
                var endToUnix = Date.parse(endDate);
                var username = $(".user_name").val();
                console.log("startDate:" + startDate + " endDate:" + endDate + " sno:" + sno)
                var year = parseInt(startDate.substr(0, 4));
                var month = parseInt(startDate.substr(5, 2));
                var day = parseInt(startDate.substr(8, 2));
                var startHour = parseInt(startDate.substr(10, 3));
                var startMin = parseInt(startDate.substr(14, 2));
                var endHour = parseInt(endDate.substr(10, 3));
                var endMin = parseInt(endDate.substr(14, 2));
                startToUnixToEndUnix(username, year, month, day, startHour, startMin, endHour, endMin, startDate, endDate, startToUnix, endToUnix);

                //遍历摄像头，获取每个摄像头拍到人脸的总页码
                function queryTotalPage(username, year, month, day, startHour, startMin, endHour, endMin) {
                    console.log("end:" + endHour, endMin)
                    for (var channelNo = 0; channelNo <= 8; channelNo++) {
                        $.ajax({
                            url: "${pageContext.request.contextPath }/Jsonp/jsonp",
                            type: "post",
                            data: JSON.stringify({
                                "Name": "getFaceCompareRecord",
                                "Data":
                                    {
                                        "ChannelNo": channelNo,
                                        "Year": year,
                                        "Month": month,
                                        "Day": day,
                                        "StartHour": startHour,
                                        "StartMin": startMin,
                                        "StartSecond": 0,

                                        "EndHour": endHour,
                                        "EndMin": endMin,
                                        "EndSecond": 59,
                                        "GetPhoto": 1,
                                        "PageNo": 1,
                                        "PageSize": 5,
                                        "Similary": 80,
                                        "CompareNameList":
                                            {
                                                "ListNameID": 128
                                            }
                                    }
                            }),
                            contentType: "application/json;charset=UTF-8",
                            success: function (data) {

                                var obj = eval("(" + data + ")");
                                var totalCount = obj.Data.TotalFaceCompareRecordNum;
                                var temp = totalCount % 5;
                                var totalPage = temp == 0 ? totalCount / 5 : totalCount / 5 + 1;
                                var ChannelNo = obj.ChannelNo;
                                var Message = obj.Message;
                                console.log("Message:" + Message)
                                if (GetAsciiCode(Message) == "Get Snap Record Success!") {
                                    queryRecord(username, year, month, day, startHour, startMin, endHour, endMin, ChannelNo, totalPage);
                                }
                            }
                        })
                    }

                }

                //把总页码传给此函数遍历页码获得每页的回传值
                function queryRecord(username, year, month, day, startHour, startMin, endHour, endMin, ChannelNo, TotalPage) {
                    var pageNo = 1;
                    while (pageNo <= TotalPage) {
                        console.log("ChanneNo" + ChannelNo, "pageNo:" + pageNo)
                        $.ajax({
                            url: "${pageContext.request.contextPath }/Jsonp/jsonp",
                            type: "post",
                            data: JSON.stringify({
                                "Name": "getFaceCompareRecord",
                                "Data":
                                    {
                                        "ChannelNo": ChannelNo,
                                        "Year": year,
                                        "Month": month,
                                        "Day": day,
                                        "StartHour": startHour,
                                        "StartMin": startMin,
                                        "StartSecond": 0,

                                        "EndHour": endHour,
                                        "EndMin": endMin,
                                        "EndSecond": 59,
                                        "GetPhoto": 1,
                                        "PageNo": pageNo,
                                        "PageSize": 5,
                                        "Similary": 80,
                                        "CompareNameList":
                                            {
                                                "ListNameID": 128
                                            }
                                    }
                            }),
                            contentType: "application/json;charset=UTF-8",
                            success: function (data) {
                                var obj = eval("(" + data + ")");
                                console.log("sno:" + sno)
                                $.each(obj.Data.FaceCompareRecordData, function (key, value) {
                                    tableContent1 = "";
                                    var PersonName = value.PersonName;
                                    var PersonId = value.PersonId;
                                    var Similary = value.Similary;
                                    var CompareTime = value.CompareTime;
                                    var FacePictureBase64 = value.FacePicture;
                                    var nowDate = new Date();
                                    if (GetAsciiCode(value.PersonId) == sno) {
                                        tableContent1 += '<tr><td>' + '<img style="height: 145px;width: 135px" src="data:image/jpeg;base64,' + FacePictureBase64 + '">' + '</td>';
                                        tableContent1 += '<td>' + PersonName + '</td>';
                                        tableContent1 += '<td>' + sno + '</td>';
                                        tableContent1 += '<td>' + value.ListName + '</td>';
                                        tableContent1 += '<td>' + value.CompareTime + '</td>';
                                        tableContent1 += '<td>' + ChannelNo + '</td>';
                                        //tableContent1 += '<td><button class="btn btn-info details"  type="button">详情</button></td></tr>';
                                        $("#content").append(tableContent1);
                                        getQueryRecord(username, PersonName, PersonId, Similary, CompareTime, FacePictureBase64, nowDate);
                                    } else {
                                        alert("无数据，请重新输入");
                                    }
                                })
                            }
                        })
                        pageNo++;
                    }
                }

                //判断上传的时间段
                function startToUnixToEndUnix(username, year, month, day, startHour, startMin, endHour, endMin, startDate1, endDate1, startUnix1, endUnix1) {
                    if (timestampToTime(startUnix1).substr(0, 10) === timestampToTime(endUnix1).substr(0, 10)) {
                        queryTotalPage(username, year, month, day, startHour, startMin, endHour, endMin);
                        console.log("一天内");
                    } else {
                        if (timestampToTime(startUnix1).substr(0, 10) === startDate1.substr(0, 10)) {
                            queryTotalPage(username, year, month, day, startHour, startMin, 23, 59);
                            console.log("第一天");

                        }
                        startUnix1 += 60 * 60 * 24 * 1000;
                        for (; ; startUnix1 += 60 * 60 * 24 * 1000) {
                            //当天的情况下
                            var Date = timestampToTime(startUnix1);
                            var years = parseInt(Date.substr(0, 4));
                            var months = parseInt(Date.substr(5, 2));
                            var days = parseInt(Date.substr(8, 2));

                            if (timestampToTime(startUnix1).substr(0, 10) === timestampToTime(endUnix1).substr(0, 10)) {
                                queryTotalPage(username, years, months, days, 0, 0, endHour, endMin);
                                console.log("最后一天");
                                return;
                            }
                            queryTotalPage(username, years, months, days, 0, 0, 23, 59);
                            console.log("第一天和最后一天之间");
                        }

                    }
                }

                //时间戳转换为日期格式
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

                //解决ajax返回值无法判断问题。是因为“页面的编码是UTF-8 + BOM”，去掉前面的‘65279’，解决问题
                function GetAsciiCode(string) {//
                    var str = string;//接收字符串
                    var strAscii = new Array();//用于接收ASCII码
                    for (var i = 0; i < str.length; i++) {
                        strAscii[i] = str.charCodeAt(i);//把字符串中的字符一个一个的解码
                    }
                    var getChar = "";
                    if (strAscii[0] == 65279) {
                        for (var j = 1; j < str.length; j++) {
                            getChar += String.fromCharCode(strAscii[j]);//去掉头一个65279，把ASCII码转换为字符串
                        }
                        return getChar;
                    } else {
                        return str;
                    }
                }
            })


            function getQueryRecord(username, PersonName, PersonId, Similary, CompareTime, FacePictureBase64, getTime) {
                var year = getTime.getFullYear();
                var month = getTime.getMonth() + 1;
                var date = getTime.getDate();
                var h = getTime.getHours();       //获取当前小时数(0-23)
                var m = getTime.getMinutes();     //获取当前分钟数(0-59)
                var s = getTime.getSeconds();
                var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;
                console.log(username)
                $.ajax({
                    url: "${pageContext.request.contextPath }/record/getQueryRecord",
                    data: {
                        "username": username,
                        "PersonId": PersonId,
                        "Similary": Similary,
                        "CompareTime": CompareTime,
                        "FacePictureBase64": FacePictureBase64,
                        "QueryTime": now,
                    },
                    type: "post",
                    dataType: "json",
                });

            }

            /*禁止页面横向拖动*/
            $('body').css("overflow-x", "hidden");
            $('body').css("height", "870px")

            /*
            日历控件设置
            */
            console.log(startDate, endDate)
            $("#datetimeStart").datetimepicker({
                language: 'zh-CN',
                autoclose: true,
            });
            $('#datetimeStart').datetimepicker('update', '' + "${startDate}" + '');
            $("#datetimeEnd").datetimepicker({
                language: 'zh-CN',
                autoclose: true,
            });
            $('#datetimeEnd').datetimepicker('update', '' + "${endDate}" + '');


        });
    </script>

    <style>
        th, td {
            text-align: center;
            vertical-align: middle !important;
            padding: 6px !important;
        }

        .details {
            height: 29px;
            width: 45px;
            padding-right: 0px;
            padding-left: 0px;
            padding-bottom: 9px;
        }
    </style>

<body>

<div class="container">
    <table class="table table-condensed table-layout: fixed text-center right-bottom-table">
        <tbody class="tbody">
        <thead id="content">
        <div class="row">
            <div class="col-sm-3 col-xs-2 right-bottom-start">
                <div class="input-group date" id="datetimeStart">
                    <input data-date="1979-09-16T05:25:07Z"
                           data-date-format="dd MM yyyy - HH:ii p"
                           name="startDate" id="startDate" value="" type="text"
                           class="form-control"
                           placeholder="起始时间"/>
                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                </div>
            </div>
            <div class="col-sm-3 col-xs-5 right-bottom-end">
                <div class="input-group date" id="datetimeEnd">
                    <input data-date="1979-09-16T05:25:07Z"
                           data-date-format="dd MM yyyy - HH:ii p"
                           name="endDate" id="endDate" type="text" value="" class="form-control"
                           placeholder="最终时间"/>
                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span></span>
                </div>
            </div>
            <div class="col-sm-3 col-xs-11 inputSno">

                <div class="input-group">
                    <input type="text" value="${sno}" class="form-control" placeholder="请输入姓名或学号查找"
                           aria-label="Recipient's username">
                    <div class="input-group-append">
                        <button class="btn btn-dark waves-effect waves-light" type="button">Button</button>
                    </div>
                </div>
            </div>
        </div>
        <tr style="border-bottom: 1px solid rgb(240,242,245)">
            <th style="width: 14%">抓拍图片</th>
            <th style="width: 8%">姓名</th>
            <th style="width: 15%">学号</th>
            <th style="width: 10%">名单</th>
            <th style="width: 16%">时间</th>
            <th style="width: 16%">抓拍场所</th>
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
