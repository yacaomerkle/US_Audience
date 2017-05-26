Shiny.addCustomMessageHandler("jsondata",
  function(message){
    //var data= JSON.parse(message);
	var data= message;
	 console.log(data);

 
  var finalData = [];
  for(var i=0;i<data.length;i++){
    var tempData = {};
    tempData["State"] = data[i].State;
    var freq = {};
    var keys = Object.keys(data[i]);
    // console.log(keys);
    for(var j=1;j<keys.length;j++){
        var temp = keys[j];
        freq[temp] = parseInt(data[i][temp]);
    }
    tempData["freq"] = freq;
    finalData.push(tempData);

  }
  	 console.log(finalData);
  
  
  
  
  
  
  
  
  
  dashboard('#dashboard',finalData);


  })