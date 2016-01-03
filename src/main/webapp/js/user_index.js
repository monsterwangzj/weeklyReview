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

/**
 * 行操作封装
 *
 * @param vipNum
 * @param jRateId
 * @param vipStarId
 * @param vipButtonId
 * @param vipDeleteId
 * @param trId
 * @param taskIdText
 */
var vipFunc = function (vipNum, jRateId, vipStarId, rateValue, vipButtonId, vipDeleteId, trId, taskIdText) {
    options.onSet = function (rating) {
        $('#' + vipStarId).val(rating);
    }

    var viptoolitup = $('#' + jRateId).jRate(options);
    viptoolitup.setRating(rateValue);
    $('#' + vipButtonId).on('click', function () {
        viptoolitup.setRating(0);
    });

    $('#' + vipDeleteId).on('click', function () {
        var tUrl = "/weeklyreview/removeTask.htmls";
        var params = {"id": taskIdText};
        $.ajax({
            url: tUrl,
            data: params,
            type: "post",
            dataType: "json",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            timeout: 10000,
            success: function (data) {
                console.log(data);
                $('#' + trId).remove();
            }
        });
    });
};

var addSaveParam = function(prefix, elementCount, params) {
    params[prefix + "Count"] = elementCount;

    for (var i = 1; i <= elementCount; i++) {
        var id = prefix + "-id" + i;
        var idValue = $("#" + id).val();

        var textId = prefix + "-text" + i;
        var textValue = $("#" + textId).val();

        var starId = prefix + "-star" + i;
        var starValue = $("#" + starId).val();

        params[id] = idValue;
        params[textId] = textValue;
        params[starId] = starValue;
    }
    return params;
}

// 保存按钮
var finishOnClicked = function (dateInt, vipNum, otherNum, nextWeekNum, myThinkNum) {
    // 收集参数列表
    var params2 = {"uid": 1, "dateInt":dateInt};

    params2 = addSaveParam(dateInt +"-vip", vipNum, params2);
    params2 = addSaveParam(dateInt +"-other", otherNum, params2);
    params2 = addSaveParam(dateInt +"-nextWeek", nextWeekNum, params2);
    params2 = addSaveParam(dateInt +"-myThink", myThinkNum, params2);
    var tUrl = "/weeklyreview/saveOrUpdateTask4Day.htmls";
    $.ajax({
        url: tUrl,
        data: params2,
        type: "post",
        dataType: "json",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        timeout: 10000,
        success: function(data) {
            console.log(data);

            // 刷新当前页面
            window.location.reload();
        }
    });
}

/**
 * 添加任务函数
 */
var addTaskFunc = function(prefix, num) {
    var lastTrId = prefix + "-tr" + num;
    if (prefix.indexOf('vip')) {
        lastTrId = prefix + "-tr" + num;
        num++;
    } else if (prefix.indexOf( 'other')) {
        lastTrId = prefix + "-tr" + num;
        num++;
    } else if (prefix.indexOf('nextWeek')) {
        lastTrId = prefix + "-tr" + num;
        num++;
    } else if (prefix.indexOf('myThink')) {
        lastTrId = prefix + "-tr" + num;
        num++;
    }

    var textId = prefix + "-text" + num;
    var jRateId = prefix + "-jRate" + num;
    var buttonId = prefix + "-btn-click" + num;
    var trid = prefix + "-tr" + num;
    var starId = prefix + "-star" + num;
    var content = "<tr id='" + trid + "'> <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' size='60' id='" + textId +"'/> </td> <td><div id='" + jRateId + "' style='height:30px;width: 100px;float:left'></div><button id='" + buttonId + "' style='margin-left: 20px'>重置</button><input id='" + starId + "' type='hidden' value=''/></td><td><button id='vip-btn-delete1' style='margin-left: 20px'>删除</button> </td></tr>";
    $("#"+lastTrId).after(content);
    lastTrId = trid;

    options.onSet = function(rating) {
        $("#" + starId).val(rating);
    };
    var toolitup = $("#" + jRateId).jRate(options);
    $("#" + buttonId).on('click', function () {
        toolitup.setRating(0);
    });
}

/**
 * 添加我的思考任务函数
 */
var addMyThinkTaskFunc = function(prefix) {
    var num = 0;
    var lastTrId = prefix + "-tr" + num;
    if (prefix == 'myThink') {
        num = myThinkNum;
        lastTrId = prefix + "-tr" + num;
        myThinkNum++;
        num++;
    }

    var textId = prefix + "-text" + num;
    var trid = prefix + "-tr" + num;
    var deleteId = prefix + "-btn-delete" + num;
    var content = "<tr id='" + trid + "'><td colspan='2'>&nbsp;&nbsp;&nbsp;&nbsp;<textarea id='" + textId + "' rows='4' cols='92'></textarea></td><td><button id='" + deleteId + "' style='margin-left: 20px'>删除</button></td></tr>";
    $("#"+lastTrId).after(content);
    lastTrId = trid;
}
