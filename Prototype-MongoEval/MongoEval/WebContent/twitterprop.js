
function selectKeyword(elm) {
	var key = $(elm).html();
	$("#keyword").html(key);
}

function sendOpts() {
	
	var flds = $('#flds :selected').val();
	var conn = $('#conn :selected').val();
	var ops = $('#ops :selected').val();
	console.log(flds);
	
	$.post("/MongoEval/getCharts", {
			"fc" : flds,
			"tgt" : ops
		}, function(data) {
			console.log(data);
			$('#displayDiv').jqChart({
                title: { text: 'R-W-U Measurements' },
                animation: { duration: 2 },
                shadows: {
                    enabled: true
                },
                series: data[0]
            });
			$('#displayDiv').show();

			$('#displayDiv2').jqChart({
                title: { text: 'Throughput' },
                animation: { duration: 2 },
                shadows: {
                    enabled: true
                },
                series: data[1]
            });
			$('#displayDiv2').show();

		}, "json");
		
		
	}



