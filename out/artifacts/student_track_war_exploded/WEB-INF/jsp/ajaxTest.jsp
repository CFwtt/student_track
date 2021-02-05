<%--
  Created by IntelliJ IDEA.
  User: CF
  Date: 2021/2/2
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="${pageContext.request.contextPath}/statics/js/jquery-3.5.1.js"></script>
    <script>
        $.post({
            url:"192.168.0.31:8011",
            data:{
                "Name":"personListRequest",
                    "UUID":"340481e9e3c1bf54",
                    "Data":{
                    "Action":"getPerson",
                        "PersonType": 2,
                        "PersonId":"001",
                        "GetPhoto":1
                }
            },
            success:function (data) {
                console.log(data);
            }
        })
    </script>
</head>
<body>

</body>
</html>
