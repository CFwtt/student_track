<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: CF
  Date: 2021/1/31
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书籍展示页面</title>
    <%--bootstrap美化页面--%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
   <div class="container">

       <div class="row clearfix">
           <div class="col-md-12 colum">
               <div class="page-header">
                   <h1>
                       <small>书籍列表 ———— 显示所有书籍</small>
                   </h1>
               </div>
           </div>
           <div class="row">
                <div class="col-md-4 colum">
                    <%--toAddBook--%>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/book/toAddBook">新增书籍</a>
                </div>
           </div>

       </div>

       <div class="row clearfix">
           <div class="col-md-12">
               <table class="table table-hover table-striped">
                   <thead>
                   <tr>
                       <th>书籍编号</th>
                       <th>书籍名称</th>
                       <th>书籍数量</th>
                       <th>书籍详情</th>
                       <th>操作</th>
                       <th>删除</th>
                   </tr>
                   </thead>
                   <tbody>
                   <c:forEach var="book" items="${list}">
                       <tr>
                           <td>${book.bookID}</td>
                           <td>${book.bookName}</td>
                           <td>${book.bookCounts}</td>
                           <td>${book.detail}</td>
                           <td><a href="${pageContext.request.contextPath}/book/toUpdateBook?id=${book.bookID}" >修改</a>
                           &nbsp; | &nbsp;
                           <a href="">删除</a></td>
                       </tr>
                   </c:forEach>
                   </tbody>
               </table>
           </div>
       </div>

   </div>
</body>
</html>
