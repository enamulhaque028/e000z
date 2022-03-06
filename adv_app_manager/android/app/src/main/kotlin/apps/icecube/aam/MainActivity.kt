package apps.icecube.aam

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.aos.aam/appinfo";



    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                Log.d("METHOD CALL ",call.method);
                if(call.method=="getPermissionList"){
                    var appDetails:AppDetails = AppDetails(this);
                    val packageName:String? = call.argument("packageName");
                    result.success(appDetails.getPermissionList(packageName.orEmpty()))
                }else if(call.method=="getActivityList"){
                    var appDetails:AppDetails = AppDetails(this);
                    val packageName:String? = call.argument("packageName");
                    result.success(appDetails.getActivityList(packageName.orEmpty()))
                }else if(call.method=="getProviderList"){
                    var appDetails:AppDetails = AppDetails(this);
                    val packageName:String? = call.argument("packageName");
                    result.success(appDetails.getProviderList(packageName.orEmpty()))
                }else if(call.method=="getReceiverList"){
                    var appDetails:AppDetails = AppDetails(this);
                    val packageName:String? = call.argument("packageName");
                    result.success(appDetails.getReceiverList(packageName.orEmpty()))
                }else if(call.method=="getSensorList"){
                    var appDetails:AppDetails = AppDetails(this);
                    result.success(appDetails.getSensorList());
                }



        }
    }

}
