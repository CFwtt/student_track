<%--
  Created by IntelliJ IDEA.
  User: CF
  Date: 2021/2/10
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!Doctype html>
<html>
<head>
    <title>添加学生</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css" rel="stylesheet">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>


    <script type="text/javascript">

        window.onload = function(){
// 抓取上传图片，转换代码结果，显示图片的dom
            var img_upload=document.getElementById("img_upload");

// 添加功能出发监听事件
            img_upload.addEventListener('change',readFile,false);}
        function readFile(){
            var file=this.files[0];
            if(!/image\/\w+/.test(file.type)){
                alert("请确保文件为图像类型");
                return false;
            }
            var reader=new FileReader();
            reader.readAsDataURL(file);
            reader.onload=function(){
                //定义全局变量，方便给jquery调用
                var base64 = "";
                base64 = this.result.replace("data:image/jpeg;base64,","");
                img_area.innerHTML = '<div>已选图片展示：</div><img style="height: 340px;width: 290px" src="'+img+'" alt=""/>';
            }
        }

        $(function () {

            $("#subimt").click(function () {
                var base64 = $("#base64str").val();
                var name = $("#name").val();
                var sexchoice = $("input:radio:checked").val();
                if(sexchoice==="男性"){var sex=1}else{sex=2}
                var sno = $("#sno").val();
                var major = $("#major").val();
                var grade = $("#grade").val();
                var stucell = $("#stucell").val();
                var parentcell = $("#parentcell").val();

                $.ajax({
                    url: "${pageContext.request.contextPath }/testJson1",
                    type: "post",
                    data: JSON.stringify({
                            "Name" : "personListRequest",
                            "Data" :
                                {
                                    "Action" : "editPerson",
                                    "PersonType" : 2,
                                    "PersonInfo" :
                                        {
                                            "PersonId" : ""+sno+"",
                                            "PersonName":""+name+"",
                                            "Sex": sex,
                                            "Phone":stucell,
                                            "PersonExtension":
                                                {
                                                    "PersonData1":""+major+"",
                                                    "PersonData3":""+grade+"",
                                                    "PersonData4":""+parentcell+""
                                                },
                                            "PersonPhoto" :""+base64+""
                                        }
                                }
                        }
                    ),
                    contentType: "application/json;charset=UTF-8",
                    //定义回调响应的数据格式为JSON字符串,该属性可以省略
                    //dataType : "json",
                    success: function (data) {
                        var obj = eval("(" + data + ")")
                        if(obj.Code===1){alert("修改成功！")
                            location.href="../../index.jsp";
                        }else{alert("修改失败！Code:"+obj.Code)}
                    }
                })

            });

            var sno = $("#id").val();
            needID(sno)
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
                        $('#name').val(''+obj.Data.PersonInfo.PersonName+'');
                        var sex = obj.Data.PersonInfo.Sex;
                        if (sex==1){$('input:radio:first').attr('checked', 'checked');}
                        else{$('input:radio:last').attr('checked', 'checked');};
                        $('#sno').val(''+sno+'');
                        $('#major').val(''+obj.Data.PersonInfo.PersonExtension.PersonData1+'');
                        $('#grade').val(''+obj.Data.PersonInfo.PersonExtension.PersonData3+'');
                        $('#stucell').val(''+obj.Data.PersonInfo.Phone+'');
                        $('#parentcell').val(''+obj.Data.PersonInfo.PersonExtension.PersonData4+'');
                        var img = "data:image/jpg;base64," + obj.Data.PersonInfo.PersonPhoto;
                        document.getElementById('base64str').value = obj.Data.PersonInfo.PersonPhoto;
                        img_area.innerHTML = '<div>已选图片展示：</div><img style="height: 340px;width: 290px" src="'+img+'" alt=""/>';

                    }
                })
            }

        })
    </script>

</head>
<body>
<div class="container">
    <div class="row clearfix">
        <div style="top: 100px" class="col-md-12 column">
            <div class="col-md-2 column"></div>
            <div  class="col-md-4 column">
                <div class="form-group">
                    <label>姓名</label>
                    <input id="id" type="hidden" value="${sno}">
                    <input type="text" class="form-control" value="" id="name">
                </div>
                <label class="radio-inline">
                    <input type="radio"  value="男性" name="sex">男性
                </label>
                <label class="radio-inline">
                    <input type="radio"  value="女性" name="sex">女性
                </label>
                <div class="form-group">
                    <label>学号</label>
                    <input type="text" class="form-control" id="sno" disabled="disabled">
                </div>
                <div class="form-group">
                    <label>专业</label>
                    <input type="text" class="form-control" id="major">
                </div>
                <div class="form-group">
                    <label>年级</label>
                    <input type="text" class="form-control" id="grade">
                </div>
                <div class="form-group">
                    <label>学生手机号</label>
                    <input type="text" class="form-control" id="stucell">
                </div>
                <div class="form-group">
                    <label>家长手机号</label>
                    <input type="text" class="form-control" id="parentcell">
                </div>
                <div class="form-group">
                    <label>请选择需要上传的人脸图</label>
                    <input type="file" id="img_upload">
                    <p style="color: red" class="help-block">提示:图片需小于960*960,2M!</p>
                </div>
                <button  id="subimt"  class="btn btn-default">提交</button>

            </div>
            <div class="col-md-4 column">
                <p  id="img_area"></p>
                <input id="base64str" type="hidden" >
            </div>
        </div>

    </div>

</div>

<%--<input type="file" id="img_upload"/>--%>

</body>
</html>