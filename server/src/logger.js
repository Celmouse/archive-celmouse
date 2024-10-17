"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createLogger = createLogger;
const winston_1 = require("winston");
function createLogger(module) {
    return (0, winston_1.createLogger)({
        level: 'info',
        format: winston_1.format.combine(winston_1.format.timestamp(), winston_1.format.printf(({ timestamp, level, message }) => {
            return `${timestamp} [${module}] ${level}: ${message}`;
        })),
        transports: [
            new winston_1.transports.Console(),
            new winston_1.transports.File({ filename: 'app.log' }),
        ],
    });
}
//# sourceMappingURL=logger.js.map