String.prototype.toTitleCase = function () {
  return this.split(' ').map(function (word) {
    return word.slice(0, 1).toUpperCase() + word.slice(1);
  }).join(' ');
}