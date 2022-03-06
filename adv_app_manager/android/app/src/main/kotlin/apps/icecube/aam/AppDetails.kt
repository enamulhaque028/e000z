package apps.icecube.aam

import android.content.Context
import android.content.pm.PackageManager
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import com.google.gson.Gson

class AppDetails(var context:Context) {

    fun getPermissionList(packageName:String):String{
        val pm = this.context.packageManager.getPackageInfo(packageName,PackageManager.GET_PERMISSIONS);
        return Gson().toJson(pm);
    }

    fun getActivityList(packageName:String):String{
        val pm = this.context.packageManager.getPackageInfo(packageName,PackageManager.GET_ACTIVITIES);
        return Gson().toJson(pm);
    }

    fun getProviderList(packageName:String):String{
        val pm = this.context.packageManager.getPackageInfo(packageName,PackageManager.GET_PROVIDERS);
        return Gson().toJson(pm);
    }
    fun getReceiverList(packageName:String):String{
        val pm = this.context.packageManager.getPackageInfo(packageName,PackageManager.GET_RECEIVERS);
        return Gson().toJson(pm);
    }

    fun getSensorList():String{
        val sensorManager =  this.context.getSystemService(Context.SENSOR_SERVICE) as SensorManager;
        val deviceSensors: List<Sensor> = sensorManager.getSensorList(Sensor.TYPE_ALL)
        Log.d("sensor ",deviceSensors.size.toString())
        var sensorList = arrayListOf<SensorInfo>();
        for (item in deviceSensors){

            var id:Int = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                item.id
            } else {
                -1
            };

            sensorList.add(SensorInfo(
                    item.name,item.vendor,item.version,0,item.type,item.maximumRange,item.resolution,item.power,item.minDelay,item.fifoReservedEventCount,
                    item.fifoMaxEventCount,item.stringType,"",item.maxDelay,0, id));

        }
        return Gson().toJson(sensorList);
    }

}