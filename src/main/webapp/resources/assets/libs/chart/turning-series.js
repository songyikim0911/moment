$(function() {
    var datasets = {
        "usa": {
            label: "신규 가입자 수",
            data: [
                [1, 30],
                [2, 35],
                [3, 20],
                [4, 21],
                [5, 50],
                [6, 70],
                [7, 64],
                [8, 12],
                [9, 13],
                [10, 30],
                [11, 20],
                [12, 33],
                [13, 55],
                [14, 22],
                [15, 23],
                [16, 13],
                [17, 51],
                [18, 38],
                [19, 92]
            ]
        },
        "russia": {
            label: "신규 게시물 수",
            data: [
                [1, 48],
                [2, 47],
                [3, 45],
                [4, 40],
                [5, 42],
                [6, 40],
                [7, 37],
                [8, 35],
                [9, 33],
                [10, 33],
                [11, 32],
                [12, 32],
                [13, 34],
                [14, 34],
                [15, 38],
                [16, 44],
                [17, 48],
                [18, 50],
                [19, 52]
            ]
        },
        "uk": {
            label: "리마인딩 신청 수",
            data: [
                [1, 39],
                [2, 90],
                [3, 76],
                [4, 19],
                [5, 47],
                [6, 23],
                [7, 78],
                [8, 73],
                [9, 79],
                [10, 61],
                [11, 86],
                [12, 94],
                [13, 21],
                [14, 49],
                [15, 73],
                [16, 81],
                [17, 45],
                [18, 46],
                [19, 69]
            ]
        },
        "germany": {
            label: "일 누적 접속자 수",
            data: [
                [1, 483],
                [2, 479],
                [3, 457],
                [4, 401],
                [5, 424],
                [6, 402],
                [7, 377],
                [8, 357],
                [9, 337],
                [10, 336],
                [11, 328],
                [12, 329],
                [13, 342],
                [14, 344],
                [15, 387],
                [16, 440],
                [17, 480],
                [18, 504],
                [19, 528]
            ]
        }
    };
   /* var dataSet = [
    {label: "USA", color: "#005CDE" },
    {label: "Russia", color: "#005CDE" },
    { label: "UK", color: "#00A36A" },
    { label: "Germany", color: "#7D0096" },
    { label: "Denmark", color: "#992B00" },
    { label: "Sweden", color: "#DE000F" },
    { label: "Norway", color: "#ED7B00" }    
];*/
    // hard-code color indices to prevent them from shifting as
    // countries are turned on/off
    var i = 0;
    $.each(datasets, function(key, val) {
        val.color = i;
        ++i;
    });

    // insert checkboxes 
    var choiceContainer = $("#choices");
    $.each(datasets, function(key, val) {
        choiceContainer.append('<input type="checkbox" name="' + key +
            '" checked="checked" id="id' + key + '">' +
            '<label for="id' + key + '">' +
            val.label + '</label>');
    });
    choiceContainer.find("input").click(plotAccordingToChoices);


    function plotAccordingToChoices() {
        var data = [];

        choiceContainer.find("input:checked").each(function() {
            var key = $(this).attr("name");
            if (key && datasets[key])
                data.push(datasets[key]);
        });

        if (data.length > 0)
            $.plot($("#placeholder"), data, {
                yaxis: { min: 0 },
                xaxis: { tickDecimals: 0 }
            });
    }

    plotAccordingToChoices();
});