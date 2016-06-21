#!/usr/bin/node

var fs = require('fs');
var path = require('path');

fs.readdir("output", function(err, files) {
    var product = {
        type: "soichih/fits",
        files: [
        ]
    };
    files.forEach(function(file) {
        var ext = path.extname(file);
        if(ext == ".fits" || ext == ".fz") {
            var stats = fs.statSync("output/"+file);
            product.files.push({size: stats.size, filename: "output/"+file});
        }
    });

    fs.writeFile("products.json", JSON.stringify([product]), function(err) {
        if(err) throw err;
        //done!
    });    
});


