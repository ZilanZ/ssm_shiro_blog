<%--
  Created by IntelliJ IDEA.
  User: loshower
  Date: 2017-12-08
  Time: 13:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户页面(TODO)</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath }/style/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/style/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/style/bootstrap-table/bootstrap-table.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/style/css/userList.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/style/pnotify/pnotify.custom.min.css">
<link rel="stylesheet"
      href="${pageContext.request.contextPath }/style/datetimepicker/css/bootstrap-datetimepicker.min.css">
<script src="${pageContext.request.contextPath}/style/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/style/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/style/bootstrap-table/bootstrap-table.min.js"></script>
<script src="${pageContext.request.contextPath}/style/pnotify/pnotify.custom.min.js"></script>
<script src="${pageContext.request.contextPath }/style/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="${pageContext.request.contextPath}/style/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/style/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
        charset="UTF-8"></script>
<script>

    $(function () {
        $("#date1").datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        })
    });

    $(document).ready(function () {
        $('#table1').bootstrapTable({
            method: "get",
            columns: [
                {
                    field: 'id',
                    title: 'ID',
                    align: "center"
                },
                {
                    field: 'username',
                    title: '用户名',
                    align: "center"
                },
                {
                    field: 'gender',
                    title: '性别',
                    align: "center",
                    width: "8%"
                },
                {
                    field: 'birth',
                    title: '出生日期',
                    align: "center",
                    formatter: function (value, row, index) {
                        return changeDateFromat(value)
                    }
                },
                {
                    field: 'regTime',
                    title: '注册时间',
                    align: "center"
                    ,
                    formatter: function (value, row, index) {
                        return changeDateTimeFormat(value);
                    }
                },
                {
                    field: 'status',
                    title: '状态',
                    align: "center",
                    width: "5%"
                },
                {
                    field: 'option',
                    title: '操作',
                    width:"15%",
                    align: "center",
                    formatter: operateFormatter,
                    events:operateEvents1
                }
            ],
            pagination: true,
            pageList: [10, 15],
            search: false,
            showHeader: true,
            showRefresh:true,
            pageNumber: 1,
            striped: true,
            url: '${pageContext.request.contextPath }/cms/AllUser',
            onLoadSuccess: function () {  //加载成功时执行
                console.info("加载成功");
            },
            onLoadError: function () {  //加载失败时执行
                console.info("加载数据失败");
            }
        });
    })

    //转换时间日期格式(时间戳转换为datetime格式)
    function changeDateTimeFormat(cellval) {
        var dateVal = cellval + "";
        if (cellval != null) {
            var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
            var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
            var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();

            var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
            var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
            var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();

            return date.getFullYear() + "-" + month + "-" + currentDate + " " + hours + ":" + minutes + ":" + seconds;
        }
    }

    //转换日期格式为年月
    function changeDateFromat(cellval) {
        var dateVal = cellval + "";
        if (cellval != null) {
            var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
            var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
            var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
            return date.getFullYear() + "-" + month + "-" + currentDate;
        }
    }

    function operateFormatter(value, row, index) {
        return [
                '<button type="button" class="btn btn-sm btn-warning btn-ban">禁用</button>'+'&nbsp;'+
            '<button type="button" class="btn btn-sm btn-danger btn-delete">删除</button>'
        ].join('');
    }

    window.operateEvents1={
        "click .btn-delete":function(e,value,row,index){
            $.ajax({
                type:"post",
                url:"${pageContext.request.contextPath}/deleteUser",
                data:{id:row.id},
                success:function(data,status){
                    if(status == "success"){
                        new PNotify({
                            title: '删除成功',
                            text: '您已成功删除名为'+row.username+'的用户!',
                            type: 'success'
                        });
                    }
                    $("#table1").bootstrapTable('refresh');
                },
                error:function(){
                    new PNotify({
                        title: '删除成功',
                        text: '删除失败!',
                        type: 'success'
                    });
                }

            })
           /* alert("test ban");*/
        },
        "click .btn-ban":function(e,value,row,index){
            alert("test ban");
        }
    }


</script>

<body>
<div class="search-wrap">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-2"><p class="search-title">会员查询(TODO)</p></div>
        <div class="col-md-2">
            <input type="text" class="form-control" id="exampleInputName2" placeholder="请输入用户名">
        </div>
        <div class="col-md-2">
            <div class="form-group">
                <div class='input-group date' id='date1'>
                    <input type='text' class="form-control"/>
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
        </div>
        <div class="col-md-2">
            <button type="button" class="btn btn-primary">查找</button>
        </div>
        <div class="col-md-2"></div>
    </div>
</div>
<%--user list--%>
<div class="result-wrap">
    <div class="row">

        <div class="col-md-12">
            <table id="table1"></table>
        </div>

    </div>
</div>
</body>
</html>
