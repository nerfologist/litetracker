// monkey patching Date for padded time
Date.prototype.toTidyDatetime = function () {
  "use strict";
  var timeString = ('0' + this.getHours()).slice(-2) + ':' +
                   ('0' + this.getMinutes()).slice(-2) + ':' +
                   ('0' + this.getSeconds()).slice(-2);
  
  return this.toLocaleDateString() + ', ' + timeString;
};

Date.prototype.toNaiveString = function () {
  return ('0' + (this.getMonth() + 1)).slice(-2) + '/' +
         ('0' + this.getDate()).slice(-2) + '/' +
         this.getFullYear()
};