<%@ page import="com.tnt.weeklyreview.model.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.util.CollectionUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<h1>工作日报</h1>

<%
List<Task> tasks = (List<Task>) request.getAttribute("tasks");

System.out.println(tasks);
%>


<head>
<script src="js/jquery.min.js"></script>
<script src="js/jRate.js"></script>

<script type="text/javascript">
    var options = {
        rating: 0,
        strokeColor: 'black',
        precision: 0.5,
        minSelected: 0,
        onChange: function(rating) {
        },
        onSet: function(rating) {
            console.log("OnSet: Rating: "+rating + ", self:" + this.rating);
        }
    };

    $(function () {
        var that = this;

        var toolitup2 = $("#jRate2").jRate(options);
        var toolitup3 = $("#jRate3").jRate(options);

        $('#btn-click2').on('click', function() {
            toolitup2.setRating(0);
        });
        $('#btn-click3').on('click', function () {
            toolitup3.setRating(0);
        });

        // 今日重点工作btn click
        var vipNum = 1;
        var lastTrId = "vip-tr1";
        $('#vip-taskBtn').on('click', function () {
            console.log("vip task is clicked.");
            vipNum++;
            var textId = "vip-text" + vipNum;
            var jRateId = "vip-jRate" + vipNum;
            var buttonId = "vip-btn-click" + vipNum;
            var trid = "vip-tr" + vipNum;
            var starId = "vip-star" + vipNum;
            var content = "<tr id='" + trid + "'> <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' size='60' id='" + textId +"'/> </td> <td><div id='" + jRateId + "' style='height:30px;width: 100px;float:left'></div><button id='" + buttonId + "' style='margin-left: 20px'>重置</button><input type='hidden' id='" + starId + "' value='0'/></td></tr>";
            $("#"+lastTrId).after(content);
            lastTrId = trid;

            options.onSet = function(rating) {
                $("#" + starId).val(rating);
            };
            var toolitup = $("#" + jRateId).jRate(options);
            $("#" + buttonId).on('click', function () {
                toolitup.setRating(0);
            });
        });

        // 保存按钮
        $('#finish').on('click', function () {
            console.log("on submit button clicked");
            // 收集参数列表
            var params = "uid=1&vipCount="  + vipNum + "&";
            var params2 = {"uid": 1, "vipCount": vipNum};
            for (var i = 1; i <= vipNum; i++) {
                var textId = "vip-text" + i;
                var textValue = $("#" + textId).val();

                var starId = "vip-star" + i;
                var starValue = $("#" + starId).val();

                params2[textId] = textValue;
                params2[starId] = starValue;

                params += textId + "=" + textValue + "&" + starId + "=" + starValue;
                if (i < vipNum) {
                    params += "&";
                }
            }
            console.log(params);
            var tUrl = "/weeklyreview/saveOrUpdateTask4Day.htmls?"+params;
            tUrl = "/weeklyreview/saveOrUpdateTask4Day.htmls";
            $.ajax({
                url: tUrl,
                data: params2,
                type: "post",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                timeout: 10000,
                success: function(data) {
                    console.log(data);
                }
            });
        });
    });
</script>

</head>

<table border="1">
    <caption><h3>12.23日报</h3></caption>
    <tr>
        <td colspan="2">
            <div>
                <span style="vertical-align: middle">1, 今日重点工作</span>
                <img id="vip-taskBtn" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 30px;padding:0px;margin:0px;cursor:pointer"/>
            </div>
        </td>
    </tr>
    <% if (CollectionUtils.isEmpty(tasks)) {%>
        <tr id="vip-tr1">
            <td>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="text" size="60" id="vip-text1"/>
            </td>
            <td>
                <div id="vip-jRate1" style="height:30px;width: 100px;float:left"></div>
                <button id="vip-btn-click1" style="margin-left: 20px">重置</button>
                <input type="hidden" id="vip-star1" value="0"/>
            </td>
        </tr>
    <% } else {
        for (int i = 1; i<= tasks.size(); i++) {
            Task task = tasks.get(i-1);
            String content = task.getTask();

            String trId = "vip-tr" + i;
            String vipRateId = "vip-jRate" + i;
            String vipStarId = "vip-star" + i;
            String vipButtonId = "vip-btn-click" + i;
            %>
            <tr id="<%=trId%>">
                <td>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="text" size="60" id="vip-text<%=i%>" value="<%=content%>"/>
                </td>
                <td>
                    <div id="<%=vipRateId%>" style="height:30px;width: 100px;float:left"></div>
                    <button id="<%=vipButtonId%>" style="margin-left: 20px">重置</button>
                    <input id="<%=vipStarId%>" type="hidden" value="0"/>
                </td>
            </tr>
            <script type="text/javascript">
                $(function () {
                    options.onSet = function(rating) {
                        $("#<%=vipStarId%>").val(rating);
                    }
                    var viptoolitup = $("#<%=vipRateId%>").jRate(options);
                    $('#<%=vipButtonId%>').on('click', function() {
                        viptoolitup.setRating(0);
                    });
                });

            </script>

        <%
        }
    }%>



    <tr>
        <td colspan="2">2, 今日其它工作+</td>
    </tr>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" size="60"/>
        </td>
        <td>
            <div id="jRate2" style="height:30px;width: 100px;float:left"></div>
            <button id="btn-click2" style="margin-left: 20px">重置</button>
        </td>
    </tr>

    <tr>
        <td colspan="2">3, 下周工作计划+</td>
    </tr>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" size="60"/>
        </td>
        <td>
            <div id="jRate3" style="height:30px;width: 100px;float:left"></div>
            <button id="btn-click3" style="margin-left: 20px">重置</button>
        </td>
    </tr>

    <tr>
        <td colspan="2">4, 我的思考+</td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;
            <textarea rows="4" cols="92"></textarea>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="right"><button id="finish">保存</button></td>
    </tr>
</table>

</body>
</html>
