$(function () {
    /* 加载页面第一时间从数据库拉取数据展示到页面 */
    $(document).ready(function () {
        //do something
        $.ajax({
            url: "${pageContext.request.contextPath }/list/allStudent",
            type: "post",
            contentType: "application/json;charset=UTF-8",
            success: function (data) {
                var startDate = $("startDate").val();
                var endDate = $("endDate").val();
                console.log(startDate + " " + endDate);
                tableContent1 = "";
                if (data.length > 0) {
                    for (var k = 0; k < data.length - 1; k++) {
                        var sno = data[k].sno;
                        tableContent1 += '<tr><td>' + data[k].name + '</td>';
                        tableContent1 += '<td>' + data[k].sex + '</td>';
                        tableContent1 += '<td>' + data[k].sno + '</td>';
                        tableContent1 += '<td>' + data[k].grade + '</td>';
                        tableContent1 += '<td>' + data[k].major + '</td>';
                        tableContent1 += '<td>' + data[k].s_college + '</td>';
                        tableContent1 += '<td>' + '<button " value="' + sno + '" id="two" class="btn">详情</button></tr>';
                    }
                    $("#content").append(tableContent1);
                }
            }
        })

    })

    $(document).on("click", ".btn", function () {
        var sno = $(this).val();
        $(this).addClass('out');
        tableContent = "";
        tableContent = '<input name="sno" class="hidden" value="' + sno + '"/>';
        $(".out").append(tableContent);

        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var startToUnix = Date.parse(startDate);
        var endToUnix = Date.parse(endDate);
        console.log("startToUnix:" + startToUnix)
        console.log("endToUnix:" + endToUnix)
        if (startDate.length == 0 || endDate.length == 0) {
            alert("查询日期不能为空！");
        } else if (startToUnix > endToUnix) {
            alert("起始时间不能小于最终时间!")
        }else {
            document.SearchForm.action = "${pageContext.request.contextPath}/list/toDetails";
            document.SearchForm.submit();
        }
    })


    /*禁止页面横向拖动*/
    $('body').css("overflow-x", "hidden");
    $('body').css("height", "870px")
    /*日历控件设置*/
    $("#datetimeStart").datetimepicker({
        language: 'zh-CN',
        autoclose: true,
    });
    $("#datetimeEnd").datetimepicker({
        language: 'zh-CN',
        autoclose: true,
    });

    // $("#CheckVal").keyup(function () {
    //     $("table>tbody>tr")
    //         .hide()
    //         .filter(":contains('" + ($(this).val()) + "')")
    //         .show();
    // });
});