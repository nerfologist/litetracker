module.exports = {
    "env": {
        "browser": true
    },
    "extends": ["eslint:recommended", "plugin:backbone/recommended"],
    "rules": {
        "indent": [
            2,
            2,
            { "SwitchCase": 1 }
        ],
        "linebreak-style": [
            2,
            "unix"
        ],
        "quotes": [
            2,
            "single"
        ],
        "semi": [
            2,
            "always"
        ],
        "vars-on-top": 1
    },
    "globals": {
      "LiteTracker": false,
      "$": false,
      "JST": false
    }
};
