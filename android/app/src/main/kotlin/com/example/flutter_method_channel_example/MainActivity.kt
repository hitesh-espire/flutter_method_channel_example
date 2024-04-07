package com.example.flutter_method_channel_example
import android.os.Bundle
import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import android.os.BatteryManager
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine){
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
    call, result ->
    if(call.method == "getBatteryLevel"){
    val batteryLevel = getBatteryLevel()
    if(batteryLevel != -1){
    result.success(batteryLevel)
    }else{
    result.error("UNAVAILABLE", "Battery level not available.", null)
    }
    }else{
    result.notImplemented()
    }
    
    }
    }
    private fun getBatteryLevel(): Int{
    val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}