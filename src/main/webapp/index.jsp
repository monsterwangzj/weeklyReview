<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<body>
<h1>工作日报</h1>

<head>
<script src="js/jquery.min.js"></script>
<script src="js/jRate.js"></script>

<script type="text/javascript">
    $(function () {
        var that = this;
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

        options.onSet = function(rating) {
            $("#vip-star1").val(rating);
        }
        var viptoolitup1 = $("#vip-jRate1").jRate(options);
        var toolitup2 = $("#jRate2").jRate(options);
        var toolitup3 = $("#jRate3").jRate(options);

        $('#vip-btn-click1').on('click', function() {
            viptoolitup1.setRating(0);
        });
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
            for (var i = 1; i <= vipNum; i++) {
                var textId = "vip-text" + i;
                var textValue = $("#" + textId).val();

                var starId = "vip-star" + i;
                var starValue = $("#" + starId).val();

                params += textId + "=" + textValue + "&" + starId + "=" + starValue;
                if (i < vipNum) {
                    params += "&";
                }
            }
            console.log(params);
            $.get("/weeklyreview/saveOrUpdateTask4Day.htmls?"+params, function(data) {
                console.log(data);
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
