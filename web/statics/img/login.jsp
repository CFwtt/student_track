<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>登录</title>
    <!-- Meta tag Keywords -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="UTF-8" />
    <meta name="keywords" content="Triple Forms Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>
    <!-- Meta tag Keywords -->

    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/style.css" type="text/css" media="all" />
    <link href="${pageContext.request.contextPath}/statics/css/font-awesome.min.css" rel="stylesheet">

</head>

<body>
<div class="main-bg" id="mian">
    <!-- title -->
    <h1>人脸识别分析系统</h1>
    <!-- //title -->
    <div class="sub-main-w3">
        <div class="image-style" style="width: 110px">
        </div>
        <!-- vertical tabs -->
        <div class="vertical-tab">
            <div id="section1" class="section-w3ls" >
                <input type="radio" name="sections" id="option1" checked>
                <label for="option1" class="icon-left-w3pvt" style="padding-bottom: 95px;"><span class="fa fa-user-circle" aria-hidden="true"></span>登录</label>
                <article>
                    <form action="${pageContext.request.contextPath}/login/doLogin" method="post">
                        <h3 class="legend">账号登录</h3>
                        <div class="input">
                            <input type="text" name="username">
                        </div>
                        <div class="input">
                            <span class="fa fa-key" aria-hidden="true"></span>
                            <input type="password" v-model="logindata.password" placeholder="密码" name="password" required />
                        </div>
                        <button type="submit" class="btn submit">登 录</button>
                        <a style="color: red" class="bottom-text-w3ls">${wrongMsg}</a>
                    </form>
                </article
            </div>

            <div id="section3" class="section-w3ls" >
                <input type="radio" name="sections" id="option3">
                <label for="option3" class="icon-left-w3pvt" style="padding-bottom: 98px;"><span class="fa fa-lock" aria-hidden="true"></span>忘记密码?</label>
                <article>
                    <form action="#" method="post" style="padding-bottom: 71px;">
                        <h3 class="legend last">重置密码</h3>
                        <p class="para-style">请在下面输入您的电子邮件地址，我们将给您发送一封带有说明的电子邮件。</p>

                        <div class="input">
                            <span class="fa fa-envelope-o" aria-hidden="true"></span>
                            <input type="email" v-model="forgetdata.email" placeholder="邮箱" name="email" required />
                        </div>
                        <button type="submit" class="btn submit last-btn">提交</button>

                    </form>
                </article>
            </div>
        </div>
    </div>
</div>
</body>

</html>
