import QtQuick 2.5
import QtQml 2.2



QtObject
{
    property bool isShowTool: true
    property string conectedBlueName: "请先连接设备"

    property real designWidth: 390  // 基准屏幕宽度
    property real designHeight: 844 // 基准屏幕高度

    // 计算缩放比例（取宽高比例的最小值，保持元素比例不失真）
    property int winWidth: fields["winWidth"]
    property int winHeight: fields["winHeight"]
    readonly property real scaleRatio: Math.min(winWidth / designWidth, winHeight / designHeight)


    property variant isShowVoiceImg: fields["isShow"]
    property variant blueDataReal: fields["blueData"] //搜寻蓝牙列表
    property var codeData: fields["codeData"]  //扫码连接蓝牙名称

    property var electYa: fields["electYa"] //总电压
    property var electLiu: fields["electLiu"] //总电流
    property var cMos: fields["cMos"] //充电开关
    property var fMos: fields["fMos"] //放电开关
    property var junhengStatus: fields["junhengStatus"] //均衡状态
    property var mosTemperature: fields["mosTemperature"] //mos温度1
    property var temperature1: fields["temperature1"] //电池温度1
    property var temperature2: fields["temperature2"] //电池温度2
    property var temperature3: fields["temperature3"] //电池温度3
    property var remaining_capacity: fields["remaining_capacity"] //剩余容量
    property var balStatus: fields["balStatus"] //平衡状态
    property var afeStatus: fields["afeStatus"] //AFE状态
    property var alarmCount: fields["alarmCount"] //报警状态个数
    property var packStatus: fields["packStatus"] //电池状态
    property var secondYa: fields["secondYa"] //二次电压
    property var secondLiu: fields["secondLiu"] //二次电流
    property var secondTemperature: fields["secondTemperature"] //二次温度
    property var mainVer: fields["mainVer"] //主版本
    property var subVer: fields["subVer"] //次版本
    property var soc: fields["soc"] //总电量
    property var soh: fields["soh"] //健康度
    property var rtcY: fields["rtcY"] //rtc年月
    property var rtcM: fields["rtcM"] //rtc年月
    property var rtcD: fields["rtcD"] //rtc日时
    property var rtcH: fields["rtcH"] //rtc日时
    property var rtcM1: fields["rtcM1"] //rtc分秒
    property var rtcS: fields["rtcS"] //rtc分秒
    property var celllType: fields["celllType"] //电池类型
    property var cellNum: fields["cellNum"] //电池串数
    property var afeNum: fields["afeNum"] //模拟前端代号
    property var cusNum: fields["cusNum"] //客户代号
    property var cycles_number: fields["cycles_number"] //循环次数
    property var fcc: fields["fcc"] //满充容量
    property var dc: fields["dc"] //设计容量
    property var maxNoElect: fields["maxNoElect"] //最大的未充电间隔时间
    property var majNoElect: fields["majNoElect"] //最近的未充电间隔时间
    property var functionConfig: fields["functionConfig"] //功能开关配置寄存器
    property var cellVlist: fields["cellVlist"] //功能开关配置寄存器
    property var protectMap: fields["protectMap"]

    property var yaCha: fields["yaCha"]
    property var maxYa: fields["maxYa"]
    property var minYa: fields["minYa"]

    property var vob: fields["VOB"]
    property var bald: fields["BALD"]
    property var balt: fields["BALT"]
    property var ov: fields["OV"]
    property var ovr: fields["OVR"]
    property var uv: fields["UV"]
    property var uvr: fields["UVR"]
    property var uvt: fields["UVT"]
    property var ocd1: fields["OCD1"]
    property var ocd2: fields["OCD2"]
    property var ocd1t: fields["OCD1T"]
    property var ocd2t: fields["OCD2T"]
    property var dbYa: fields["dbYa"]
    property var sct: fields["SCT"]
    property var occ: fields["OCC"]
    property var occt: fields["OCCT"]

    property var eYa: fields["eYa"]
    property var eLiu: fields["eLiu"]
    property var mYa: fields["mYa"]
    property var mcLiu: fields["mcLiu"]
    property var manYshi: fields["manYshi"]
    property var sleepDelay: fields["SleepDelay"]
    property var shutDownDelay: fields["ShutDownDelay"]
    property var sampleRValue: fields["SampleRValue"]
    property var lingYuzhi: fields["lingYuzhi"]


    property var otc: fields["OTC"]
    property var otcr: fields["OTCR"]
    property var utc: fields["UTC"]
    property var utcr: fields["UTCR"]
    property var otd: fields["OTD"]
    property var otdr: fields["OTDR"]
    property var utd: fields["UTD"]
    property var utdr: fields["UTDR"]
    property var motd: fields["MOTD"]
    property var motdr: fields["MOTDR"]


    property var bt: fields["bt"]
    property var mnfDate: fields["mnfDate"]
    property var customerMode: fields["customerMode"]
    property var customerName: fields["customerName"]
    property var manufacturerMode: fields["manufacturerMode"]
    property var manufacturer: fields["manufacturer"]
    property var sjCirCount: fields["sjCirCount"]
    property var sn: fields["sn"]
    property var alarmMsgList: fields["alarmlMsgList"]
    property var afeList: fields["afeList"]
    property var statusMsgList: fields["statusMsgList"]
    property int itemIndex: -1


    property var operaCode: fields["operaCode"]
    property var version: fields["version"]
    property var temType: 0
    property var currentPageIndex: 0
    property var isConnected: false
    property bool setPassFlag: true
    property bool setPassFlag2: true
    property bool isChinese: true
    // 动态缩放函数
    function scaled(value)
    {
        return value * scaleRatio;
    }
    function startSearch()
    {
        var data = {}
        putOp("start.search.blue", data)
    }
    function sendToBlue(type)
    {
        var data = {}
        data["type"] = type
        putOp("send.to.blue", data)
    }
    function writeToBlue(type, v)
    {
        var data = {}
        data["type"] = type
        data["startAddr"] = type
        data["inputData"] = v
        putOp("send.to.blue", data)
    }

    function sendCodeData(codeData, type)
    {
        var data = {}
        data["codeData"] = codeData
        data["type"] = type
        putOp("send.codeData", data)
    }
    function connectBlue(addr)
    {
        var data = {}
        data["addr"] = addr
        putOp("connect.blue", data)
    }
    function getProtectMessage(type)
    {
        var data = {}
        data["type"] = type // 1代表单体电压
        putOp("get.protectMsg", data)
    }
    function closeApp()
    {
        var data = {}
        putOp("close.app", data)
    }
    function timerGetData(type)
    {
        var data = {}
        data["type"] = type
        putOp("get.timerData", data)
    }
}
