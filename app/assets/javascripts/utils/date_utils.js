// monkey patching Date for padded time
Date.prototype.toTidyDatetime = function () {
  var timeString = ('0' + this.getHours()).slice(-2) + ':' +
                   ('0' + this.getMinutes()).slice(-2) + ':' +
                   ('0' + this.getSeconds()).slice(-2)
  
  return this.toLocaleDateString() + ', ' + timeString;
}