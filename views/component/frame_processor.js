// 后台线程检测是否应该触发捕获
WorkerScript.onMessage = function(message) {
    const now = Date.now();
    if (message.requestCapture && (now - this.lastCaptureTime > 1500)) {
        this.lastCaptureTime = now;
        WorkerScript.sendMessage({ shouldCapture: true });
    }
}
