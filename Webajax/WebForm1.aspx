<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Webajax.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <a href="http://www.cnblogs.com/hyd309/p/3460996.html">学习地址</a>
            <a href=" http://www.cnblogs.com/linlf03/archive/2011/12/09/2282574.html">学习地址</a>

            <input type="button" id="t1" value="t1" />
            <input type="button" id="list" value="list" />
            <input type="button" id="GetlistDic" value="GetlistDic" />
            <input type="button" id="GetDic" value="GetDic" />
            <input type="button" id="Person" value="Person" />

            <input type="button" id="listPerson" value="listPerson" />
            <input type="button" id="dataset" value="dataset" />

            <input type="button" id="jsonp" value="jsonp" />


        </div>
    </form>
    <script>
        $(function () {
            $("#t1").click(function () {
                $.ajax({
                    url: "/WebForm1.aspx/SayHello",
                    type: "Post",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: "{name:'Varchar32'}",
                    success: function (data) {
                        alert(data.d);
                    },
                    error: function (data) {
                        //200的响应也有可能被认定为error，responseText中没有Message部分
                        alert($.parseJSON(data.responseText).Message);
                    },
                    complete: function (data) {
                        ;//after success or error
                    }
                });

            })
            $("#list").click(function () {
                $.ajaxWebService("/WebForm1.aspx/GetList", {}, function (data) {
                    alert(data.d)
                })
            })

            $("#GetlistDic").click(function () {
                $.ajaxWebService("/WebForm1.aspx/GetlistDic", {}, function (data) {
                    alert(data.d[0].aa)
                })
            })

            $("#GetDic").click(function () {
                $.ajaxWebService("/WebForm1.aspx/GetDic", {}, function (data) {
                    alert(data.d.aa)
                })
            })

            $("#Person").click(function () {
                $.ajaxWebService("/WebForm1.aspx/GetPerson", {}, function (data) {
                    alert(data.d.Name)
                })
            })

            $("#listPerson").click(function () {
                $.ajaxWebService("/WebForm1.aspx/GetlistPerson", {}, function (data) {
                    alert(data.d[0].Name)
                })
            })


            $("#dataset").click(function () {
                //$.ajaxWebService("/WebForm1.aspx/getDataSet", {}, function (data) {
                //    alert(data.d.aa)
                //})

                //此处采用xml格式调用
                $.ajax({
                    url: "WebForm1.aspx/getDataSet",
                    type: "Post",
                    dataType: "xml",
                    data: {},
                    success: function (data) {
                        console.info(data);
                        alert(data);
                        var str = "";
                        $.each($.find("Table1", data), function () {
                            str += $(this).find("Name").text() + (Boolean($(this).find("Gender").text()) ? "男" : "女") + ";";
                        });

                        str = str.substring(0, str.length - 1);
                        alert(str);
                        $(".ajaxresult div:eq(1)").html("内容为：" + str);
                    }
                });
            })

            $("#jsonp").click(function () {
                $.ajax({
                    url: "aa.ashx",
                    dataType: "jsonp",
                    jsonpCallback: "funccallback",
                    //说明：1、未指定jsonpCallback项则会产生一个随机回调函数名，是由ajax方法随机生成，而不是服务器；2、jsonpCallback项和url的callback参数不可同时指定（callback参数指定为'?'除外）；3、随机函数名就意味着成功返回后只会执行success，指定回调函数反而会显得多余
                    data: { name: "Varchar32" },
                    //执行顺序是success在回调函数之后
                    success: function (data) {
                        console.info(data);
                        alert(data);
                        //data，同回调函数中的data，就是在服务器端为回调函数传递的json格式参数
                        alert("in success" + "：" + data.name + "， 性别" + data.gender);
                    }
                });
            })



        })
        //回调函数funccallback，回调函数的定义不要放在 $(function () {    });里
        function funccallback(data) {
            alert("in callback" + "：" + data.name + "， 性别" + data.gender);
        }




        $.ajaxWebService = function (url, dataMap, fnSuccess) {
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: url,
                data: dataMap,
                dataType: "json",
                success: fnSuccess
            });

        }
    </script>
</body>
</html>
