"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getIp = getIp;
var os_1 = require("os");
var nets = (0, os_1.networkInterfaces)();
var results = Object.create(null);
function getIp() {
    var _a;
    for (var _i = 0, _b = Object.keys(nets); _i < _b.length; _i++) {
        var name_1 = _b[_i];
        for (var _c = 0, _d = (_a = nets[name_1]) !== null && _a !== void 0 ? _a : []; _c < _d.length; _c++) {
            var net = _d[_c];
            var familyV4Value = typeof net.family === 'string' ? 'IPv4' : 4;
            if (net.family === familyV4Value && !net.internal) {
                if (!results[name_1]) {
                    results[name_1] = [];
                }
                results[name_1].push(net.address);
            }
        }
    }
    return results.en0[0];
}
//# sourceMappingURL=ifconfig.js.map