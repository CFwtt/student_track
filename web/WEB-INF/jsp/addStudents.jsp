<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin & Dashboard Template</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <link href="${pageContext.request.contextPath}/assets/css/dropify.min.css" rel="stylesheet" >

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
                window.base64 = "";
                base64 = this.result.replace("data:image/jpeg;base64,","");
            //     img_area.innerHTML = '<div>已选图片展示：</div><img style="height: 340px;width: 290px" src="'+this.result+'" alt=""/>';
             }
        }
    </script>

    <script>
        $(function () {
            $("#submit").click(function () {
                var name = $("#name").val();
                var sex = $("input:radio:checked").val();
                var sno = $("#sno").val();
                var major = $("#major").val();
                var grade = $("#grade").val();
                var stu_cell = $("#stu_cell").val();
                var s_college = $("#s_college").val();


                $.ajax({
                    url: "${pageContext.request.contextPath }/list/testJson1",
                    type: "post",
                    data: JSON.stringify({
                            "Name" : "personListRequest",
                            "Data" :
                                {
                                    "Action" : "addPerson",
                                    "PersonType" : 2,
                                    "PersonInfo" :
                                        {
                                            "PersonCover":0,
                                            "PersonId" : ""+sno+"",
                                            "PersonName":""+name+"",
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
                        console.log(major,grade);
                        if(obj.Code===1){alert("添加成功！")
                            location.href="${pageContext.request.contextPath}/menu/toStuDatabase";
                            getStuInFo(name,sex,sno,major,grade,stu_cell,s_college);
                        }else{alert("添加失败！Code:"+obj.Code)}
                    }
                })

                function getStuInFo(name,sex,sno,major,grade,stu_cell,s_college){
                    var add_time = new Date();
                    var year= add_time.getFullYear();
                    var month= add_time.getMonth()+1;
                    var date= add_time.getDate();
                    var h= add_time.getHours();       //获取当前小时数(0-23)
                    var m= add_time.getMinutes();     //获取当前分钟数(0-59)
                    var s= add_time.getSeconds();
                    var now=year+'-'+month+"-"+date+" "+h+':'+m+":"+s;
                    $.ajax({
                        url:"${pageContext.request.contextPath }/list/AddStudent",
                        data:{
                            "face":base64,
                            "name":name,
                            "sex":sex,
                            "sno":sno,
                            "grade":grade,
                            "major":major,
                            "phone":stu_cell,
                            "s_college":s_college,
                            "add_time": now,
                        },
                        type:"post",
                        dataType:"json",
                    });

                }

            });

        })
    </script>

</head>

<body>

<div class="container-fluid">

    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                <div style="float: right">当前位置：<a href="#">人像库</a>>添加人像</div>

            </div>
        </div>
    </div>
    <!-- end page title -->

    <div class="row">
        <div class="col-xl-6">
            <div class="card">
                <div class="card-body">

                    <div class="table-responsive">
                        <div class="form-group">
                            <label>姓名</label>
                            <input type="text" class="form-control" id="name">
                        </div>
                        <label class="radio-inline">
                            <input type="radio"  value="男性" name="sex">男性
                        </label>
                        <label class="radio-inline">
                            <input type="radio"  value="女性" name="sex">女性
                        </label>
                        <div class="form-group">
                            <label>学号</label>
                            <input type="text" class="form-control" id="sno">
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
                            <label>二级学院</label>
                            <input type="text" class="form-control" id="s_college">
                        </div>
                        <div class="form-group">
                            <label>学生手机号</label>
                            <input type="text" class="form-control" id="stu_cell">
                        </div>
                        <button id="submit" type="submit"  class="btn btn-success">提交</button>
                    </div>

                </div>
                <!-- end card-body-->
            </div>
            <!-- end card -->
        </div>
        <!-- end col -->
        <div class="col-xl-6">
            <div class="card">
                <div class="card-body">

                    <h4 class="card-title">已选图片展示：</h4>
                    <p style="color: red" class="card-subtitle mb-4">提示:图片需小于960*960,2M!</p>

                    <input id="img_upload" type="file" class="dropify"/>

                </div> <!-- end card-body-->
            </div> <!-- end card-->
            <!-- end card -->

        </div>
        <!-- end col -->
    </div>
    <!-- end row -->


</div> <!-- container-fluid -->

<script src="${pageContext.request.contextPath}/assets/js/dropify.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/fileuploads-demo.js"></script>

</body>

</html>