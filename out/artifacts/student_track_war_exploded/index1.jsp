<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>测试JSON交互</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" 
      src="${pageContext.request.contextPath }/statics/js0/jquery-3.5.1.js">
</script>
    <script>
        $(function(){
            <%--$.post("${pageContext.request.contextPath}/addPxx",{"Name":"getNetParametersRequest"},--%>
            <%--function(data) {--%>
            <%--    console.log(data)--%>
            <%--},"json");--%>

<%--            $.ajax({--%>
<%--                url: "${pageContext.request.contextPath}/remote",--%>
<%--                type: "POST",--%>
<%--                contentType: "application/json",--%>
<%--                dataType: "json",--%>
<%--                data: JSON.stringify({--%>
<%--                    Name:"getNetParametersRequest"--%>
<%--                    }),--%>
<%--                async: true,--%>
<%--                success: function(data) {--%>
<%--                    // var ss = JSON.stringify(data);--%>
<%--                    // $("#result").val(ss);--%>
<%--                    console.log(data);--%>
<%--                }--%>
<%--            });--%>

            $.post("/testJson");

        })
        </script>

</head>
<body>
<h3>110</h3>
</body>
</html>
