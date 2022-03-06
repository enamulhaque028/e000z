package apps.icecube.aam

class SensorInfo(
        val mName: String, val mVendor: String,val mVersion:Int,val mHandle:Int,val mType:Int,val mMaxRange:Float,val mResolution:Float,
        val mPower:Float,val mMinDelay:Int,val mFifoReservedEventCount:Int,val mFifoMaxEventCount:Int,val mStringType: String?,val mRequiredPermission: String?,
        val mMaxDelay:Int, val mFlags:Int,val mId:Int
) {
    //public val mName: String? = null
    /*public val mVendor: String? = null
    public val mVersion = 0
    public val mHandle = 0
    public val mType = 0
    public val mMaxRange = 0f
    public val mResolution = 0f
    public val mPower = 0f
    public val mMinDelay = 0
    public val mFifoReservedEventCount = 0
    public val mFifoMaxEventCount = 0
    public val mStringType: String? = null
    public val mRequiredPermission: String? = null
    public val mMaxDelay = 0

    public val mFlags = 0
    public val mId = 0;*/
}