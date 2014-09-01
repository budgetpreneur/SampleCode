@ECHO OFF

"C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" demoutest.sln /t:rebuild

del /Q /S "demoappx\*.*"
xcopy /E /Y "demoutest\bin\Debug\*.*" "demoappx"
copy /Y "C:\Program Files (x86)\Microsoft SDKs\Windows\v8.0\ExtensionSDKs\TestPlatform\11.0\Redist\CommonConfiguration\neutral\*.*" "demoappx"
REM copy /Y "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\PublicAssemblies\Microsoft.VisualStudio.QualityTools.UnitTestFramework.dll" "demoappx"

REM copy /Y "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\ReferenceAssemblies\v2.0\Microsoft.VisualStudio.QualityTools.UnitTestFramework.dll" "demoappx"
REM copy /Y "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.discoveryengine.*" "C:\Pandu\pubnub\win80appx"

"C:\Program Files (x86)\Windows Kits\8.0\bin\x86\makeappx.exe" pack /v /d "demoappx" /l /p "demoappx\demoutest_Test.appx"

"C:\Program Files (x86)\Windows Kits\8.0\bin\x86\makecert.exe" -r -pe -ss SelfCertStore -sv demoutest.pvk -n "CN=DemoUser" demoutest.cer
del /Q demoutest.Test_Key.pfx
"C:\Program Files (x86)\Windows Kits\8.0\bin\x86\pvk2pfx.exe" -pvk demoutest.pvk -spc demoutest.cer -pfx "demoutest.Test_Key.pfx"

certutil.exe -addstore root demoutest.cer

"C:\Program Files (x86)\Windows Kits\8.0\bin\x86\signtool.exe" sign /fd sha256 /f "demoutest.Test_Key.pfx" "demoappx\demoutest_Test.appx"


"C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" demoappx\demoutest_Test.appx /InIsolation /Logger:Console /UseVsixExtensions:true /Platform:x86 /Framework:Framework45

certutil.exe -delstore -user root demoutest.cer

ECHO Done

