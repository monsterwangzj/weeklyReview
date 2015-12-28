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

// 保存按钮
var finishOnClicked = function (vipNum) {
    // 收集参数列表
    var params2 = {"uid": 1, "vipCount": vipNum};
    for (var i = 1; i <= vipNum; i++) {
        var id = "id" + i;
        var idValue = $("#" + id).val();

        var textId = "vip-text" + i;
        var textValue = $("#" + textId).val();

        var starId = "vip-star" + i;
        var starValue = $("#" + starId).val();

        params2[id] = idValue;
        params2[textId] = textValue;
        params2[starId] = starValue;
    }
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
        }
    });
}